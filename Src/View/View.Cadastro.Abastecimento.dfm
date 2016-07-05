inherited FrmAbastecimento: TFrmAbastecimento
  Caption = 'FrmAbastecimento'
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
      object Label1: TLabel [0]
        Left = 85
        Top = 35
        Width = 37
        Height = 13
        Alignment = taRightJustify
        Caption = 'C'#243'digo:'
      end
      object Label6: TLabel [1]
        Left = 62
        Top = 115
        Width = 60
        Height = 13
        Alignment = taRightJustify
        Caption = 'Quantidade:'
      end
      object Label4: TLabel [2]
        Left = 91
        Top = 155
        Width = 31
        Height = 13
        Alignment = taRightJustify
        Caption = 'Pre'#231'o:'
      end
      object Label3: TLabel [3]
        Left = 94
        Top = 195
        Width = 28
        Height = 13
        Alignment = taRightJustify
        Caption = 'Total:'
      end
      object Label5: TLabel [4]
        Left = 68
        Top = 75
        Width = 54
        Height = 13
        Alignment = taRightJustify
        Caption = 'Data/Hora:'
      end
      object Label2: TLabel [5]
        Left = 236
        Top = 195
        Width = 70
        Height = 13
        Alignment = taRightJustify
        Caption = 'Total Imposto:'
      end
      object Label7: TLabel [6]
        Left = 383
        Top = 35
        Width = 36
        Height = 13
        Alignment = taRightJustify
        Caption = 'Bomba:'
      end
      object Label8: TLabel [7]
        Left = 357
        Top = 75
        Width = 62
        Height = 13
        Alignment = taRightJustify
        Caption = 'Combust'#237'vel:'
      end
      object Label9: TLabel [8]
        Left = 362
        Top = 115
        Width = 57
        Height = 13
        Alignment = taRightJustify
        Caption = '% Imposto:'
      end
      inherited Panel1: TPanel
        TabOrder = 7
      end
      object EdtCodigo: TEdit
        Left = 128
        Top = 32
        Width = 50
        Height = 21
        TabStop = False
        Enabled = False
        TabOrder = 0
        Text = 'EdtCodigo'
      end
      object EdtQuantidade: TEdit
        Left = 128
        Top = 112
        Width = 100
        Height = 21
        NumbersOnly = True
        TabOrder = 3
        Text = 'EdtQuantidade'
      end
      object EdtPreco: TEdit
        Left = 128
        Top = 152
        Width = 100
        Height = 21
        TabStop = False
        Enabled = False
        TabOrder = 4
        Text = 'EdtPreco'
      end
      object EdtTotal: TEdit
        Left = 128
        Top = 192
        Width = 100
        Height = 21
        TabOrder = 6
        Text = 'EdtTotal'
      end
      object EdtData: TDateTimePicker
        Left = 128
        Top = 72
        Width = 100
        Height = 21
        Date = 42554.953378043980000000
        Time = 42554.953378043980000000
        TabOrder = 1
      end
      object EdtHora: TDateTimePicker
        Left = 234
        Top = 72
        Width = 100
        Height = 21
        Date = 42554.953378043980000000
        Time = 42554.953378043980000000
        Kind = dtkTime
        TabOrder = 2
      end
      object EdtValorImposto: TEdit
        Left = 312
        Top = 192
        Width = 100
        Height = 21
        TabStop = False
        Enabled = False
        TabOrder = 5
        Text = 'EdtValorImposto'
      end
      object EdtBomba: TEdit
        Left = 425
        Top = 32
        Width = 50
        Height = 21
        TabStop = False
        Enabled = False
        TabOrder = 8
        Text = 'EdtCodigo'
      end
      object EdtCombustivel: TEdit
        Left = 425
        Top = 72
        Width = 100
        Height = 21
        TabStop = False
        Enabled = False
        TabOrder = 9
        Text = 'EdtCodigo'
      end
      object EdtPercentualImposto: TEdit
        Left = 425
        Top = 112
        Width = 50
        Height = 21
        TabStop = False
        Enabled = False
        TabOrder = 10
        Text = 'EdtCodigo'
      end
    end
  end
end
