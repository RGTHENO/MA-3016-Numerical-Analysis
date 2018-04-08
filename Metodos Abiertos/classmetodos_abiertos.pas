unit classmetodos_abiertos;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Dialogs;

type
  TMetodoAbierto = class

    ErrorAllowed: Real;
    SequenceXn,
    SequenceError,
    FunctionList: TstringList;
    FunctionType : Integer;

    X_0: Real;
    X_n: Real;
    function Execute(): Real;
    private
      Error : Real;
      function my_function(x:Real):Real;
      function my_derivatedfunction(x:Real):Real;

    public

      function Newton():Real;
      function Secante():Real;

      constructor create;
      destructor Destroy; override;

end;

const
     IsNewton = 0;
     IsSecante = 1;


implementation
const
     Top = 100000;

constructor TMetodoAbierto.create;
begin

  SequenceXn := TStringList.create;
  SequenceError := TStringList.create;

  SequenceXn.Add('');
  SequenceError.Add('');
  SequenceError.Add('');

  FunctionList:= TStringList.Create;
  FunctionList.AddObject('Newton',TObject(IsNewton) );
  FunctionList.AddObject('Secante', TObject(IsSecante) );

end;

function Power( base: Real; exponente: Integer):Real;
begin

  if exponente=0 then
  begin
     Result:=1;
     Exit(Result);
  end;

  Result:=1;
  while exponente>0 do
  begin

    if Odd(exponente) then
       begin
         Result:= Result*base;
       end;
    base:=base*base;
    exponente:=exponente>>1;


  end;
end;
function TMetodoAbierto.my_function(x:Real) : Real;
begin
  Result:= 2*power(x,3)+2;
end;

function TMetodoAbierto.my_derivatedfunction(x:Real): Real;
begin
  Result := 6*power(x,2);
end;


function TMetodoAbierto.Execute( ): Real;
begin

   case FunctionType of
        IsNewton: Result:= Newton();
        IsSecante: Result:= Secante();
   end;


end;

function TMetodoAbierto.Newton( ): Real;
var
   i: integer;
begin
     i := 1; /// Porque enla posicion 0, se lleno un espacio en blanco de SequenceXn
     Error:= Top;
     X_n:= X_0;
     SequenceXn.Add( FloatToStr(X_n) );

     Repeat

         if i>1 then
         begin
            X_n := X_n - my_function(X_n)/my_derivatedfunction(X_n);
            SequenceXn.Add( FloatToStr(X_n) );

            Error := Abs ( StrToFloat(SequenceXn[i]) - StrToFloat(SequenceXn[i-1]) );

            SequenceError.Add( FloatToStr(Error) );
          end;

          i:=i+1;

     until ( Error <= ErrorAllowed  );

     Result := X_n;

end;

function TMetodoAbierto.Secante( ): Real;
var
   i: integer;
   h: real;
begin
     i := 1; /// Porque enla posicion 0, se lleno un espacio en blanco de SequenceXn
     Error:= Top;
     h := ErrorAllowed/10;

     X_n:= X_0;
     SequenceXn.Add( FloatToStr(X_n) );

     Repeat

         if i>1 then
         begin
            //X_n := X_n - my_function(X_n)/my_derivatedfunction(X_n);
            X_n := X_n - 2*h*my_function(X_n)/( my_function(X_n+h)-my_function(X_n-h) );

            SequenceXn.Add( FloatToStr(X_n) );
            Error := Abs ( StrToFloat(SequenceXn[i]) - StrToFloat(SequenceXn[i-1]) );
            SequenceError.Add( FloatToStr(Error) );

          end;

          i:=i+1;

     until ( Error <= ErrorAllowed);

     Result := X_n;

end;



destructor TMetodoAbierto.Destroy;
begin
         FunctionList.Destroy;
end;

end.

