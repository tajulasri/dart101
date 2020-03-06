import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:theta_edge/providers/leave_provider.dart';

class LeaveSummariesScreen extends StatefulWidget {
  LeaveSummariesScreen({Key key}) : super(key: key);

  @override
  _LeaveSummariesScreenState createState() => _LeaveSummariesScreenState();
}

class _LeaveSummariesScreenState extends State<LeaveSummariesScreen> {
  @override
  Widget build(BuildContext context) {
    //this is how to call our provider class
    var _leaveProvider = Provider.of<LeaveProvider>(context);

    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            FlatButton(
              onPressed: _leaveProvider.refresh,
              child: Icon(
                Icons.refresh,
                color: Colors.white,
              ),
            )
          ],
          bottom: TabBar(
            indicatorWeight: 3,
            tabs: <Widget>[
              Tab(
                child: Text(
                  "Pending",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Tab(
                child: Text(
                  "Approved",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Tab(
                child: Text(
                  "Rejected",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Container(
              child: ListView.builder(
                itemCount: _leaveProvider.pendingLeaves.length,
                itemBuilder: (context, position) {
                  return ListTile(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        '/leave_detail',
                        arguments: {
                          //mock our id record
                          "id": position + 1,
                        },
                      );
                    },
                    leading: Icon(
                      Icons.calendar_today,
                    ),
                    subtitle: Text(
                      _leaveProvider.pendingLeaves[position].startDate,
                    ),
                    title: Text("Cuti Tahunan"),
                    trailing: Icon(
                      Icons.keyboard_arrow_right,
                    ),
                  );
                },
              ),
            ),

            //this tab represent for approved leavs
            Container(
              child: ListView.builder(
                itemCount: _leaveProvider.approvedLeaves.length,
                itemBuilder: (context, position) {
                  return ListTile(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        '/leave_detail',
                        arguments: {
                          //mock our id record
                          "id": _leaveProvider.approvedLeaves[position].id,
                        },
                      );
                    },
                    leading: Icon(
                      Icons.calendar_today,
                    ),
                    subtitle: Text("20 feb 2019 - 23 Feb 2020"),
                    title: Text(
                      _leaveProvider.approvedLeaves[position].title,
                    ),
                    trailing: Icon(
                      Icons.keyboard_arrow_right,
                    ),
                  );
                },
              ),
            ),
            Container(
              child: ListView.builder(
                itemCount: 40,
                itemBuilder: (context, position) {
                  return ListTile(
                    leading: Icon(
                      Icons.calendar_today,
                    ),
                    subtitle: Text("20 feb 2019 - 23 Feb 2020"),
                    title: Text("Cuti Tahunan"),
                    trailing: Icon(
                      Icons.keyboard_arrow_right,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          icon: Icon(Icons.add),
          label: Text("Apply"),
          onPressed: () {
            Navigator.of(context).pushNamed('/leave_create');
          },
          backgroundColor: Colors.pink,
        ),
        //floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
