object Form1: TForm1
  Left = 0
  Top = 0
  Margins.Left = 6
  Margins.Top = 6
  Margins.Right = 6
  Margins.Bottom = 6
  Caption = 'Yellowfin VCL Example'
  ClientHeight = 1110
  ClientWidth = 1758
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -24
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  PixelsPerInch = 192
  TextHeight = 32
  object SV: TSplitView
    Left = 0
    Top = 100
    Width = 400
    Height = 1010
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    AnimationStep = 40
    Color = clBlack
    CompactWidth = 100
    OpenedWidth = 400
    Placement = svpLeft
    TabOrder = 0
    ExplicitHeight = 1092
    object catMenuItems: TCategoryButtons
      Left = 0
      Top = 0
      Width = 400
      Height = 1010
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alClient
      BorderStyle = bsNone
      ButtonFlow = cbfVertical
      ButtonHeight = 80
      ButtonWidth = 200
      ButtonOptions = [boFullSize, boShowCaptions, boCaptionOnlyBorder]
      Categories = <
        item
          Caption = 'Connection'
          Color = 16771818
          Collapsed = False
          CanCollapse = False
          Items = <
            item
              Action = actServerSettings
            end
            item
              Action = actLogon
            end
            item
              Action = actLogOff
            end>
        end
        item
          Caption = 'Single Sign On'
          Color = 16771818
          Collapsed = False
          CanCollapse = False
          Items = <
            item
              Action = actDashboards
            end
            item
              Action = actTimelines
            end
            item
              Action = actBrowse
            end
            item
              Action = actAdministration
            end>
        end>
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -24
      Font.Name = 'Segoe UI'
      Font.Style = []
      HotButtonColor = 12477460
      RegularButtonColor = clNone
      SelectedButtonColor = clNone
      TabOrder = 0
      ExplicitHeight = 684
    end
  end
  object pnlToolbar: TPanel
    Left = 0
    Top = 0
    Width = 1758
    Height = 100
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alTop
    BevelOuter = bvNone
    Color = 12477460
    ParentBackground = False
    TabOrder = 1
    ExplicitWidth = 1770
    object imgMenu: TImage
      Left = 20
      Top = 16
      Width = 64
      Height = 64
      Cursor = crHandPoint
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Center = True
      Picture.Data = {
        0954506E67496D61676589504E470D0A1A0A0000000D49484452000000200000
        00200806000000737A7AF40000002B744558744372656174696F6E2054696D65
        0053756E20322041756720323031352031373A30353A3430202D30363030AB9D
        78EE0000000774494D4507DF0802160936B3167602000000097048597300002E
        2300002E230178A53F760000000467414D410000B18F0BFC61050000003B4944
        415478DAEDD3310100200C0341EA5F3454020BA1C3BD81DC925A9F2B00809180
        DD3D19EB00AE00C9000066BE00201900C0CC1700240300003859BE2421B37CDF
        370000000049454E44AE426082}
      OnClick = imgMenuClick
    end
    object lblTitle: TLabel
      Left = 136
      Top = 24
      Width = 338
      Height = 45
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Yellowfin VCL Example'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -32
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object pcMain: TPageControl
    Left = 400
    Top = 100
    Width = 1358
    Height = 1010
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    ActivePage = tabOptions
    Align = alClient
    TabOrder = 2
    ExplicitWidth = 1370
    ExplicitHeight = 1092
    object tabLogin: TTabSheet
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Login'
      inline frameUserLogin1: TframeUserLogin
        Left = 0
        Top = 0
        Width = 1342
        Height = 950
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        TabOrder = 0
        ExplicitWidth = 1354
        ExplicitHeight = 1032
        inherited pcUserLogin: TPageControl
          Width = 1342
          Height = 950
          TabPosition = tpBottom
          ExplicitWidth = 1354
          ExplicitHeight = 1032
          inherited tabLogin: TTabSheet
            ExplicitTop = 8
            ExplicitWidth = 1326
            ExplicitHeight = 934
            inherited gbLogin: TGroupBox
              Left = 422
              Top = 283
              ExplicitLeft = 173
              ExplicitTop = 125
              inherited edtPassword: TLabeledEdit
                EditLabel.ExplicitLeft = 56
                EditLabel.ExplicitTop = 165
                EditLabel.ExplicitWidth = 97
                StyleElements = [seFont, seClient, seBorder]
              end
              inherited edtUserName: TLabeledEdit
                EditLabel.ExplicitLeft = 56
                EditLabel.ExplicitTop = 42
                EditLabel.ExplicitWidth = 118
                StyleElements = [seFont, seClient, seBorder]
              end
            end
          end
          inherited tabSettings: TTabSheet
            inherited Label2: TLabel
              StyleElements = [seFont, seClient, seBorder]
            end
            inherited gbSystemDetails: TGroupBox
              Left = 614
              Top = 222
              ExplicitLeft = 614
              ExplicitTop = 222
              inherited Label1: TLabel
                StyleElements = [seFont, seClient, seBorder]
              end
              inherited edtAdminLogin: TLabeledEdit
                EditLabel.ExplicitLeft = 56
                EditLabel.ExplicitTop = 116
                EditLabel.ExplicitWidth = 172
                StyleElements = [seFont, seClient, seBorder]
              end
              inherited edtAdminPassword: TLabeledEdit
                EditLabel.ExplicitLeft = 56
                EditLabel.ExplicitTop = 199
                EditLabel.ExplicitWidth = 180
                StyleElements = [seFont, seClient, seBorder]
              end
              inherited edtBaseURL: TLabeledEdit
                EditLabel.ExplicitLeft = 56
                EditLabel.ExplicitTop = 34
                EditLabel.ExplicitWidth = 97
                StyleElements = [seFont, seClient, seBorder]
              end
              inherited edtTenant: TLabeledEdit
                EditLabel.ExplicitLeft = 56
                EditLabel.ExplicitTop = 284
                EditLabel.ExplicitWidth = 109
                StyleElements = [seFont, seClient, seBorder]
              end
              inherited edtAppName: TLabeledEdit
                EditLabel.ExplicitLeft = 56
                EditLabel.ExplicitTop = 380
                EditLabel.ExplicitWidth = 114
                StyleElements = [seFont, seClient, seBorder]
              end
              inherited seTimeout: TSpinEdit
                Height = 43
                StyleElements = [seFont, seClient, seBorder]
                ExplicitHeight = 43
              end
            end
          end
        end
      end
    end
    object tabEmbeddedContent: TTabSheet
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Content'
      ImageIndex = 1
      object EdgeBrowser: TEdgeBrowser
        Left = 0
        Top = 0
        Width = 1342
        Height = 950
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        TabOrder = 0
        AllowSingleSignOnUsingOSPrimaryAccount = False
        TargetCompatibleBrowserVersion = '137.0.3296.44'
        UserDataFolder = '%LOCALAPPDATA%\bds.exe.WebView2'
        ExplicitWidth = 1354
        ExplicitHeight = 1032
      end
    end
    object tabOptions: TTabSheet
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'Options'
      ImageIndex = 2
      object Label1: TLabel
        Left = 0
        Top = 0
        Width = 1342
        Height = 54
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alTop
        Alignment = taCenter
        Caption = 'Single Sign On Options'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -40
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        ExplicitWidth = 414
      end
      object FlowPanel1: TFlowPanel
        Left = 0
        Top = 54
        Width = 1342
        Height = 896
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        BevelOuter = bvNone
        Padding.Top = 20
        ParentColor = True
        TabOrder = 0
        ExplicitWidth = 1354
        ExplicitHeight = 978
        object cbToolbar: TCheckBox
          Left = 0
          Top = 20
          Width = 300
          Height = 49
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = 'Toolbar'
          TabOrder = 0
        end
        object cbHeader: TCheckBox
          Left = 300
          Top = 20
          Width = 300
          Height = 49
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = 'Header'
          TabOrder = 1
        end
        object cbFooter: TCheckBox
          Left = 600
          Top = 20
          Width = 300
          Height = 49
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = 'Footer'
          TabOrder = 2
        end
        object cbLogOff: TCheckBox
          Left = 900
          Top = 20
          Width = 300
          Height = 49
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = 'Show Logoff'
          TabOrder = 3
        end
        object cbSideNavigator: TCheckBox
          Left = 0
          Top = 69
          Width = 300
          Height = 49
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = 'Side Navigation'
          TabOrder = 4
        end
      end
    end
  end
  object ActionList1: TActionList
    Left = 280
    Top = 248
    object actLogon: TAction
      Caption = 'Log On'
      OnExecute = actLogonExecute
    end
    object actLogOff: TAction
      Caption = 'Log Off'
      OnExecute = actLogOffExecute
    end
    object actAdministration: TAction
      Caption = 'Administration'
      OnExecute = actAdministrationExecute
    end
    object actDashboards: TAction
      Caption = 'Dashboards'
      OnExecute = actDashboardsExecute
    end
    object actBrowse: TAction
      Caption = 'Browse Content'
      OnExecute = actBrowseExecute
    end
    object actTimelines: TAction
      Caption = 'Timelines'
      OnExecute = actTimelinesExecute
    end
    object actServerSettings: TAction
      Caption = 'Server Settings'
      OnExecute = actServerSettingsExecute
    end
    object actSSOOptions: TAction
      Caption = 'Options'
    end
  end
end
