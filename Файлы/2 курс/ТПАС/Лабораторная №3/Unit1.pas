unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons, MPlayer;

Const
  TailleCarreJeuX=14;
  TailleCarreJeuY=14;
  TailleCarreSuivantX=9;
  TailleCarreSuivantY=9;
  PlateauX=10;
  PlateauY=23;

type
  TForm1 = class(TForm)
    Bevel1: TBevel;
    BitBtn1: TBitBtn;
    Timer1: TTimer;
    Image1: TImage;
    Edit1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure Dessiner();
    Procedure Tourner();
    Procedure Verif();
    Procedure Fin();
    Function PieceFormY:integer;
    function PieceFormX:Integer;
    function Possible:Boolean;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
private
    { Private declarations }
  public
    { Public declarations }
  end;
  TPlateau=Array[1..PlateauX,1..PlateauY] of Byte;
  TPiece=Array[1..4,1..4] of Byte;
var
  JVerif:Integer;
  Couleur,CouleurNow:Integer;
  Couleurs:Array[1..10] of Tcolor=
            (clLime,clRed,clYellow,clSilver,clAqua,clGreen,clFuchsia,clOlive,clMaroon,$000080FF);
  Couleurcourante:TColor;
  Score:Integer;
  CouleurSuivante:Tcolor;
  Level:INteger=1;
  ToucheLibre: Boolean=False;
  Nouvelle:Boolean;
  Form1: TForm1;
  PiecePosY,PiecePosX,PieceFormY,PieceFormX:Integer;
  PlateauCours,PlateauAncien: TPlateau;
  PieceCourante: TPiece{=
         ((0,0,0,0),
          (0,0,0,0),
          (0,0,0,0),
          (0,0,0,0))};
  PieceSuivante:  TPiece=
         ((0,0,0,0),
          (0,0,0,0),
          (0,0,0,0),
          (0,0,0,0));
  Piece: TPiece=
         ((0,0,0,0),
          (0,0,0,0),
          (0,0,0,0),
          (0,0,0,0));
  Croix: TPiece=
         ((0,1,0,0),
          (1,1,1,1),
          (0,0,0,0),
          (0,0,0,0));
  Barre: Tpiece=
         ((0,0,0,0),
          (1,1,1,1),
          (0,0,0,0),
          (0,0,0,0));
  LGauche: Tpiece=
         ((0,1,1,0),
          (0,1,0,0),
          (0,1,0,0),
          (0,0,0,0));
  LDroite: TPiece=
         ((0,1,0,0),
          (0,1,0,0),
          (0,1,1,0),
          (0,0,0,0));
  Carre: Tpiece=
         ((0,0,0,0),
          (0,1,1,0),
          (0,1,1,0),
          (0,0,0,0));
  GrosCarre: Tpiece=
         ((0,0,0,0),
          (0,1,1,0),
          (0,1,0,0),
          (0,0,0,0));
  T:TPiece=
         ((0,1,0,0),
          (0,1,1,0),
          (0,1,0,0),
          (0,0,0,0));
  CarreSpe: TPiece=
         ((0,1,0,0),
          (0,1,1,0),
          (0,0,1,1),
          (0,0,0,0));
  SGauche: Tpiece=
         ((0,0,1,0),
          (0,1,1,0),
          (0,1,0,0),
          (0,0,0,0));
  SDroite: Tpiece=
         ((0,1,0,0),
          (0,1,1,0),
          (0,0,1,0),
          (0,0,0,0));

implementation

{$R *.DFM}

function TForm1.PieceFormX:Integer;
Begin
pieceFormX:=PiecePosX*TailleCarreJeuX+Bevel1.left;
end;

function TForm1.PieceFormY:Integer;
BEgin
PieceFormY:=PiecePosY*TailleCarreJeuY+Bevel1.Top;
end;

Function TForm1.Possible:Boolean;
Var I,J:Integer;
Begin
touchelibre:=false;
For I:=1 to 4 Do
   For J:=1 to 4 do
     Begin
     if PieceCourante[I,J]<>0 then
     if PiecePosY+J>plateauY then
     begin
     Possible:=False;
     Exit;
     end
     else if PiecePosX+I>PlateauX then
     begin
     dec(PiecePosX);
     Possible;
     possible:=True;
     Exit;
     end
     else if PiecePosX+I<1 then
     begin
     Inc(PiecePosX);
     Possible;
     Possible:=True;
     Exit;
     end
     else if PlateauCours[I+PiecePosX,J+PiecePosY]>0 then
     begin
     Possible:=False ;
     Exit;
     end;
     end;
