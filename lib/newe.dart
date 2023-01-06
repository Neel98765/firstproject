import 'package:firstproject/view/database%20screen.dart';
import 'package:flutter/material.dart';

class ViewScreen extends StatefulWidget {
  const ViewScreen({Key? key}) : super(key: key);

  @override
  State<ViewScreen> createState() => _ViewScreenState();
}

class _ViewScreenState extends State<ViewScreen> {
  DatabaseHelper databaseHelper = DatabaseHelper.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      alignment: Alignment.topLeft,
      padding: EdgeInsets.all(20),
      child: FutureBuilder<dynamic>(
          future: getUserData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(snapshot.data![index]["Employee_No"].toString() +
                          "\n" +
                          snapshot.data![index]["Latitude"].toString()),
                    );
                  });
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return const CircularProgressIndicator();
          }),
    ));
  }

  getUserData() {
    return databaseHelper.getuserdata();
  }
}
