object frameUserLogin: TframeUserLogin
  Left = 0
  Top = 0
  Width = 918
  Height = 872
  Margins.Left = 6
  Margins.Top = 6
  Margins.Right = 6
  Margins.Bottom = 6
  TabOrder = 0
  OnResize = FrameResize
  PixelsPerInch = 192
  object pcUserLogin: TPageControl
    Left = 0
    Top = 0
    Width = 918
    Height = 872
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    ActivePage = tabSettings
    Align = alClient
    MultiLine = True
    TabOrder = 0
    object tabLogin: TTabSheet
      Margins.Left = 12
      Margins.Top = 12
      Margins.Right = 12
      Margins.Bottom = 12
      Caption = 'Login'
      TabVisible = False
      DesignSize = (
        902
        854)
      object gbLogin: TGroupBox
        Left = 185
        Top = 294
        Width = 539
        Height = 338
        Margins.Left = 12
        Margins.Top = 12
        Margins.Right = 12
        Margins.Bottom = 12
        Anchors = []
        Caption = 'Login'
        TabOrder = 0
        DesignSize = (
          539
          338)
        object edtPassword: TLabeledEdit
          Left = 56
          Top = 203
          Width = 427
          Height = 40
          Margins.Left = 12
          Margins.Top = 12
          Margins.Right = 12
          Margins.Bottom = 12
          Anchors = [akLeft, akTop, akRight]
          EditLabel.Width = 97
          EditLabel.Height = 32
          EditLabel.Margins.Left = 12
          EditLabel.Margins.Top = 12
          EditLabel.Margins.Right = 12
          EditLabel.Margins.Bottom = 12
          EditLabel.Caption = 'Password'
          PasswordChar = '*'
          TabOrder = 0
          Text = 'Darkgoldenrod'
        end
        object btnLogIn: TButton
          Left = 162
          Top = 275
          Width = 215
          Height = 51
          Margins.Left = 12
          Margins.Top = 12
          Margins.Right = 12
          Margins.Bottom = 12
          Anchors = [akTop]
          Caption = 'Login'
          TabOrder = 1
          OnClick = btnLogInClick
        end
        object edtUserName: TLabeledEdit
          Left = 56
          Top = 80
          Width = 427
          Height = 40
          Margins.Left = 12
          Margins.Top = 12
          Margins.Right = 12
          Margins.Bottom = 12
          Anchors = [akLeft, akTop, akRight]
          EditLabel.Width = 118
          EditLabel.Height = 32
          EditLabel.Margins.Left = 12
          EditLabel.Margins.Top = 12
          EditLabel.Margins.Right = 12
          EditLabel.Margins.Bottom = 12
          EditLabel.Caption = 'User Name'
          TabOrder = 2
          Text = 'Bitmap28'
        end
        object cbSingleSignOn: TCheckBox
          Left = 56
          Top = 122
          Width = 433
          Height = 41
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = 'Single Sign On (On Password)'
          Checked = True
          State = cbChecked
          TabOrder = 3
          OnClick = cbSingleSignOnClick
        end
      end
    end
    object tabSettings: TTabSheet
      Margins.Left = 12
      Margins.Top = 12
      Margins.Right = 12
      Margins.Bottom = 12
      Caption = 'Settings'
      ImageIndex = 1
      TabVisible = False
      DesignSize = (
        902
        854)
      object Label2: TLabel
        Left = 0
        Top = 0
        Width = 902
        Height = 32
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alTop
        Caption = 
          'Enter the server details and the credentials to collect the Refr' +
          'esh Token'
        ExplicitWidth = 759
      end
      object gbSystemDetails: TGroupBox
        Left = 85
        Top = 52
        Width = 711
        Height = 688
        Margins.Left = 12
        Margins.Top = 12
        Margins.Right = 12
        Margins.Bottom = 12
        Anchors = []
        Caption = 'Settings'
        TabOrder = 0
        DesignSize = (
          711
          688)
        object Label1: TLabel
          Left = 56
          Top = 476
          Width = 141
          Height = 32
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = 'Timeout (ms)'
        end
        object edtAdminLogin: TLabeledEdit
          Left = 56
          Top = 154
          Width = 614
          Height = 40
          Margins.Left = 12
          Margins.Top = 12
          Margins.Right = 12
          Margins.Bottom = 12
          Anchors = [akLeft, akTop, akRight]
          EditLabel.Width = 172
          EditLabel.Height = 32
          EditLabel.Margins.Left = 12
          EditLabel.Margins.Top = 12
          EditLabel.Margins.Right = 12
          EditLabel.Margins.Bottom = 12
          EditLabel.Caption = 'System Login ID'
          TabOrder = 1
          Text = ''
        end
        object edtAdminPassword: TLabeledEdit
          Left = 56
          Top = 237
          Width = 614
          Height = 40
          Margins.Left = 12
          Margins.Top = 12
          Margins.Right = 12
          Margins.Bottom = 12
          Anchors = [akLeft, akTop, akRight]
          EditLabel.Width = 180
          EditLabel.Height = 32
          EditLabel.Margins.Left = 12
          EditLabel.Margins.Top = 12
          EditLabel.Margins.Right = 12
          EditLabel.Margins.Bottom = 12
          EditLabel.Caption = 'System Password'
          PasswordChar = '*'
          TabOrder = 2
          Text = ''
        end
        object edtBaseURL: TLabeledEdit
          Left = 56
          Top = 72
          Width = 614
          Height = 40
          Margins.Left = 12
          Margins.Top = 12
          Margins.Right = 12
          Margins.Bottom = 12
          Anchors = [akLeft, akTop, akRight]
          EditLabel.Width = 97
          EditLabel.Height = 32
          EditLabel.Margins.Left = 12
          EditLabel.Margins.Top = 12
          EditLabel.Margins.Right = 12
          EditLabel.Margins.Bottom = 12
          EditLabel.Caption = 'Base URL'
          TabOrder = 0
          Text = ''
        end
        object edtTenant: TLabeledEdit
          Left = 56
          Top = 322
          Width = 614
          Height = 40
          Margins.Left = 12
          Margins.Top = 12
          Margins.Right = 12
          Margins.Bottom = 12
          Anchors = [akLeft, akTop, akRight]
          EditLabel.Width = 109
          EditLabel.Height = 32
          EditLabel.Margins.Left = 12
          EditLabel.Margins.Top = 12
          EditLabel.Margins.Right = 12
          EditLabel.Margins.Bottom = 12
          EditLabel.Caption = 'Client Org'
          TabOrder = 3
          Text = ''
        end
        object edtAppName: TLabeledEdit
          Left = 56
          Top = 418
          Width = 614
          Height = 40
          Margins.Left = 12
          Margins.Top = 12
          Margins.Right = 12
          Margins.Bottom = 12
          Anchors = [akLeft, akTop, akRight]
          EditLabel.Width = 114
          EditLabel.Height = 32
          EditLabel.Margins.Left = 12
          EditLabel.Margins.Top = 12
          EditLabel.Margins.Right = 12
          EditLabel.Margins.Bottom = 12
          EditLabel.Caption = 'App Name'
          TabOrder = 4
          Text = ''
        end
        object seTimeout: TSpinEdit
          Left = 56
          Top = 512
          Width = 617
          Height = 43
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Increment = 100
          MaxValue = 30000
          MinValue = 100
          TabOrder = 5
          Value = 100
        end
        object btnUpdate: TButton
          Left = 272
          Top = 592
          Width = 153
          Height = 57
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = 'Update'
          TabOrder = 6
          OnClick = btnUpdateClick
        end
      end
    end
  end
end
