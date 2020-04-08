import 'package:flutter/material.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:provider/provider.dart';
import 'package:tasks/models/profile.dart';
import 'package:tasks/models/task.dart';
import 'package:tasks/screens/home/profile_form.dart';
import 'package:tasks/screens/task/task_form.dart';
import 'package:tasks/screens/task/task_info.dart';
import 'package:tasks/screens/task/task_tile.dart';
import 'package:tasks/services/auth.dart';
import 'package:tasks/services/database.dart';
import 'package:tasks/shared/color.dart';
import 'package:tasks/shared/general.dart';
import 'package:tasks/screens/home/profile_info.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Profile>>.value(
      value: DatabaseService().profiles,
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          elevation: 0.0,
          centerTitle: false,
          title: homeTitle(),
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
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Stack(
                alignment: AlignmentDirectional.topCenter,
                overflow: Overflow.visible,
                children: <Widget>[
                  _backBgCover(),
                  _header(),
                  StreamProvider<List<Task>>.value(
                    value: DatabaseService().userTaskData,
                    child: CurrentTaskTile(),
                  ),
                ],
              ),
              SizedBox(
                height: 50.0,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15),
                child: StreamProvider<List<Task>>.value(
                    value: DatabaseService().userTaskData,
                    child: NextTaskTile(),
                  ),
              ),
              Container(
                height: 400,
                padding: EdgeInsets.all(15),
                child: StreamProvider<List<Task>>.value(
                  value: DatabaseService().userTaskData,
                  child: TaskInfo(),
                ),
              ),
              SizedBox(
                height: 50.0,
              ),
              
              Container(
                height: 20,
              ),
            ],
          ),
        ),
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

  Container _backBgCover() {
    return Container(
      height: 155.0,
      decoration: BoxDecoration(
        gradient: pinkGradient,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
      ),
    );
  }

  Positioned _header() {
    return Positioned(
      left: 20,
      bottom: 85,
      child: ProfileInfo(),
    );
  }

}
