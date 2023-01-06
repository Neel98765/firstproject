import 'dart:convert';
import 'dart:core';

import 'package:firstproject/model/employee_leave_type_model.dart';
import 'package:firstproject/model/delete_leave_model.dart';
import 'package:firstproject/model/leave_pending_model.dart';
import 'package:firstproject/model/leave_type_model.dart';
import 'package:firstproject/model/login_model.dart';
import 'package:firstproject/model/punch_history_model.dart';
import 'package:firstproject/model/punchin_model.dart';
import 'package:firstproject/model/punchout_model.dart';
import 'package:flutter/foundation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../commonfiles/constant.dart';
import '../model/hod_leave_approval_model.dart';
import '../model/leave_form_details_model.dart';
import '../model/emp_leave_view_model.dart';
import '../view/database screen.dart';

class APICall {
  DatabaseHelper databaseHelper = DatabaseHelper.instance;

  Future<LoginModel> loginData(String Employee_No, String Password) async {
    var response = await http.post(Uri.parse(Constant.API_BASE_URL), body: {
      'Employee_No': Employee_No,
      'Password': Password,
    }).timeout(const Duration(seconds: 120));

    if (kDebugMode) {
      print("getLoginData: ${response.body}");
    }
    if (kDebugMode) {
      print("getEmpno: ${Employee_No}");
    }

    final body = json.decode(response.body);
    if (response.statusCode == 200 && body['Status'].toString() == "1") {
      var data = LoginModel.fromJSon(body);

      GetStorage().write('Employee_No', body['Result']['Employee_No']);
      GetStorage().write('Latitude', body['Result']['Latitude']);
      GetStorage().write('Longitude', body['Result']['Longitude']);
      GetStorage().write('isHOD', body['Result']['isHOD']);
      GetStorage().write('isManual', body['Result']['isManual']);
      GetStorage().write('MANDT', body['Result']['MANDT']);
      GetStorage().write('Contact1', body['Result']['Contact1']);
      GetStorage().write('HOD_EMP_CODE', body['Result']['HOD_EMP_CODE']);

      databaseHelper.deleteuser();
      databaseHelper.insertuser({
        "Employee_No": body['Result']['Employee_No'],
        "Employee_NAME": body['Result']['Employee_NAME'],
        "Company_Name": body['Result']['Employee_No'],
        "Branch_Name": body['Result']['Branch_Name'],
        "Main_Dept_NAME": body['Result']['Main_Dept_NAME'],
        "Sub_Dept_NAME": body['Result']['Sub_Dept_NAME'],
        "Position_NAME": body['Result']['Position_NAME'],
        "JOBTitle_Name": body['Result']['JOBTitle_Name'].toString(),
        "DOJ": body['Result']['DOJ'].toString(),
        "DOR": body['Result']['DOR'],
        "EMP_GROUP": body['Result']['EMP_GROUP'],
        "EMP_LEVEL": body['Result']['EMP_LEVEL'],
        "HOD": body['Result']['HOD'],
        "EMAILID": body['Result']['EMAILID'],
        "MANDT": body['Result']['MANDT'],
        "Latitude": body['Result']['Latitude'],
        "Longitude": body['Result']['Longitude'],
        "HOD_EMP_CODE": body['Result']['HOD_EMP_CODE'],
        "isHOD": body['Result']['isHOD'],
        "isManual": body['Result']['isManual'].toString(),
        "Attatchment": body['Result']['Attatchment'].toString(),
        "Contact1": body['Result']['Contact1'],
        "status": body['Result']['status'].toString(),
      });
      return data;
    } else {
      throw Exception('Login fail');
    }
  }

  Future<PunchInModel> punchinData(
      dynamic EmpId, dynamic latitude, dynamic longitude) async {
    var response = await http.post(Uri.parse(Constant.PUNCH_IN_URL), body: {
      'EmpId': GetStorage().read('Employee_No').toString(),
      'latitude': latitude,
      'longitude': longitude,
    }).timeout(const Duration(seconds: 120));
    if (kDebugMode) {
      print("getPunchinData: ${response.body}");
    }

    final body = json.decode(response.body);
    if (response.statusCode == 200 && body['Status'].toString() == "1") {
      var punch = PunchInModel.fromJSon(body);
      return punch;
    } else {
      throw Exception('Punchin fail');
    }
  }

  Future<List<PunchHistoryModel>?> getdisplayquickquote(String FaceId) async {
    List<PunchHistoryModel> data = [];

    var response =
        await http.post(Uri.parse(Constant.PUNCH_HISTORY_URL), body: {
      'FaceId': GetStorage().read('Employee_No').toString(),
    });
    var i = 0;
    final body = json.decode(response.body);
    for (var item in body) {
      data.add(PunchHistoryModel.fromJSon(item));
      if (item['Status'] == 'In' && i == 0) {
        i = 1;
        var f1 = DateFormat('MM/dd/yyyy HH:mm:ss');
        var f2 = f1.parse(item['punchtime']);
        var f3 = DateFormat('dd/MM/yyyy hh:mm:ss');
        var f4 = f3.format(f2);
        GetStorage().write('punchtime', f4);
      }
    }
    return data;
  }

  Future<PunchOutModel> punchoutData(
      dynamic EmpId, dynamic latitude, dynamic longitude) async {
    var response = await http.post(Uri.parse(Constant.PUNCH_OUT_URL), body: {
      'EmpId': GetStorage().read('Employee_No').toString(),
      'latitude': latitude,
      'longitude': longitude,
    }).timeout(const Duration(seconds: 120));

    if (kDebugMode) {
      print("getPunchoutData: ${response.body}");
    }

    final body = json.decode(response.body);
    if (response.statusCode == 200 && body['Status'].toString() == "1") {
      var punch = PunchOutModel.fromJSon(body);
      return punch;
    } else {
      throw Exception('');
    }
  }

