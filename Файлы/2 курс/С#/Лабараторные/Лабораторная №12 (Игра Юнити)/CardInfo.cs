using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using TMPro;

public class CardInfo : MonoBehaviour
{
    public Card SelfCard;
    public CardManager cardManager;
    public Image Logo;
    public Sprite back;

    public void HideCardInfo(Card card)
    {
        SelfCard = card;

        //ShowCardInfo(card);

        Logo.sprite = back;
    }
    
    public void ShowCardInfo(Card card)
    {
        SelfCard = card;

        Logo.sprite = card.Logo;
        Logo.preserveAspect = true;
    }

    public int GetPoint(Card card)
    {
        int point = card.Point;

        return point;
    }


    private void Start()
    {
        //cardManager = Camera.main.GetComponent<CardManager>();

        //ShowCardInfo(cardManager.AllCards[transform.GetSiblingIndex()]);
    }
}
