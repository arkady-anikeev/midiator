object FramePianoRoll: TFramePianoRoll
  Left = 0
  Top = 0
  Width = 1100
  Height = 688
  TabOrder = 0
  OnResize = FrameResize
  object Panel3: TPanel
    Left = 0
    Top = 73
    Width = 1100
    Height = 615
    Align = alClient
    Caption = 'Panel3'
    TabOrder = 0
    object PaintBox: TPaintBox
      Left = 89
      Top = 1
      Width = 988
      Height = 530
      Align = alClient
      OnMouseDown = PaintBoxMouseDown
      OnPaint = PaintBoxPaint
      ExplicitTop = 48
      ExplicitHeight = 483
    end
    object Splitter1: TSplitter
      Left = 1
      Top = 531
      Width = 1098
      Height = 3
      Cursor = crVSplit
      Align = alBottom
      ExplicitTop = 42
      ExplicitWidth = 277
    end
    object PanelControls: TPanel
      Left = 1
      Top = 534
      Width = 1098
      Height = 80
      Align = alBottom
      Caption = 'PanelControls'
      TabOrder = 0
      object Label4: TLabel
        Left = 19
        Top = 6
        Width = 34
        Height = 13
        Caption = 'Scale X'
      end
      object Label5: TLabel
        Left = 19
        Top = 33
        Width = 34
        Height = 13
        Caption = 'Scale Y'
      end
      object SpinEditScaleX: TSpinEdit
        Left = 59
        Top = 6
        Width = 45
        Height = 22
        MaxValue = 8
        MinValue = 1
        ParentColor = True
        TabOrder = 0
        Value = 4
        OnChange = SpinEditScaleChange
      end
      object SpinEditScaleY: TSpinEdit
        Left = 59
        Top = 34
        Width = 45
        Height = 22
        MaxValue = 8
        MinValue = 1
        ParentColor = True
        TabOrder = 1
        Value = 4
        OnChange = SpinEditScaleChange
      end
    end
    object ScrollBarVertical: TScrollBar
      Left = 1077
      Top = 1
      Width = 22
      Height = 530
      Align = alRight
      Kind = sbVertical
      LargeChange = 12
      Max = 127
      PageSize = 0
      TabOrder = 1
      OnChange = ScrollBarVerticalChange
    end
    object PanelKeys: TPanel
      Left = 1
      Top = 1
      Width = 88
      Height = 530
      Align = alLeft
      Caption = 'PanelKeys'
      TabOrder = 2
      object PaintBoxKeys: TPaintBox
        Left = 1
        Top = 1
        Width = 86
        Height = 528
        Align = alClient
        OnPaint = PaintBoxKeysPaint
        ExplicitLeft = -4
        ExplicitTop = -1
        ExplicitHeight = 297
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1100
    Height = 73
    Align = alTop
    Caption = 'Panel1'
    TabOrder = 1
    DesignSize = (
      1100
      73)
    object PaintBoxMarkers: TPaintBox
      Left = 89
      Top = 25
      Width = 975
      Height = 42
      Anchors = [akLeft, akTop, akRight, akBottom]
      OnPaint = PaintBoxMarkersPaint
      ExplicitWidth = 952
    end
    object Label1: TLabel
      Left = 8
      Top = 7
      Width = 31
      Height = 13
      Caption = 'Label1'
    end
    object Label2: TLabel
      Left = 8
      Top = 26
      Width = 31
      Height = 13
      Caption = 'Label2'
    end
    object Label3: TLabel
      Left = 8
      Top = 45
      Width = 31
      Height = 13
      Caption = 'Label3'
    end
    object ScrollBarHorizontal: TScrollBar
      Left = 89
      Top = 2
      Width = 952
      Height = 17
      PageSize = 0
      TabOrder = 0
      OnChange = ScrollBarHorizontalChange
    end
    object Button1: TButton
      Left = 1070
      Top = 2
      Width = 24
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Button1'
      TabOrder = 1
    end
  end
end
