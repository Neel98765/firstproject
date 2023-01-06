import 'dart:convert';

class LeaveTypeModel {
  int? Status;
  int? Employee_No;
  double? CL;
  double? SL;
  double? EL;

  LeaveTypeModel(this.Status, this.CL, this.EL, this.SL);

  LeaveTypeModel.fromJSon(Map<String, dynamic> json) {
    // print("json ${jsonDecode(json['Result'])}");
    Status = json['Status'];
    Employee_No = json['Employee_No'];
    CL = json['CL'];
    SL = json['SL'];
    EL = json['EL'];
  }
}
