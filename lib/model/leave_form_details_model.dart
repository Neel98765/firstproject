class LeaveFormModel {
  int? Status;
  String? Message;

  LeaveFormModel(this.Status, this.Message);

  LeaveFormModel.fromJSon(Map<String, dynamic> json) {
    Status = json['Status'];
    Message = json['Message'].toString();
  }
}
