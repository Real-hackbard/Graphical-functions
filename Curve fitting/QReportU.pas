unit QReportU;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls;

type
  TQReport = class(TQuickRep)
    QRBand1: TQRBand;
    QRImage1: TQRImage;
  private
  public
    constructor create(AOwner:TComponent); reintroduce;
    property Image:TQRImage read QRImage1;
  end;

var
  QReport: TQReport;

implementation

{$R *.DFM}

{ TQReport }

constructor TQReport.create(AOwner: TComponent);
begin
  inherited create(AOwner);
end;

end.
