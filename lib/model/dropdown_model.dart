class DropdownModel {
  String? Id;
  String? Text;
  String? Value;

  DropdownModel(this.Id, this.Text, this.Value);

  DropdownModel.fromJSon(Map<String, dynamic> json) {
    Id = json['Id'].toString();
    Text = json['Text'].toString();
    Value = json['Value'].toString();
  }
}
