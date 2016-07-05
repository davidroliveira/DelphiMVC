inherited FrmBomba: TFrmBomba
  Caption = 'FrmBomba'
  ClientHeight = 328
  ExplicitHeight = 366
  PixelsPerInch = 96
  TextHeight = 13
  inherited PageControlPrincipal: TPageControl
    Height = 328
    ActivePage = TSDados
    inherited TSLista: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 24
      ExplicitWidth = 538
      ExplicitHeight = 273
      inherited PnlBotton: TPanel
        Top = 259
      end
      inherited DBGridPrincipal: TDBGrid
        Height = 259
      end
    end
    inherited TSDados: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 24
      ExplicitWidth = 538
      ExplicitHeight = 273
      object Label1: TLabel [0]
        Left = 85
        Top = 35
        Width = 37
        Height = 13
        Alignment = taRightJustify
        Caption = 'C'#243'digo:'
      end
      object Label2: TLabel [1]
        Left = 82
        Top = 75
        Width = 40
        Height = 13
        Alignment = taRightJustify
        Caption = 'Tanque:'
      end
      object Label4: TLabel [2]
        Left = 67
        Top = 155
        Width = 55
        Height = 13
        Alignment = taRightJustify
        Caption = 'Fabricante:'
      end
      object Label3: TLabel [3]
        Left = 84
        Top = 195
        Width = 38
        Height = 13
        Alignment = taRightJustify
        Caption = 'Modelo:'
      end
      object Label5: TLabel [4]
        Left = 94
        Top = 235
        Width = 28
        Height = 13
        Alignment = taRightJustify
        Caption = 'S'#233'rie:'
      end
      object Label6: TLabel [5]
        Left = 81
        Top = 115
        Width = 41
        Height = 13
        Alignment = taRightJustify
        Caption = 'N'#250'mero:'
      end
      inherited Panel1: TPanel
        Top = 259
        TabOrder = 6
      end
      object EdtCodigo: TEdit
        Left = 128
        Top = 32
        Width = 50
        Height = 21
        Enabled = False
        TabOrder = 0
        Text = 'EdtCodigo'
      end
      object LkpTanque: TDBLookupComboBox
        Left = 128
        Top = 72
        Width = 145
        Height = 21
        TabOrder = 1
      end
      object EdtFabricante: TEdit
        Left = 128
        Top = 152
        Width = 100
        Height = 21
        TabOrder = 3
        Text = 'EdtFabricante'
      end
      object EdtModelo: TEdit
        Left = 128
        Top = 192
        Width = 100
        Height = 21
        TabOrder = 4
        Text = 'EdtModelo'
      end
      object EdtSerie: TEdit
        Left = 128
        Top = 232
        Width = 100
        Height = 21
        TabOrder = 5
        Text = 'EdtSerie'
      end
      object EdtNumero: TEdit
        Left = 128
        Top = 112
        Width = 50
        Height = 21
        NumbersOnly = True
        TabOrder = 2
        Text = 'EdtNumero'
      end
    end
  end
end
