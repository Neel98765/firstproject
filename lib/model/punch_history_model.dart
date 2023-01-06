import 'package:intl/intl.dart';

class PunchHistoryModel {
  String? EmpId;
  String? Latitude;
  String? Longitude;
  String? SrNo;
  String? FaceId;
  String? Status;
  String? zYear;
  String? zMonth;
  String? zDay;
  String? zHr;
  String? zMin;
  String? MANDT;
  String? mob1;
  String? mob2;
  String? ChkID;
  String? punchtime;

  PunchHistoryModel(
    this.EmpId,
    this.Latitude,
    this.Longitude,
    this.SrNo,
    this.FaceId,
    this.Status,
    this.zYear,
    this.zMonth,
    this.zDay,
    this.zHr,
    this.zMin,
    this.MANDT,
    this.mob1,
    this.mob2,
    this.ChkID,
    this.punchtime,
  );

  PunchHistoryModel.fromJSon(Map<String, dynamic> json) {
    var f1 = DateFormat('MM/dd/yyyy HH:mm:ss');
    var f2 = f1.parse(json['punchtime']);
    var f3 = DateFormat('dd/MM/yyyy hh:mm:ss');
    var f4 = f3.format(f2);

    EmpId = json['EmpId'].toString();
    Latitude = json['Latitude'].toString();
    Longitude = json['Longitude'].toString();
    SrNo = json['SrNo'].toString();
    FaceId = json['FaceId'].toString();
    Status = json['Status'].toString();
    zYear = json['zYear'].toString();
    zMonth = json['zMonth'].toString();
    zDay = json['zDay'].toString();
    zHr = json['zHr'].toString();
    zMin = json['zMin'].toString();
    MANDT = json['MANDT'].toString();
    mob1 = json['mob1'].toString();
    mob2 = json['mob2'].toString();
    ChkID = json['ChkID'].toString();
    punchtime = f4.toString();
  }
}
