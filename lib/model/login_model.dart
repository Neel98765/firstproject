class LoginModel {
  String? Employee_No;
  String? Employee_NAME;
  String? Company_Name;
  String? Branch_Name;
  String? Main_Dept_NAME;
  String? Sub_Dept_NAME;
  String? Position_NAME;
  String? JOBTitle_Name;
  String? DOJ;
  String? DOR;
  String? EMP_GROUP;
  String? EMP_LEVEL;
  String? HOD;
  String? EMAILID;
  String? MANDT;
  String? Latitude;
  String? Longitude;
  String? HOD_EMP_CODE;
  String? isHOD;
  String? isManual;
  String? Attatchment;
  String? Contact1;
  int? Status;

  LoginModel(
      this.Employee_No,
      this.Employee_NAME,
      this.Company_Name,
      this.Branch_Name,
      this.Main_Dept_NAME,
      this.Sub_Dept_NAME,
      this.Position_NAME,
      this.JOBTitle_Name,
      this.DOJ,
      this.DOR,
      this.EMP_GROUP,
      this.HOD,
      this.EMAILID,
      this.MANDT,
      this.Latitude,
      this.Longitude,
      this.HOD_EMP_CODE,
      this.isHOD,
      this.isManual,
      this.Attatchment,
      this.Contact1,
      this.Status);

  LoginModel.fromJSon(Map<String, dynamic> json) {
    Employee_No = json['Employee_No'].toString();
    Employee_NAME = json['Employee_NAME'].toString();
    Company_Name = json['Company_Name'].toString();
    Branch_Name = json['Branch_Name'].toString();
    Main_Dept_NAME = json['Main_Dept_NAME'].toString();
    Sub_Dept_NAME = json['Sub_Dept_NAME'].toString();
    Position_NAME = json['Position_NAME'].toString();
    JOBTitle_Name = json['JOBTitle_Name'].toString();
    DOJ = json['DOJ'].toString();
    DOR = json['DOR'].toString();
    EMP_GROUP = json['EMP_GROUP'].toString();
    HOD = json['HOD'].toString();
    EMAILID = json['EMAILID'].toString();
    MANDT = json['MANDT'].toString();
    Latitude = json['Latitude'].toString();
    Longitude = json['Longitude'].toString();
    HOD_EMP_CODE = json['HOD_EMP_CODE'].toString();
    isHOD = json['isHOD'].toString();
    isManual = json['isManual'].toString();
    Attatchment = json['Attatchment'].toString();
    Contact1 = json['Contact1'].toString();
    Status = json['Status'];
  }

// Map<String, dynamic> toJson() {
//   final data = <String, dynamic>{};
//   data['Employee_No'] = Employee_No;
//   data['Employee_NAME'] = Employee_NAME;
//   data['Company_Name'] = Company_Name;
//   data['Branch_Name'] = Branch_Name;
//   data['Main_Dept_NAME'] = Main_Dept_NAME;
//   data['Sub_Dept_NAME'] = Sub_Dept_NAME;
//   data['Position_NAME'] = Position_NAME;
//   data['Position_NAME'] = Position_NAME;
//   data['JOBTitle_Name'] = JOBTitle_Name;
//   data['DOJ'] = DOJ;
//   data['DOR'] = DOR;
//   data['EMP_GROUP'] = EMP_GROUP;
//   data['HOD'] = HOD;
//   data['EMAILID'] = EMAILID;
//   data['MANDT'] = MANDT;
//   data['Latitude'] = Latitude;
//   data['Longitude'] = Longitude;
//   data['HOD_EMP_CODE'] = HOD_EMP_CODE;
//   data['isHOD'] = isHOD;
//   data['isManual'] = isManual;
//   data['Attatchment'] = Attatchment;
//   data['Contact1'] = Contact1;
//   data['status'] = status;
//   return data;
// }
}