  Future<List<LeavePendingModel>?> getleavepending(String Employee_No) async {
    List<LeavePendingModel> data = [];

    var response =
        await http.post(Uri.parse(Constant.LEAVE_PENDING_URL), body: {
      'Employee_No': GetStorage().read('Employee_No').toString(),
    });
    final body = json.decode(response.body);
    if (response.statusCode == 200 && body['Status'].toString() == "1") {
      for (var item in body['Result']) {
        data.add(LeavePendingModel.fromJSon(item));
      }
      return data;
    } else {
      return data;
    }
  }

  Future<List<EmployeeLeaveModel>?> getapprovedleave(String Employee_No) async {
    List<EmployeeLeaveModel> data = [];

    var response =
        await http.post(Uri.parse(Constant.APPROVED_LEAVE_URL), body: {
      'Employee_No': GetStorage().read('Employee_No').toString(),
    });
    final body = json.decode(response.body);
    if (response.statusCode == 200 && body['Status'].toString() == "1") {
      for (var item in body['Result']) {
        data.add(EmployeeLeaveModel.fromJSon(item));
      }
      return data;
    } else {
      return data;
    }
  }

  Future<List<LeaveTypeModel>?> leaveData(String employee_no) async {
    List<LeaveTypeModel> data = [];
    var response = await http.post(Uri.parse(Constant.LEAVE_TYPE_URL), body: {
      'Employee_No': GetStorage().read('Employee_No').toString(),
    }).timeout(const Duration(seconds: 120));
    if (kDebugMode) {
      print("getLeaveData: ${response.body}");
    }

    final body = json.decode(response.body);
    if (response.statusCode == 200 && body['Status'].toString() == '1') {
      for (var item in body['Result']) {
        data.add(LeaveTypeModel.fromJSon(item));
      }
      return data;
    } else {
      throw Exception('No Leave Balance');
    }
  }

  Future<LeaveFormModel> leaveformData(
      String Employee_No,
      String FromDate,
      String ToDate,
      String Duration1,
      String LeaveType,
      String IsHalfDay,
      String Phone_No,
      String Reason,
      String MANDT) async {
    var response = await http.post(Uri.parse(Constant.LEAVE_FORM_URL), body: {
      'Employee_No': GetStorage().read('Employee_No').toString(),
      'FromDate': FromDate,
      'ToDate': ToDate,
      'COffDate': '1900-01-01 00:00:00.000',
      'Duration': Duration1,
      'LeaveType': LeaveType,
      'IsHalfDay': IsHalfDay,
      'Phone_No': GetStorage().read('Contact1').toString(),
      'Reason': Reason,
      'MANDT': GetStorage().read('MANDT').toString(),
    }).timeout(const Duration(seconds: 120));

    if (kDebugMode) {
      print("getPunchoutData: ${response.body}");
    }
    if (kDebugMode) {
      print({
        'Employee_No': GetStorage().read('Employee_No').toString(),
        'FromDate': FromDate,
        'ToDate': ToDate,
        'COffDate': '1900-01-01 00:00:00.000',
        'Duration': Duration1,
        'LeaveType': LeaveType,
        'IsHalfDay': IsHalfDay,
        'Phone_No': GetStorage().read('Contact1').toString(),
        'Reason': Reason,
        'MANDT': GetStorage().read('MANDT').toString(),
      });
    }

    final body = json.decode(response.body);
    if (response.statusCode == 200 && body['Status'].toString() == "1") {
      var leave = LeaveFormModel.fromJSon(body);
      return leave;
    } else {
      throw Exception('');
    }
  }

  Future<List<LeaveViewModel>?> leaveviewData(String LeaveApplicationNo) async {
    List<LeaveViewModel> data = [];
    var response = await http.post(Uri.parse(Constant.LEAVE_VIEW_URL), body: {
      'LeaveApplicationNo': GetStorage().read('LeaveApplicationNo').toString(),
    }).timeout(const Duration(seconds: 120));
    if (kDebugMode) {
      print("getLeaveView: ${response.body}");
    }

    final body = json.decode(response.body);
    if (response.statusCode == 200 && body['Status'].toString() == '1') {
      for (var item in body['Result']) {
        data.add(LeaveViewModel.fromJSon(item));
      }
      return data;
    } else {
      throw Exception('');
    }
  }

  Future<DeleteLeaveModel> deleteData(String LeaveApplicationNo) async {
    var response = await http.post(Uri.parse(Constant.DELETE_LEAVE_URL), body: {
      'LeaveApplicationNo': GetStorage().read('LeaveApplicationNo').toString(),
    }).timeout(const Duration(seconds: 120));

    if (kDebugMode) {
      print("getPunchoutData: ${response.body}");
    }

    final body = json.decode(response.body);
    if (response.statusCode == 200 && body['Status'].toString() == "1") {
      var delete = DeleteLeaveModel.fromJSon(body);
      return delete;
    } else {
      throw Exception('');
    }
  }

  Future<List<HodLeaveApproveModel>?> hodleaveviewData(
      int HOD) async {
    List<HodLeaveApproveModel> data = [];
    var response =
        await http.post(Uri.parse(Constant.HOD_LEAVE_APPROVE_URL), body: {
      'HOD': GetStorage().read('Employee_No').toString(),
    }).timeout(const Duration(seconds: 120));
    if (kDebugMode) {
      print("getHodLeaveView: ${response.body}");
    }

    final body = json.decode(response.body);
    if (response.statusCode == 200 && body['Status'].toString() == '1') {
      for (var item in body['Result']) {
        data.add(HodLeaveApproveModel.fromJSon(item));
      }
      return data;
    } else {
      throw Exception('');
    }
  }
}
