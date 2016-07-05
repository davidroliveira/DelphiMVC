inherited FrmCadastroBase: TFrmCadastroBase
  Caption = 'FrmCadastroBase'
  PixelsPerInch = 96
  TextHeight = 13
  object PageControlPrincipal: TPageControl
    Left = 0
    Top = 0
    Width = 546
    Height = 301
    ActivePage = TSLista
    Align = alClient
    TabOrder = 0
    object TSLista: TTabSheet
      Caption = 'Lista'
      object PnlBotton: TPanel
        Left = 0
        Top = 232
        Width = 538
        Height = 41
        Align = alBottom
        TabOrder = 0
        object BtnInserir: TButton
          Left = 296
          Top = 16
          Width = 75
          Height = 25
          Caption = '&Inserir'
          TabOrder = 0
        end
        object BtnAlterar: TButton
          Left = 377
          Top = 16
          Width = 75
          Height = 25
          Caption = '&Alterar'
          TabOrder = 1
        end
        object BtnExcluir: TButton
          Left = 458
          Top = 16
          Width = 75
          Height = 25
          Caption = '&Excluir'
          TabOrder = 2
        end
      end
      object DBGridPrincipal: TDBGrid
        Left = 0
        Top = 0
        Width = 538
        Height = 232
        Align = alClient
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
      end
    end
    object TSDados: TTabSheet
      Caption = 'Dados'
      ImageIndex = 1
      object Panel1: TPanel
        Left = 0
        Top = 232
        Width = 538
        Height = 41
        Align = alBottom
        TabOrder = 0
        object BtnSalvar: TButton
          Left = 377
          Top = 16
          Width = 75
          Height = 25
          Caption = '&Salvar'
          TabOrder = 0
        end
        object BtnCancelar: TButton
          Left = 458
          Top = 16
          Width = 75
          Height = 25
          Caption = '&Cancelar'
          TabOrder = 1
        end
      end
    end
  end
end
