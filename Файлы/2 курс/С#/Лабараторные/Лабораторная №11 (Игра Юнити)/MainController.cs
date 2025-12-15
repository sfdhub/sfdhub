using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MainController : MonoBehaviour
{
    [SerializeField]
    private Table table;

    [SerializeField]
    private Raycaster raycaster;
    public GameObject gameObject;

    void Start()
    {
        raycaster.OnCellHit += Raycaster_OnCellHit;
        table.OnMoveComplete += Table_OnMoveComplete;

        table.Generate();
    }
    private void Table_OnMoveComplete()
    {
        raycaster.Locked=false;

        if (table.IsSolved())
        {
            /*winWindow.Show();
            winWindow.OnNext += () => */
            //table.Generate();

            table.Clear();
            gameObject.SetActive(true);
        }
    }
    private void Raycaster_OnCellHit(Cell cell)
    {
        raycaster.Locked = table.TryMove(cell);
    }

}
