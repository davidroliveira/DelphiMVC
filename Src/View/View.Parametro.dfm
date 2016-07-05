inherited FrmParametro: TFrmParametro
  Caption = 'FrmParametro'
  PixelsPerInch = 96
  TextHeight = 13
  inherited PageControlPrincipal: TPageControl
    ActivePage = TSDados
    inherited TSLista: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 24
      ExplicitWidth = 538
      ExplicitHeight = 273
    end
    inherited TSDados: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 24
      ExplicitWidth = 538
      ExplicitHeight = 273
      object Label4: TLabel [0]
        Left = 94
        Top = 115
        Width = 28
        Height = 13
        Alignment = taRightJustify
        Caption = 'Valor:'
      end
      object Label2: TLabel [1]
        Left = 72
        Top = 75
        Width = 50
        Height = 13
        Alignment = taRightJustify
        Caption = 'Descri'#231#227'o:'
      end
      object Label1: TLabel [2]
        Left = 85
        Top = 35
        Width = 37
        Height = 13
        Alignment = taRightJustify
        Caption = 'C'#243'digo:'
      end
      inherited Panel1: TPanel
        TabOrder = 3
      end
      object EdtValor: TEdit
        Left = 128
        Top = 112
        Width = 100
        Height = 21
        TabOrder = 2
        Text = 'EdtValor'
      end
      object EdtDescricao: TEdit
        Left = 128
        Top = 72
        Width = 200
        Height = 21
        Enabled = False
        TabOrder = 1
        Text = 'EdtDescricao'
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
    end
  end
end
