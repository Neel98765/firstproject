import 'package:intl/intl.dart';

class LeaveViewModel {
  int? LeaveApplicationNo;
  String? Employee_No;
  String? Employee_Name;
  String? LeaveType;
  String? FromDate;
  String? ToDate;
  String? COffDate;
  double? Duration;
  String? IsHalfDay;
  String? Reason;
  String? HodReason;
  String? Phone_No;
  double? hod;
  String? ApplicationDateTime;
  String? ApplicationStatus;
  String? DenyReason;
  String? IPAdress;
  String? ApprovalDateTime;
  String? ApprovedBy;
  String? ApprovedIP;
  String? Transfer;
  String? SubstituteId;
  String? ODAgainstLANo;

  LeaveViewModel(
    this.LeaveApplicationNo,
    this.Employee_No,
    this.Employee_Name,
    this.LeaveType,
    this.FromDate,
    this.ToDate,
    this.COffDate,
    this.Duration,
    this.IsHalfDay,
    this.Reason,
    this.Phone_No,
    this.hod,
    this.ApplicationDateTime,
    this.ApplicationStatus,
    this.DenyReason,
    this.IPAdress,
    this.ApprovalDateTime,
    this.ApprovedBy,
    this.ApprovedIP,
    this.Transfer,
    this.SubstituteId,
    this.ODAgainstLANo,
  );

  LeaveViewModel.fromJSon(Map<String, dynamic> json) {
    var f1 = DateFormat('yyyy-MM-ddTHH:mm:ss');
    var f2 = f1.parse(json['FromDate']);
    var f3 = DateFormat('dd-MM-yyyy');
    var f4 = f3.format(f2);
    var f5 = DateFormat('yyyy-MM-ddTHH:mm:ss');
    var f6 = f5.parse(json['ToDate']);
    var f7 = DateFormat('dd-MM-yyyy');
    var f8 = f7.format(f6);
    LeaveApplicationNo = json['LeaveApplicationNo'];
    Employee_No = json['Employee_No'].toString();
    Employee_Name = json['Employee_Name'].toString();
    LeaveType = json['LeaveType'].toString();
    FromDate = f4.toString();
    ToDate = f8.toString();
    COffDate = json['COffDate'].toString();
    Duration = json['Duration'];
    IsHalfDay = json['IsHalfDay'].toString();
    Reason = json['Reason'].toString();
    Phone_No = json['Phone_No'].toString();
    hod = json['hod'];
    ApplicationDateTime = json['ApplicationDateTime'].toString();
    ApplicationStatus = json['ApplicationStatus'].toString();
    DenyReason = json['DenyReason'].toString();
    IPAdress = json['IPAdress'].toString();
    ApprovalDateTime = json['ApprovalDateTime'].toString();
    ApprovedBy = json['ApprovedBy'].toString();
    Transfer = json['Transfer'].toString();
    SubstituteId = json['SubstituteId'].toString();
    ODAgainstLANo = json['ODAgainstLANo'].toString();
  }
}
