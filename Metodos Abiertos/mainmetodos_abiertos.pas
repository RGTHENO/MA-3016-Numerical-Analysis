unit mainmetodos_abiertos;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Grids,
  ExtCtrls, StdCtrls, classmetodos_abiertos, math;

type

  { TForm1 }

  TForm1 = class(TForm)
    BbtnExecute: TButton;
    cboFunctions: TComboBox;

    ediError : TEdit;
    ediX_0: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Panel1: TPanel;
    stgData: TStringGrid;
    procedure BbtnExecuteClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);

  private
    Metodo_Abierto : TMetodoAbierto;
  public

  end;

var
  Form1: TForm1;

implementation
const

     colN  = 0;
     colXn = 1;
     colError = 2;

{$R *.lfm}

{ TForm1 }

procedure TForm1.BbtnExecuteClick(Sender: TObject);
    var i: Integer;
        Rpta: Real;

    begin

      Metodo_Abierto := TMetodoAbierto.create;
      Metodo_Abierto.X_0 := StrToFloat(ediX_0.Text);
      Metodo_Abierto.ErrorAllowed := StrToFloat ( ediError.Text);

      Metodo_Abierto.FunctionType:= PtrUint( cboFunctions.Items.Objects[ cboFunctions.ItemIndex ] );

      Rpta := Metodo_Abierto.Execute();  (**A diferencia de las series que si imprimian en el lado derecho la rpta, en el metodo de biseccion se asume que la rpta, es el ultimo Xn **)

      stgData.RowCount := Metodo_Abierto.SequenceXn.Count;

      with stgData do
      for i:= 1 to RowCount-1 do begin
          Cells[colN,i]:= IntToStr(i-1)

      end;

      stgData.Cols[ ColXn ].Assign( Metodo_Abierto.SequenceXn );
      stgData.Cols[ ColError ].Assign( Metodo_Abierto.SequenceError );

    end;



procedure TForm1.FormCreate(Sender: TObject);
begin
   Metodo_Abierto:= TMetodoAbierto.create;
   cboFunctions.Items.Assign( Metodo_Abierto.FunctionList );
   cboFunctions.ItemIndex:= 0;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  Metodo_Abierto.Destroy;
end;


end.
