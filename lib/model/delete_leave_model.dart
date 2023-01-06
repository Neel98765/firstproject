class DeleteLeaveModel {
  int? Status;
  String? Message;

  DeleteLeaveModel(this.Status, this.Message);

  DeleteLeaveModel.fromJSon(Map<String, dynamic> json) {
    Status = json['Status'];
    Message = json['Message'].toString();
  }
}
