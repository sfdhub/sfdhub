using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.EventSystems;

public enum FieldType
{
    SELF_HAND,
    SELF_FIELD,
    ENEMY_HAND,
    ENEMY_FIELD
}

public class DropPlace : MonoBehaviour, IDropHandler, IPointerEnterHandler, IPointerExitHandler
{
    public FieldType Type;
    
    public void OnDrop(PointerEventData eventData)
    {
        if (Type != FieldType.SELF_FIELD)
            return;
        
        CardMovement card = eventData.pointerDrag.GetComponent<CardMovement>();


        if (card.GameManager.IsPlayerTurn)
        {
            if (card && card.GameManager.PlayerFieldCards.Count < 6 && (card.GameManager.PlayerFieldCards.Count == 0 || Points(card)))
            {
                card.GameManager.PlayerHandCards.Remove(card.GetComponent<CardInfo>());
                card.GameManager.PlayerFieldCards.Add(card.GetComponent<CardInfo>());

                card.DefaultParent = transform;
            }
        }
        else
        {
            if (card && card.GameManager.PlayerFieldCards.Count < card.GameManager.EnemyFieldCards.Count)
            {
                card.GameManager.PlayerHandCards.Remove(card.GetComponent<CardInfo>());
                card.GameManager.PlayerFieldCards.Add(card.GetComponent<CardInfo>());

                card.DefaultParent = transform;
            }
        }
    }

    bool Points(CardMovement card)
    {
        bool answer = false;
        int count = card.GameManager.PlayerFieldCards.Count;

        int countEn = card.GameManager.EnemyFieldCards.Count;

        for (int i = 0; i < count; i++)
        {
            if (card.GetComponent<CardInfo>().SelfCard.Point == card.GameManager.PlayerFieldCards[i].SelfCard.Point)
                answer = true;

            if (card.GetComponent<CardInfo>().SelfCard.Point -1300 == card.GameManager.PlayerFieldCards[i].SelfCard.Point)
                answer = true;

            if (card.GetComponent<CardInfo>().SelfCard.Point == card.GameManager.PlayerFieldCards[i].SelfCard.Point - 1300)
                answer = true;
        }

        for (int i = 0; i < countEn; i++)
        {
            if (card.GetComponent<CardInfo>().SelfCard.Point == card.GameManager.EnemyFieldCards[i].SelfCard.Point)
                answer = true;

            if (card.GetComponent<CardInfo>().SelfCard.Point - 1300 == card.GameManager.EnemyFieldCards[i].SelfCard.Point)
                answer = true;

            if (card.GetComponent<CardInfo>().SelfCard.Point == card.GameManager.EnemyFieldCards[i].SelfCard.Point - 1300)
                answer = true;
        }

        return answer;
    }

    public void OnPointerEnter(PointerEventData eventData)
    {
        if (eventData.pointerDrag == null || Type == FieldType.ENEMY_HAND ||
            Type == FieldType.ENEMY_FIELD || Type == FieldType.SELF_HAND)
            return;

        //CardMovement card = eventData.pointerDrag.GetComponent<CardMovement>();
        //if (card.GameManager.PlayerFieldCards.Count > 0 && card.GetComponent<CardInfo>().Point < )
        //{

        //}

        CardMovement card = eventData.pointerDrag.GetComponent<CardMovement>();

        if (card)
            card.DefaultTempCardParent = transform;
    }

    public void OnPointerExit(PointerEventData eventData)
    {
        if (eventData.pointerDrag == null)
            return;

        CardMovement card = eventData.pointerDrag.GetComponent<CardMovement>();

        if (card && card.DefaultTempCardParent == transform)
            card.DefaultTempCardParent = card.DefaultParent;
    }
}
