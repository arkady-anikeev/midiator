object OptionsForm: TOptionsForm
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Options'
  ClientHeight = 295
  ClientWidth = 428
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 38
    Width = 84
    Height = 13
    Caption = 'MIDI input device'
  end
  object Label2: TLabel
    Left = 16
    Top = 11
    Width = 92
    Height = 13
    Caption = 'MIDI output device'
  end
  object DevicePropsLabel: TLabel
    Left = 16
    Top = 70
    Width = 62
    Height = 13
    Caption = 'Device props'
  end
  object Button1: TButton
    Left = 345
    Top = 262
    Width = 75
    Height = 25
    Caption = 'Close'
    Default = True
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 345
    Top = 231
    Width = 75
    Height = 25
    Caption = 'Restore'
    TabOrder = 1
  end
  object cbInputDevices: TComboBox
    Left = 120
    Top = 35
    Width = 300
    Height = 21
    TabOrder = 2
  end
  object cbOutputDevices: TComboBox
    Left = 120
    Top = 8
    Width = 300
    Height = 21
    TabOrder = 3
    OnChange = cbOutputDevicesChange
  end
end
