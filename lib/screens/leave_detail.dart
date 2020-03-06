import 'package:flutter/material.dart';
import 'package:theta_edge/screens/loading.dart';
import 'package:theta_edge/services/leave_service.dart';

class LeaveDetailScreen extends StatefulWidget {
  LeaveDetailScreen({Key key}) : super(key: key);

  @override
  _LeaveDetailScreenState createState() => _LeaveDetailScreenState();
}

class _LeaveDetailScreenState extends State<LeaveDetailScreen> {
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> arguments = ModalRoute.of(context).settings.arguments;

    return FutureBuilder(
      //bind our widget to future service
      future: LeaveService().getLeave(arguments['id']),
      initialData: null,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        print(snapshot.data);

        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return LoadingScreen();
          case ConnectionState.done:
            return Scaffold(
              appBar: AppBar(
                title: Text("position ${arguments['id']}"),
              ),
              body: Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 100,
                      child: Card(
                        child: Row(
                          children: <Widget>[
                            Text(
                              snapshot.data['title'],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          default:
            return LoadingScreen();
        }
      },
    );
  }
}
