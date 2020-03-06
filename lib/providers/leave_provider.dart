import 'package:flutter/material.dart';
import 'package:theta_edge/models/leave.dart';
import 'package:theta_edge/models/todo.dart';
import 'package:theta_edge/services/leave_service.dart';

/**
 * leave provider change notifier
 * this class is for state management for leaves summaries
 */
class LeaveProvider extends ChangeNotifier {
  //or rejected leaves lists
  List<Leave> _pendingLeaves = List<Leave>();
  List<Todo> _approvedLeaves = List<Todo>();

  LeaveProvider() {
    _fetchLeaves();
  }

  void refresh() {
    _fetchLeaves();
  }

  void _fetchLeaves() async {
    //clear all previous record inside our state
    _approvedLeaves.clear();
    notifyListeners();

    print("fetch leaves is called.");

    LeaveService().getLeaves().then((leave) {
      leave.forEach(
        (item) => _approvedLeaves.add(
          Todo.fromJson(item),
        ),
      );

      print(_approvedLeaves);
      notifyListeners();
    }).catchError((onError) {
      print("error is here.");

      notifyListeners();
    });
  }

  //add leave to our rejected leave
  void addToPending(Leave leave) {
    _pendingLeaves.add(leave);
    //notify our provider regarding to state changes
    notifyListeners();
  }

  //our getter for rejected list
  List<Leave> get pendingLeaves => _pendingLeaves;
  List<Todo> get approvedLeaves => _approvedLeaves;
  int get totalLeaves => _pendingLeaves.length;
}
