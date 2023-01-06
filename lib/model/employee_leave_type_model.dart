import 'package:intl/intl.dart';

class EmployeeLeaveModel {
  String? LeaveType;
  String? FromDate;
  String? ToDate;
  String? CoffDate;
  int? Duration;
  String? Reason;
  String? ApplicationStatus;
  String? DenyReason;
  String? ContactNo;
  int? LeaveAppId;
  String? Employee;
  String? hod;
  String? ApplicationDateTime;
  String? LeaveApplicationNo;

  EmployeeLeaveModel(
    this.LeaveType,
    this.FromDate,
    this.ToDate,
    this.CoffDate,
    this.Duration,
    this.Reason,
    this.ApplicationStatus,
    this.DenyReason,
    this.ContactNo,
    this.LeaveAppId,
    this.Employee,
    this.hod,
    this.ApplicationDateTime,
    this.LeaveApplicationNo,
  );

  EmployeeLeaveModel.fromJSon(Map<String, dynamic> json) {
    var f1 = DateFormat('yyyy-MM-ddTHH:mm:ss');
    var f2 = f1.parse(json['FromDate']);
    var f3 = DateFormat('dd-MM-yyyy');
    var f4 = f3.format(f2);
    var f5 = DateFormat('yyyy-MM-ddTHH:mm:ss');
    var f6 = f5.parse(json['ToDate']);
    var f7 = DateFormat('dd-MM-yyyy');
    var f8 = f7.format(f6);
    LeaveType = json['LeaveType'].toString();
    FromDate = f4.toString();
    ToDate = f8.toString();
    CoffDate = json['CoffDate'].toString();
    Duration = json['Duration'].toInt();
    Reason = json['Reason'].toString();
    ApplicationStatus = json['ApplicationStatus'].toString();
    DenyReason = json['DenyReason'].toString();
    ContactNo = json['ContactNo'].toString();
    LeaveAppId = json['LeaveAppId'];
    Employee = json['Employee'].toString();
    hod = json['hod'].toString();
    ApplicationDateTime = json['ApplicationDateTime'].toString();
    LeaveApplicationNo = json['LeaveApplicationNo'].toString();
  }
}
