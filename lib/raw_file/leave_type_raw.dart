import 'package:firstproject/model/leave_type_model.dart';
import 'package:flutter/material.dart';

class LeaveTypeRaw extends StatelessWidget {
  LeaveTypeModel leaveTypeModel;

  LeaveTypeRaw({Key? key, required this.leaveTypeModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print({'.....${leaveTypeModel.CL.toString()}'});
    return Column(children: [
      SizedBox(
        height: 20,
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 20,
          ),
          Row(
            children: [
              Container(
                width: 45,
                height: 25,
                decoration: BoxDecoration(
                    color: Colors.orangeAccent,
                    border: Border.all(
                      color: Colors.orangeAccent,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                alignment: Alignment.center,
                child: Text('CL',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Roboto')),
              ),
              SizedBox(width: 20),
              Container(
                width: 45,
                height: 25,
                decoration: BoxDecoration(
                    color: Colors.orangeAccent,
                    border: Border.all(
                      color: Colors.orangeAccent,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                alignment: Alignment.center,
                child: Text('SL',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Roboto')),
              ),
              SizedBox(width: 20),
              Container(
                width: 45,
                height: 25,
                decoration: BoxDecoration(
                    color: Colors.orangeAccent,
                    border: Border.all(
                      color: Colors.orangeAccent,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                alignment: Alignment.center,
                child: Text('EL',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Roboto')),
              )
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Container(
                width: 40,
                height: 25,
                decoration: BoxDecoration(
                    color: Colors.grey,
                    border: Border.all(
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(40))),
                alignment: Alignment.center,
                child: Text(
                  leaveTypeModel.CL.toString(),
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Roboto'),
                ),
              ),
              SizedBox(width: 20),
              Container(
                width: 40,
                height: 25,
                decoration: BoxDecoration(
                    color: Colors.grey,
                    border: Border.all(
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                alignment: Alignment.center,
                child: Text(
                  leaveTypeModel.SL.toString(),
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Roboto'),
                ),
              ),
              SizedBox(width: 20),
              Container(
                width: 40,
                height: 25,
                decoration: BoxDecoration(
                    color: Colors.grey,
                    border: Border.all(
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                alignment: Alignment.center,
                child: Text(
                  leaveTypeModel.EL.toString(),
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Roboto'),
                ),
              ),
            ],
          ),
        ],
      )
    ]);
  }
}
