using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using TMPro;
using UnityEngine.SceneManagement;


public class Game
{
    public List<Card> Deck;

    public CardManager cardManager;

    public Game()
    {
        Deck = GiveDeckCard();
    }

    List<Card> GiveDeckCard()
    {
        cardManager = Camera.main.GetComponent<CardManager>();
        List<Card> list = new List<Card>();

        for (int i = 0; i < 36; i++)
            list.Add(cardManager.AllCards[i]);

        System.Random rand = new System.Random();
        for (int i = list.Count - 1; i >= 1; i--)
        {
            int j = rand.Next(i + 1);

            Card tmp = list[j];
            list[j] = list[i];
            list[i] = tmp;
        }

        return list;
    }
}

public class GameManagerScr : MonoBehaviour
{
    public Game CurrentGame;
    public Transform EnemyHand;
    public Transform PlayerHand;
    public Transform EnemyField;
    public Transform PlayerField;
    public GameObject CardPref;

    public GameObject WinPanel;
    public GameObject LosePanel;

    public GameObject ActivePlayer;
    public GameObject ActiveEnemy;

    Card trump;
    int bitten = 0;
    int Turn;
    int TurnTime = 30;
    public TextMeshProUGUI TurnTimeTxt;
    public TextMeshProUGUI CountCards;
    public Button EndTurnBtn;
    public Button PassBtn;
    public Button TakeBtn;

    public List<CardInfo> PlayerHandCards = new List<CardInfo>();
    public List<CardInfo> EnemyHandCards = new List<CardInfo>();
    public List<CardInfo> PlayerFieldCards = new List<CardInfo>();
    public List<CardInfo> EnemyFieldCards = new List<CardInfo>();

    public Image Trump;

    public TextMeshProUGUI EnemyDialog;

    public bool IsPlayerTurn
    {
        get
        {
            return Turn % 2 == 0;
        }
    }
    bool take = false;

    void Start()
    {
        Turn = 0;

        CurrentGame = new Game();

        trump = CurrentGame.Deck[27];
        Trump.sprite = trump.Logo;
        for (int i = 0; i < 36; i++)
        {
            if (CurrentGame.Deck[i].Suit == trump.Suit)
            {
                CurrentGame.Deck[i].Point += 1300;
            }
        }

        EndTurnBtn.interactable = true;
        TakeBtn.interactable = false;
        PassBtn.interactable = true;

        GiveHandCards(CurrentGame.Deck, EnemyHand);
        GiveHandCards(CurrentGame.Deck, PlayerHand);

        StartCoroutine(TurnFunc());
    }

