unit mainmetodos;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Grids,
  ExtCtrls, StdCtrls, class_metodo, math;

type

  { TForm1 }

  TForm1 = class(TForm)
    BbtnExecute: TButton;
    cboFunctions: TComboBox;

    ediError : TEdit;
    ediB : TEdit;
    ediA: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Panel1: TPanel;
    stgData: TStringGrid;
    procedure BbtnExecuteClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);

  private
    Metodo : TMetodo;
  public

  end;

var
  Form1: TForm1;

implementation
const

     colN  = 0;
     colA  = 1;
     colB  = 2;
     colXn = 3;
     colSigno = 4;
     colError = 5;

{$R *.lfm}

{ TForm1 }

procedure TForm1.BbtnExecuteClick(Sender: TObject);
    var i: Integer;
        Rpta: Real;

    begin

      Metodo := TMetodo.create;
      Metodo.a := StrToFloat(ediA.Text);
      Metodo.b := StrToFloat(ediB.Text);
      Metodo.ErrorAllowed := StrToFloat ( ediError.Text);

      Metodo.FunctionType:= PtrUint( cboFunctions.Items.Objects[ cboFunctions.ItemIndex ] );

      Rpta := Metodo.Execute();  (**A diferencia de las series que si imprimian en el lado derecho la rpta, en el metodo de biseccion se asume que la rpta, es el ultimo Xn **)

      stgData.RowCount := Metodo.SequenceXn.Count;

      with stgData do
      for i:= 1 to RowCount-1 do begin
          Cells[colN,i]:= IntToStr(i-1)

      end;

      stgData.Cols[ ColA ].Assign( Metodo.SequenceA );
      stgData.Cols[ ColB ].Assign( Metodo.SequenceB );
      stgData.Cols[ ColXn ].Assign( Metodo.SequenceXn );
      stgData.Cols[ ColSigno ].Assign( Metodo.SequenceSigno );
      stgData.Cols[ ColError ].Assign( Metodo.SequenceError );

    end;

procedure TForm1.FormCreate(Sender: TObject);
begin
   Metodo:= TMetodo.create;
   cboFunctions.Items.Assign( Metodo.FunctionList );
   cboFunctions.ItemIndex:= 0;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  Metodo.Destroy;
end;




end.

