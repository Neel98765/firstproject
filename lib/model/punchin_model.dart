class PunchInModel {
  int? Status;

  PunchInModel(this.Status);

  PunchInModel.fromJSon(Map<String, dynamic> json) {
    Status = json['Status'];

    print(json);
  }
}
