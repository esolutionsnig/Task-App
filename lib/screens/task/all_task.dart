import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasks/models/task.dart';
import 'package:tasks/screens/home/profile_form.dart';
import 'package:tasks/screens/task/all_task_info_vertical.dart';
import 'package:tasks/screens/task/task_form.dart';
import 'package:tasks/services/auth.dart';
import 'package:tasks/services/database.dart';
import 'package:tasks/shared/color.dart';

class AllTask extends StatefulWidget {
  @override
  _AllTaskState createState() => _AllTaskState();
}

class _AllTaskState extends State<AllTask> with TickerProviderStateMixin {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Task>>.value(
      value: DatabaseService().userTaskData,
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          elevation: 0.0,
          centerTitle: false,
          iconTheme: IconThemeData(
            color: cWhite, //change your color here
          ),
          title: Text(
            "All Tasks",
            style: TextStyle(
              fontSize: 22,
              color: cWhite,
            ),
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                stops: [0.0, 0.5, 1.0],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: <Color>[cDarkPink4, cDarkPink2, cDarkPink1],
              ),
            ),
          ),
          actions: <Widget>[
            // action button
            IconButton(
              icon: Icon(
                Icons.person_outline,
                color: cWhite,
                size: 30,
              ),
              onPressed: () {
                _showProfileForm(context);
              },
            ),
            // action button
            IconButton(
              icon: Icon(
                Icons.power_settings_new,
                color: cWhite,
                size: 30,
              ),
              onPressed: () async {
                await _auth.signOut();
              },
            ),
          ],
        ),
        body: AllTaskInfoVertical(),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(
          backgroundColor: cDarkPink3,
          child: Icon(Icons.add),
          onPressed: () {
            _showNewTaskForm(context);
          },
        ),
      ),
    );
  }

  // Bottom Sheet
  _showProfileForm(context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          height: 600.0,
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: ProfileForm(),
        );
      },
    );
  }

  // Bottom Sheet
  _showNewTaskForm(context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          height: 600.0,
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: TaskForm(),
        );
      },
    );
  }

  Widget headerTextNextTask(String title) {
    return Container(
      margin: EdgeInsets.only(top: 15.0, bottom: 20.0, left: 20, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

}
