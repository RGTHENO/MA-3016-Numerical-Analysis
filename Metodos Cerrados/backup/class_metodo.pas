unit class_metodo;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Dialogs;

type
  TMetodo = class
    ErrorAllowed: Real;
    SequenceA,
    SequenceB,
    SequenceSigno,
    SequenceXn,
    SequenceError,
    FunctionList: TstringList;

     a,
     b: Real;
      function Execute(): Real;
    private
      Error : Real;
      function my_function(x:Real):Real;

    public

      function Biseccion():Real;
      function FalsaPosicion():Real;


      constructor create;
      destructor Destroy; override;

end;

const
     IsBiseccion = 0;
     IsFalsaPosicion = 1;


implementation
const
     Top = 100000;

constructor TMetodo.create;
begin

  SequenceA:= TStringList.Create;
  SequenceB:= TStringList.create;
  SequenceSigno:= TStringList.create;
  SequenceXn := TStringList.create;
  SequenceError := TStringList.create;

  SequenceA.Add('');
  SequenceB.Add('');
  SequenceXn.Add('');
  SequenceSigno.Add('');
  SequenceError.Add('');
  SequenceError.Add('');


  FunctionList:= TStringList.Create;
  FunctionList.AddObject('Biseccion',TObject(IsBiseccion) );
  FunctionList.AddObject('FalsaPosicion', TObject(IsFalsaPosicion) );

end;



function Power( b: Real; n: Integer):Real;
begin

  if n=0 then
  begin
     Result:=1;
     Exit(Result);
  end;

  Result:=1;
  while n>0 do
  begin

    if Odd(n) then
       begin
         Result:= Result*b;
       end;
    b:=b*b;
    n:=n>>1;


  end;
end;
function TMetodo.my_function(x:Real) : Real;
begin
  Result:= 2*power(x,3)+2;
end;

function TMetodo.Execute( ): Real;
begin


   case FunctionType of
        IsBiseccion: Result:= Biseccion();
        IsFalsaPosicion: Result:=FalsaPosicion();
   end;


end;




function TMetodo.Biseccion( ): Real;
var
   i: integer;
begin
     i := 1;
     Error:= Top;

     if( my_function(a)*my_function(b)>0) then
        begin
          ShowMessage('NO CUMPLE CON LA PROPIEDAD DE BOLZANO');
          exit();
        end;

     Repeat

         Result := (a+b)/2;
         SequenceXn.Add( FloatToStr( Result) );
         SequenceA.Add( FloatToStr(a) );
         SequenceB.Add( FloatToStr(b) );

         if my_function(a)*my_function(Result) >0 then
            begin
            a := Result;
            SequenceSigno.Add('+');
            end

         else
             begin
             b:= Result;
             SequenceSigno.Add('-');
             end ;

         if i>1 then
         begin
          (** Error :=  StrToFloat(SequenceXn[i]) - StrToFloat(SequenceXn[i-1] )  **)
            Error := Abs ( StrToFloat(SequenceXn[i]) - StrToFloat(SequenceXn[i-1]) );
            SequenceError.Add( FloatToStr(Error) );
          end;
          i:=i+1;

     until ( Error <= ErrorAllowed  );

end;


function TMetodo.FalsaPosicion( ): Real;
var
   i: integer;
begin
     i := 1;
     Error:= Top;

     if( my_function(a)*my_function(b)>0) then
        begin
          ShowMessage('NO CUMPLE CON LA PROPIEDAD DE BOLZANO');
          exit();
        end;

     Repeat

         Result := a- (my_function(a)*(b-a)/( my_function(b)-my_function(a) ) );
         SequenceXn.Add( FloatToStr( Result) );
         SequenceA.Add( FloatToStr( a) );
         SequenceB.Add( FloatToStr( b) );

         if my_function(a)*my_function(Result) >0 then
            begin
            a := Result;
            SequenceSigno.Add('+');
            end

         else
             begin
             b:= Result;
             SequenceSigno.Add('-');
             end ;

         if i>1 then
         begin
          (** Error :=  StrToFloat(SequenceXn[i]) - StrToFloat(SequenceXn[i-1] )  **)
            Error := Abs ( StrToFloat(SequenceXn[i]) - StrToFloat(SequenceXn[i-1]) );
            SequenceError.Add( FloatToStr(Error) );
          end;
          i:=i+1;

     until ( Error <= ErrorAllowed  );

end;


destructor TMetodo.Destroy;
begin
         FunctionList.Destroy;
end;





end.