possible:=true;
touchelibre:=true;
end;

Procedure TForm1.Fin();
Begin
ToucheLibre:=False;
Timer1.Enabled:=False;
ShowMessage('Вы набрали: '+IntToStr(Score));
end;

Procedure TForm1.Verif();
Var I,J,K,L,M,N,O,S:integer;
Begin
ToucheLibre:=false;
J:=0;
I:=0;
K:=0;
L:=0;
M:=0;
S:=5;
Timer1.Enabled:=False;
For I:=1 to PlateauY DO
  Begin
  K:=0;
    For J:=1 to PlateauX DO
      If PlateauCours[J,I]>0 then Inc(K);
        If K=PlateauX then
          begin
            S:=S*5;
            for L:=I-1 downto 1 do
              for M:=1 to PlateauX do
                PlateauCours[M,L+1]:=PlateauCours[M,L];
                  for N:=1 to PlateauY DO
                    For O:=1 to PlateauX DO
                     Begin
                       {if PlateauCours[O,N] <> PlateauAncien[O,N] then}
                         if PlateauCours[O,N] = 0 then
                           Begin
                             Canvas.brush.Color:=clBlack;
                             Canvas.Pen.Color:=clBlack;
                             Canvas.Rectangle(Bevel1.Left+(O-1)*tailleCarreJeuX,Bevel1.Top+(N-1)*TailleCarreJeuY,
                             Bevel1.Left+(O)*tailleCarreJeuX,Bevel1.Top+(N)*TailleCarreJeuY);
                           End
                           Else
                           Begin
                             Canvas.brush.Color:=Couleurs[PlateauCours[O,N]];
                             Canvas.Pen.Color:=clBlack;
                             Canvas.Rectangle(Bevel1.Left+(O-1)*tailleCarreJeuX,Bevel1.Top+(N-1)*TailleCarreJeuY,
                             Bevel1.Left+(O)*tailleCarreJeuX,Bevel1.Top+(N)*TailleCarreJeuY);

                           end;
                     end;
          end;
  end;
Score:=Score+S;
ToucheLibre:=True;
end;


procedure NouvellePiece;
var I,J:integer;
begin
Form1.Timer1.Enabled:=False;
Nouvelle:=True;
ToucheLibre:=False;
piecePosX:=2;
PiecePosY:=0;
Form1.Verif;
Form1.Timer1.Enabled:=True;
CouleurCourante:=CouleurSuivante;
Move(PieceSuivante,PieceCourante,SizeOf(PieceCourante));
Randomize;
CouleurNow:=Couleur;
Randomize;Randomize;
I:=Random(10)+1;
Couleur:=Random(10)+1;
CouleurSuivante:=Couleurs[Couleur];
Case I of
1:Move(Barre,PieceSuivante,sizeOf(PieceSuivante));
2:Move(Croix,PieceSuivante,sizeOf(PieceSuivante));
3:Move(GrosCarre,PieceSuivante,sizeOf(PieceSuivante));
4:Move(LGauche,PieceSuivante,sizeOf(PieceSuivante));
5:Move(LDroite,PieceSuivante,sizeOf(PieceSuivante));
6:Move(T,PieceSuivante,sizeOf(PieceSuivante));
7:Move(CarreSpe,PieceSuivante,sizeOf(PieceSuivante));
8:Move(SDroite,PieceSuivante,sizeOf(PieceSuivante));
9:Move(SGauche,PieceSuivante,sizeOf(PieceSuivante));
10:Move(Carre,PieceSuivante,sizeOf(PieceSuivante));
end;
Form1.Image1.Canvas.pen.Width:=0;
Form1.Image1.Canvas.Pen.Color:=Form1.Color;
Form1.Image1.Canvas.Brush.color:=Form1.Color;
Form1.Image1.Canvas.Rectangle(0,0,Form1.Image1.Width,Form1.Image1.Height);
Form1.Image1.Canvas.Brush.color:=CouleurSuivante;
Form1.Image1.Canvas.Pen.Color:=clBlack;
Form1.Image1.Canvas.pen.Width:=1;

