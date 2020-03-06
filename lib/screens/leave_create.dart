import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:theta_edge/models/leave.dart';
import 'package:theta_edge/providers/leave_provider.dart';

class LeaveCreateScreen extends StatefulWidget {
  LeaveCreateScreen({Key key}) : super(key: key);

  @override
  _LeaveCreateScreenState createState() => _LeaveCreateScreenState();
}

class _LeaveCreateScreenState extends State<LeaveCreateScreen> {
  TextEditingController _startDateController = TextEditingController();
  TextEditingController _endDateController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    //initiate our provider inside our widget tree
    var _leaveProvider = Provider.of<LeaveProvider>(
      context,
    );

    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: _startDateController,
              decoration: InputDecoration(
                hintText: "Start Date",
              ),
            ),
            TextFormField(
              controller: _endDateController,
              decoration: InputDecoration(
                hintText: "End Date",
              ),
            ),
            FlatButton(
              onPressed: () {
                //first we call our leave model and assign our form state to constructor
                Leave _leave = Leave(
                  //startdate is leave model property
                  startDate: _startDateController.text,
                  endDate: _endDateController.text,
                );

                //next
                //we call add to pending method to push our model into it
                _leaveProvider.addToPending(_leave);

                //print our pending leaves list size to make sure our provider is working
                print("Leave records ${_leaveProvider.pendingLeaves.length}");
              },
              child: Text(
                "Apply leave",
              ),
            ),
            Center(
              child: Text(
                _leaveProvider.totalLeaves.toString(),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