    void Update()
    {
        CountCards.text = CurrentGame.Deck.Count.ToString();

        PassBtn.interactable = take;

        if (IsPlayerTurn)
        {
            int count = PlayerFieldCards.Count;
            int countEn = EnemyHandCards.Count;

            if (!take)
            {
                for (int i = bitten; i < count; i++)
                {
                    for (int j = 0; j < countEn; j++)
                    {
                        if (PlayerFieldCards[i].SelfCard.Point < EnemyHandCards[j].SelfCard.Point && (PlayerFieldCards[i].SelfCard.Suit == EnemyHandCards[j].SelfCard.Suit || EnemyHandCards[j].SelfCard.Suit == trump.Suit))
                        {
                            CardInfo hod = EnemyHandCards[j];

                            for (int k = 0; k < countEn; k++)
                            {
                                if (PlayerFieldCards[i].SelfCard.Point < EnemyHandCards[k].SelfCard.Point && (PlayerFieldCards[i].SelfCard.Suit == EnemyHandCards[k].SelfCard.Suit || EnemyHandCards[k].SelfCard.Suit == trump.Suit))
                                {
                                    if (hod.SelfCard.Point > EnemyHandCards[k].SelfCard.Point)
                                    {
                                        hod = EnemyHandCards[k];
                                    }
                                }
                            }

                            bitten++;

                            hod.ShowCardInfo(hod.SelfCard);
                            hod.transform.SetParent(EnemyField);

                            EnemyFieldCards.Add(hod);
                            EnemyHandCards.Remove(hod);

                            j = countEn;
                        }
                    }
                }
            }
            
            if (bitten < count)
            {
                EnemyDialog.text = "Беру";
                EndTurnBtn.interactable = false;
                take = true;
            }
        }
        else
        {
            int count = PlayerFieldCards.Count;
            int countEn = EnemyFieldCards.Count;
            int countEnH = EnemyHandCards.Count;

            if (count == countEn)
            {
                for (int i = 0; i < countEn; i++)
                {
                    if (PlayerFieldCards[i].SelfCard.Point <= EnemyFieldCards[i].SelfCard.Point || (PlayerFieldCards[i].SelfCard.Suit != EnemyFieldCards[i].SelfCard.Suit && PlayerFieldCards[i].SelfCard.Suit != trump.Suit))
                    {
                        PlayerFieldCards[i].ShowCardInfo(PlayerFieldCards[i].SelfCard);
                        PlayerFieldCards[i].transform.SetParent(PlayerHand);

                        PlayerHandCards.Add(PlayerFieldCards[i]);
                        PlayerFieldCards.Remove(PlayerFieldCards[i]);

                        return;
                    }
                }
            }

            for (int i = 0; i < count; i++)
            {
                for (int j = 0; j < countEnH; j++)
                {
                    if (PlayerFieldCards[i].SelfCard.Point == EnemyHandCards[j].SelfCard.Point && EnemyHandCards[j].SelfCard.Suit != trump.Suit || PlayerFieldCards[i].SelfCard.Point - 1300 == EnemyHandCards[j].SelfCard.Point)
                    {
                        EnemyHandCards[j].ShowCardInfo(EnemyHandCards[j].SelfCard);
                        EnemyHandCards[j].transform.SetParent(EnemyField);

                        EnemyFieldCards.Add(EnemyHandCards[j]);
                        EnemyHandCards.Remove(EnemyHandCards[j]);
                    }
                }
            }

            count = PlayerFieldCards.Count;
            countEn = EnemyFieldCards.Count;
            countEnH = EnemyHandCards.Count;

            for (int i = 0; i < countEn; i++)
            {
                for (int j = 0; j < countEnH; j++)
                {
                    if (EnemyFieldCards[i].SelfCard.Point == EnemyHandCards[j].SelfCard.Point && EnemyHandCards[j].SelfCard.Suit != trump.Suit)
                    {
                        EnemyHandCards[j].ShowCardInfo(EnemyHandCards[j].SelfCard);
                        EnemyHandCards[j].transform.SetParent(EnemyField);

                        EnemyFieldCards.Add(EnemyHandCards[j]);
                        EnemyHandCards.Remove(EnemyHandCards[j]);
                    }
                }
            }

            count = PlayerFieldCards.Count;
            countEn = EnemyFieldCards.Count;
            countEnH = EnemyHandCards.Count;

            if (count == countEn && countEn != 0)
            {
                EnemyDialog.text = "Бито";
                StartCoroutine(Wait());
            }
        }

        if (CurrentGame.Deck.Count == 0)
        {
            if (PlayerHandCards.Count == 0)
            {
                Win();
            }
            if (EnemyHandCards.Count == 0)
            {
                Lose();
            }
        }
    }

    IEnumerator Wait()
    {
        yield return new WaitForSeconds(2);

        Bit();
    }

    void Win()
    {
        StopAllCoroutines();

        WinPanel.SetActive(true);
    }

    void Lose()
    {
        StopAllCoroutines();

        LosePanel.SetActive(true);
    }

    void GiveHandCards (List<Card> deck, Transform hand)
    {
        int i = 0;
        while (i++ < 6)
            GiveCardToHand(deck, hand);
    }

    void GiveCardToHand(List<Card> deck, Transform hand)
    {
        if (deck.Count == 0)
            return;

        Card card = deck[0];

        GameObject cardGO = Instantiate(CardPref, hand, false);

        if (hand == EnemyHand)
        {
            cardGO.GetComponent<CardInfo>().HideCardInfo(card);
            EnemyHandCards.Add(cardGO.GetComponent<CardInfo>());
        }
        else
        {
            cardGO.GetComponent<CardInfo>().ShowCardInfo(card);
            PlayerHandCards.Add(cardGO.GetComponent<CardInfo>());
        }

        deck.RemoveAt(0);
    }

    IEnumerator TurnFunc()
    {
        TurnTime = 30;
        TurnTimeTxt.text = TurnTime.ToString();

        if (IsPlayerTurn)
        {
            while(TurnTime-- > 0)
            {
                TurnTimeTxt.text = TurnTime.ToString();
                yield return new WaitForSeconds(1);
            }
        }
        else
        {
            while (TurnTime-- > 27)
            {
                TurnTimeTxt.text = TurnTime.ToString();
                yield return new WaitForSeconds(1);
            }

            if (EnemyHand.childCount > 0)
                EnemyTurn(EnemyHandCards);
        }

        //ChangeTurn();
    }

