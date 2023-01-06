class PunchOutModel {
  int? status;

  PunchOutModel(this.status);

  PunchOutModel.fromJSon(Map<String, dynamic> json) {
    status = json['status'];

    print(json);
  }
}