for J:=1 to 4 DO
        For I:=1 to 4 DO
          if PieceSuivante[I,J] > 0 then
          Begin
            Form1.Image1.Canvas.Rectangle((I-1)*tailleCarreSuivantX,(J-1)*TailleCarreSuivantY,
                             (I)*tailleCarreSuivantX,(J)*TailleCarreSuivantY);
           end;
          FillChar(PlateauAncien,SizeOf(PlateauAncien),0);
if not Form1.possible then Begin Form1.Fin;Exit; end;
touchelibre:=True;
Nouvelle:=false;
Form1.Timer1.Enabled:=True;
end;

Procedure Tform1.Tourner();
Var I,J:integer;
Begin
For I:=4 downto 1 Do
   For J:=1 to 4 do
   piece[J,5-I]:=PieceCourante[I,J];
Move(piece,PieceCourante,SizeOf(PieceCourante));
end;

Procedure TForm1.dessiner();
var I,J:Integer;
Begin
touchelibre:=false;
if Possible then
Begin
Canvas.Refresh;
Canvas.brush.Color:=clBLue;
Canvas.Pen.Color:=clBlue;
for J:=1 to PlateauY DO
        For I:=1 to PlateauX DO
        Begin
          if PlateauCours[I,J] <> PlateauAncien[I,J] then
          if PlateauCours[I,J] = 0 then
            Begin
            Canvas.brush.Color:=clBlack;
            Canvas.Pen.Color:=clBlack;
            Canvas.Rectangle(Bevel1.Left+(I-1)*tailleCarreJeuX,Bevel1.Top+(J-1)*TailleCarreJeuY,
                             Bevel1.Left+(I)*tailleCarreJeuX,Bevel1.Top+(J)*TailleCarreJeuY);
            End
          Else
            Begin
            Canvas.brush.Color:=Couleurs[PlateauCours[I,J]];
            Canvas.Pen.Color:=Couleurs[PlateauCours[I,J]];
            Canvas.Rectangle(Bevel1.Left+(I-1)*tailleCarreJeuX,Bevel1.Top+(J-1)*TailleCarreJeuY,
                             Bevel1.Left+(I)*tailleCarreJeuX,Bevel1.Top+(J)*TailleCarreJeuY);
             Canvas.pen.Width:=1;
            Canvas.MoveTo(Bevel1.Left+(I-1)*tailleCarreJeuX+1,Bevel1.Top+(J-1)*TailleCarreJeuY+1);
            Canvas.Pen.Color:=clWhite;
            Canvas.LineTo(Bevel1.Left+(I-1)*tailleCarreJeuX+1,Bevel1.Top+(J)*TailleCarreJeuY-2);
            Canvas.Pen.Color:=clBlack;
            Canvas.LineTo(Bevel1.Left+(I)*tailleCarreJeuX-2,Bevel1.Top+(J)*TailleCarreJeuY-2);
            Canvas.LineTo(Bevel1.Left+(I)*tailleCarreJeuX-2,Bevel1.Top+(J-1)*TailleCarreJeuY+1);
            Canvas.Pen.Color:=clWhite;
            Canvas.LineTo(Bevel1.Left+(I-1)*tailleCarreJeuX+1,Bevel1.Top+(J-1)*TailleCarreJeuY+1);

            end;
         end;
Move(PlateauCours,PlateauAncien,SizeOf(PlateauAncien));
for J:=1 to 4 DO
        For I:=1 to 4 DO
          if PieceCourante[I,J] > 0 then
          Begin
            Canvas.Brush.color:=CouleurCourante;
            Canvas.Pen.Color:=CouleurCourante;
            Canvas.Rectangle(PieceFormX+(I-1)*tailleCarreJeuX,PieceFormY+(J-1)*TailleCarreJeuY,
                             PieceFormX+(I)*tailleCarreJeuX,PieceFormY+(J)*TailleCarreJeuY);
            Canvas.pen.Width:=1;
            Canvas.MoveTo(PieceFormX+(I-1)*tailleCarreJeuX+1,PieceFormY+(J-1)*TailleCarreJeuY+1);
            Canvas.Pen.Color:=clWhite;
            Canvas.LineTo(PieceFormX+(I-1)*tailleCarreJeuX+1,PieceFormY+(J)*TailleCarreJeuY-2);
            Canvas.Pen.Color:=clBlack;
            Canvas.LineTo(PieceFormX+(I)*tailleCarreJeuX-2,PieceFormY+(J)*TailleCarreJeuY-2);
            Canvas.LineTo(PieceFormX+(I)*tailleCarreJeuX-2,PieceFormY+(J-1)*TailleCarreJeuY+1);
            Canvas.Pen.Color:=clWhite;
            Canvas.LineTo(PieceFormX+(I-1)*tailleCarreJeuX+1,PieceFormY+(J-1)*TailleCarreJeuY+1);
            PlateauAncien[(PiecePosX+I),(PiecePosY+J)]:=CouleurNow;
          end;