    void EnemyTurn(List<CardInfo> cards)
    {
        int count = cards.Count;

        CardInfo hod = cards[0];

        for (int i = 0; i < count; i++)
        {
            if (cards[i].SelfCard.Point < hod.SelfCard.Point)
            {
                hod = cards[i];
            }
        }

        hod.ShowCardInfo(hod.SelfCard);
        hod.transform.SetParent(EnemyField);

        EnemyFieldCards.Add(hod);
        EnemyHandCards.Remove(hod);
    }

    public void ChangeTurn()
    {
        StopAllCoroutines();

        EnemyDialog.text = "...";
        take = false;
        Turn++;

        //
        bitten = 0;
        // dont forget

        EndTurnBtn.interactable = IsPlayerTurn;
        TakeBtn.interactable = !IsPlayerTurn;
        PassBtn.interactable = IsPlayerTurn;

        ActivePlayer.SetActive(IsPlayerTurn);
        ActiveEnemy.SetActive(!IsPlayerTurn);

        if (CurrentGame.Deck.Count != 0)
            GiveNewCards();

        StartCoroutine(TurnFunc());
    }

    void GiveNewCards()
    {
        int count = PlayerHand.childCount;

        if (IsPlayerTurn)
        {
            if (PlayerHand.childCount < 6)
                while (PlayerHand.childCount < 6 && CurrentGame.Deck.Count != 0)
                    GiveCardToHand(CurrentGame.Deck, PlayerHand);

            if (EnemyHand.childCount < 6)
                while (EnemyHand.childCount < 6 && CurrentGame.Deck.Count != 0)
                    GiveCardToHand(CurrentGame.Deck, EnemyHand);
        }
        else
        {
            if (EnemyHand.childCount < 6)
                while (EnemyHand.childCount < 6 && CurrentGame.Deck.Count != 0)
                    GiveCardToHand(CurrentGame.Deck, EnemyHand);

            if (PlayerHand.childCount < 6)
                while (PlayerHand.childCount < 6 && CurrentGame.Deck.Count != 0)
                    GiveCardToHand(CurrentGame.Deck, PlayerHand);
        }
    }

    public void Bit()
    {
        int count = PlayerFieldCards.Count;
        int countEn = EnemyFieldCards.Count;

        for (int i = 0; i < count; i++)
        {
            //PlayerFieldCards[0].GetComponent<CardMovement>().OnEndDrag(null);
            PlayerFieldCards.Remove(PlayerFieldCards[0]);
        }

        while (PlayerField.childCount > 0)
        {
            DestroyImmediate(PlayerField.GetChild(0).gameObject);
        }

        for (int i = 0; i < countEn; i++)
        {
            //EnemyFieldCards[0].GetComponent<CardMovement>().OnEndDrag(null);
            EnemyFieldCards.Remove(EnemyFieldCards[0]);
        }

        while (EnemyField.childCount > 0)
        {
            DestroyImmediate(EnemyField.GetChild(0).gameObject);
        }

        ChangeTurn();
    }

    public void Pass()
    {
        while (PlayerField.childCount > 0)
        {
            PlayerFieldCards[0].HideCardInfo(PlayerFieldCards[0].SelfCard);
            PlayerFieldCards[0].transform.SetParent(EnemyHand);

            EnemyHandCards.Add(PlayerFieldCards[0]);
            PlayerFieldCards.Remove(PlayerFieldCards[0]);
        }

        while (EnemyField.childCount > 0)
        {
            EnemyFieldCards[0].HideCardInfo(EnemyFieldCards[0].SelfCard);
            EnemyFieldCards[0].transform.SetParent(EnemyHand);

            EnemyHandCards.Add(EnemyFieldCards[0]);
            EnemyFieldCards.Remove(EnemyFieldCards[0]);
        }

        Turn++;
        ChangeTurn();
    }

    public void Take()
    {
        int count = PlayerFieldCards.Count;
        int countEn = EnemyFieldCards.Count;

        for (int i = 0; i < count; i++)
        {
            PlayerFieldCards[0].ShowCardInfo(PlayerFieldCards[0].SelfCard);
            PlayerFieldCards[0].transform.SetParent(PlayerHand);

            PlayerHandCards.Add(PlayerFieldCards[0]);
            PlayerFieldCards.Remove(PlayerFieldCards[0]);
        }

        for (int i = 0; i < countEn; i++)
        {
            EnemyFieldCards[0].ShowCardInfo(EnemyFieldCards[0].SelfCard);
            EnemyFieldCards[0].transform.SetParent(PlayerHand);

            PlayerHandCards.Add(EnemyFieldCards[0]);
            EnemyFieldCards.Remove(EnemyFieldCards[0]);
        }

        Turn++;
        ChangeTurn();
    }

    public void Newgame()
    {
        SceneManager.LoadScene("Fool");
    }
}
