import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:theta_edge/providers/leave_provider.dart';
import 'package:theta_edge/providers/profile_provider.dart';
import 'package:theta_edge/screens/auth/login.dart';
import 'package:theta_edge/screens/dashboard.dart';
import 'package:theta_edge/screens/leave_create.dart';
import 'package:theta_edge/screens/leave_detail.dart';
import 'package:theta_edge/screens/leave_summaries.dart';
import 'package:theta_edge/screens/preferences.dart';
import 'package:theta_edge/screens/profiles/edit_profile.dart';

void main() => runApp(LeaveApp());

class LeaveApp extends StatelessWidget {
  const LeaveApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          // _ is represent for context
          create: (_) => LeaveProvider(),
        ),
        ChangeNotifierProvider(
          // _ is represent for context
          create: (_) => ProfileProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.blue,
        ),
        home: LoginScreen(),
        routes: {
          '/edit_profile': (context) => EditProfileScreen(),
          '/dashboard': (context) => NavigationContainer(),
          '/login': (context) => LoginScreen(),
          '/leave_detail': (context) => LeaveDetailScreen(),
          '/leave_create': (context) => LeaveCreateScreen(),
        },
      ),
    );
  }
}

class NavigationContainer extends StatefulWidget {
  NavigationContainer({Key key}) : super(key: key);

  @override
  _NavigationContainerState createState() => _NavigationContainerState();
}

class _NavigationContainerState extends State<NavigationContainer> {
  //give current index for our app screen
  int currentIndex = 0;

  List<Widget> _screens = [
    DashboardScreen(),
    LeaveSummariesScreen(),
    PreferencesScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(),
      //resolve our body to selected screen index
      body: _screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          //print("current index ${index}");
          setState(() {
            currentIndex = index;
          });
        },
        currentIndex: currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text("Home"),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.calendar_today,
            ),
            title: Text("Leaves"),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_circle,
            ),
            title: Text("Account"),
          ),
        ],
      ),
    );
  }
}
