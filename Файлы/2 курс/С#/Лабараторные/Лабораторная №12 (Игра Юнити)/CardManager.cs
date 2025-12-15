using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

[System.Serializable]
public class Card
{
    public string Suit;
    public Sprite Logo;
    public int Point;
}

//public static class CardManager
//{
   // public static List<Card> AllCards = new List<Card>();
//}

public class CardManager : MonoBehaviour
{
    public List<Card> AllCards = new List<Card>();
}