end
else Begin Move(PlateauAncien,PlateauCours,SizeOf(PlateauCours));Nouvellepiece;end;
touchelibre:=true;
end;


procedure TForm1.FormCreate(Sender: TObject);

Var I,J: integer;
begin
Bevel1.Width:=PlateauX*TailleCarrejeuX;
Bevel1.height:=plateauY*TailleCarreJeuY;
FillChar(PlateauCours,SizeOf(PlateauCours),0);
FillChar(PlateauAncien,SizeOf(PlateauAncien),0);
BitBtn1.Left:=Bevel1.Left+Bevel1.Width+30;
Image1.Left:=BitBtn1.Left;
Edit1.Left:=BitBtn1.Left;
Form1.Autosize:=True;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
Var J,I:Integer;
begin
If Score>Level*1000 then
Begin
Inc(Level);
Timer1.interval:=500-81*(Level-1)  ;
end;
Score:=Score+5;
Edit1.Caption:=IntToStr(Score);
Inc(PiecePosY);
dessiner;


       {   Canvas.brush.Color:=clBlue;
            Canvas.Pen.Color:=clBlue;
        for J:=1 to 4 DO
        For I:=1 to 4 DO
          if LGauche[J,I] > 0 then
          Begin
            Canvas.Rectangle(PieceFormX+(I-1)*tailleCarreJeuX,PieceFormY+(J-1)*TailleCarreJeuY,
                             PieceFormX+(I)*tailleCarreJeuX,PieceFormY+(J)*TailleCarreJeuY);
          PlateauAncien[(PiecePosX+I-1),(PieceFormY+J-1)]:=1;
          end;
                                              }


end;

procedure TForm1.BitBtn1Click(Sender: TObject);
Var J,I:Integer;
begin
BitBtn1.enabled:=False;
I:=Random(10)+1;
Couleur:=Random(10)+1;
CouleurSuivante:=Couleurs[Couleur];
Case I of
1:Move(Barre,PieceSuivante,sizeOf(PieceSuivante));
2:Move(Croix,PieceSuivante,sizeOf(PieceSuivante));
3:Move(GrosCarre,PieceSuivante,sizeOf(PieceSuivante));
4:Move(LGauche,PieceSuivante,sizeOf(PieceSuivante));
5:Move(LDroite,PieceSuivante,sizeOf(PieceSuivante));
6:Move(T,PieceSuivante,sizeOf(PieceSuivante));
7:Move(CarreSpe,PieceSuivante,sizeOf(PieceSuivante));
8:Move(SDroite,PieceSuivante,sizeOf(PieceSuivante));
9:Move(SGauche,PieceSuivante,sizeOf(PieceSuivante));
10:Move(Carre,PieceSuivante,sizeOf(PieceSuivante));
end;
Canvas.Refresh;
Canvas.brush.Color:=clBlue;
Canvas.Pen.Color:=clBlue;
for J:=1 to PlateauY DO
        For I:=1 to PlateauX DO
          if PlateauCours[I,J] = 0 then
            Begin
            Canvas.brush.Color:=clBlack;
            Canvas.Pen.Color:=clBlack;
            Canvas.Rectangle(Bevel1.Left+(I-1)*tailleCarreJeuX,Bevel1.top+(J-1)*TailleCarreJeuY,
                             Bevel1.Left+(I)*tailleCarreJeuX,Bevel1.Top+(J)*TailleCarreJeuY);
            End;

         NouvellePiece;
         ToucheLibre:=True;
         Timer1.Enabled:=True;

end;

procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
If Not Nouvelle then
If ToucheLibre then
Begin
ToucheLibre:=False;
 Case Key Of
 39:Begin Inc(PiecePosX);If not possible then Dec(PiecePosX);end;
 37:Begin Dec(PiecePosX);If not possible then Inc(PiecePosX);end;
 38:Tourner;
 40:Begin Inc(PiecePosY);If not possible then Dec(PiecePosY);end;
 end;
dessiner;
end;
ToucheLibre:=True;
end;



end.
