program Project1;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils;

const
    n=50;
    type mas=array[1..n] of string;
    var mag,vixp:mas;
    f,fv:string;
    smv:char;
    rez:real;
    ch,L,i,j, k:integer;
    begin
      ch:=0;
      write('Введите формулу: ');
      readln(f);
      If Copy(f, 1, 1) ='-' Then f:=concat('0',f);
      L:=Length(f);
      j:=0;
      k:=0;
      For i:=1 To L do
        begin
        smv:=f[i];
        If (smv >='0') And (smv <='9') Then
          begin
            ch:= ch * 10 +StrToInt(smv);
            If i = L Then
              begin
                k:= k + 1;
                vixp[k]:= IntToStr(ch);
              end;
              If (i < L) And ((Copy(f, i + 1, 1) < '0') Or (Copy(f, i + 1, 1) > '9')) Then
                begin
                  k:= k + 1;
                  vixp[k]:= IntToStr(ch);
                end;
          end
          Else
          If smv = '(' Then
            begin
              j:= j + 1;
              mag[j]:= smv;
              ch:= 0;
            end
            Else
            If smv =  ')' Then
              begin
                while j=j Do
                  begin
                    If j = 0 Then
                      begin
                        Writeln(concat('Некорректная формула! ',f,' Нажмите Enter'));
                        Readln;
                        halt;
                      End;
                      If mag[j] = '(' Then
                        begin
                          j:= j - 1;
                          ch:= 0;
                          break;
                        End;
                        k:= k + 1;
                        vixp[k]:= mag[j];
                        j:= j - 1;
                  end;
              end
              Else
              If (smv = '+') Or (smv = '-') Then
                begin
                  While j=j Do
                    begin
                      If j = 0 Then
                        begin
                          j:= j + 1;
                          mag[j]:= smv;
                          ch:= 0;
                          break;
                        End;
                        If mag[j] = '(' Then
                        begin
                          j:= j + 1;
                          mag[j]:= smv;
                          ch:= 0;
                          break;
                        End;
                        k:= k + 1;
                        vixp[k]:= mag[j];
                        j:= j - 1;
                    end;
                end
                Else
                If (smv = '*') Or (smv = '/') Then
                  begin
                    while j=j Do
                      begin
                        If j = 0 Then
                          begin
                            j:= j + 1;
                            mag[j]:= smv;
                            ch:= 0;
                            break;
                          End;
                          If (mag[j] = '(') Or (mag[j] = '+') Or (mag[j] = '-') Then
                          begin
                            j:= j + 1;
                            mag[j]:= smv;
                            ch:= 0;
                            break;
                          End;
                          k:= k + 1;
                          vixp[k]:= mag[j];
                          j:= j - 1;
                      end;
                  end
                  Else
                  begin
                    fv:=IntToStr(i);
                    writeln(concat('Недопустимый символ ',fv,' в формуле! ',f,' Нажмите Enter'));
                    readln;
                    halt;
                  End;
        End;
    If j <> 0 Then
      begin
        For i:= j Downto 1 Do
          begin
            k:= k + 1;
            vixp[k]:= mag[i];
          end;
      End;
    fv:= '';
    For i:= 1 To k do
    fv:= concat(fv,vixp[i],' ');
    j:= 0;
    For i:= 1 To k do
      Begin
        If (vixp[i] <> '+') And (vixp[i] <> '-') And (vixp[i] <> '*') And (vixp[i] <> '/') Then
          begin
            j:= j + 1;
            mag[j]:= vixp[i];
          end
          Else
           begin
           If j = 1 Then
             begin
               Writeln(concat('Некорректная формула! ',f,' Нажмите Enter'));
               Readln;
               halt;
             End;
           End;
        If vixp[i] = '+' Then
          begin
            mag[j - 1]:= FloatToStr(StrToFloat(mag[j - 1]) + StrToFloat(mag[j]));
            j:= j - 1;
          End;
        If vixp[i] = '-' Then
          begin
            mag[j - 1]:= FloatToStr(StrToFloat(mag[j - 1]) - StrToFloat(mag[j]));
            j:= j - 1;
          End;
        If vixp[i] = '*' Then
          begin
            mag[j - 1]:= FloatToStr(StrToFloat(mag[j - 1]) * StrToFloat(mag[j]));
            j:= j - 1;
          End;
        If vixp[i] = '/' Then
          begin
            mag[j - 1]:= FloatToStr(StrToFloat(mag[j - 1]) / StrToFloat(mag[j]));
            j:= j - 1;
          End;
        If vixp[i] = '(' Then
          begin
            Writeln(concat('Некорректная формула! ',f,' Нажмите Enter'));
            Readln;
            halt;
          End;
      end;
    rez:= StrToFloat(mag[1]);
    Writeln('Обратная польская нотация: ',fv);
    Writeln('Результат: ', FloatToStr(rez));
    writeln;
    Write('Нажмите Enter');
    readln;
    end.
