import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasks/models/profile.dart';
import 'package:tasks/models/task.dart';
import 'package:tasks/screens/home/profile_form.dart';
import 'package:tasks/screens/task/all_task_info.dart';
import 'package:tasks/screens/task/completed_task_info.dart';
import 'package:tasks/screens/task/current_task_tile.dart';
import 'package:tasks/screens/task/task_form.dart';
import 'package:tasks/screens/task/upcoming_task_info.dart';
import 'package:tasks/services/auth.dart';
import 'package:tasks/services/database.dart';
import 'package:tasks/services/world_time.dart';
import 'package:tasks/shared/color.dart';
import 'package:tasks/shared/general.dart';
import 'package:tasks/screens/home/profile_info.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  final AuthService _auth = AuthService();

  String time;
  String date;
  bool fetching = true;

  setUpTimedFetch() {
    Timer.periodic(Duration(milliseconds: 50000), (timer) {
      setUpWorldTime();
    });
  }

  void setUpWorldTime() async {
    try {
      WorldTime worldTime = WorldTime(
        location: 'Lagos',
        flag: 'nigeria.png',
        url: 'Africa/Lagos',
      );
      await worldTime.getTime();
      setState(() {
        time = worldTime.time;
        date = worldTime.date;
        fetching = false;
      });
    } catch (e) {
      fetching = false;
      print(e);
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    setUpTimedFetch();
  }

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
                  fetching ? _dateTimeLoadder() : _dateTimeHolder(),
                ],
              ),
              SizedBox(
                height: 50.0,
              ),
              // Next Task
              headerTextNextTask("Your Current Task"),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15),
                child: StreamProvider<List<Task>>.value(
                  value: DatabaseService().currentTask,
                  child: CurrentTaskTile(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Divider(
                  color: Colors.pink.withAlpha(25),
                  height: 3,
                  thickness: 1,
                ),
              ),
              // Upcoming Tasks
              StreamProvider<List<Task>>.value(
                value: DatabaseService().upcomingTasks,
                child: UpcomingTaskInfo(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Divider(
                  color: Colors.pink.withAlpha(25),
                  height: 3,
                  thickness: 1,
                ),
              ),
              // Completed Tasks
              StreamProvider<List<Task>>.value(
                value: DatabaseService().completedTasks,
                child: CompletedTaskInfo(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Divider(
                  color: Colors.pink.withAlpha(25),
                  height: 3,
                  thickness: 1,
                ),
              ),
              // All Tasks
              StreamProvider<List<Task>>.value(
                value: DatabaseService().userTaskData,
                child: AllTaskInfo(),
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

  Positioned _dateTimeHolder() {
    return Positioned(
      bottom: -33,
      child: Container(
        height: 80.0,
        width: MediaQuery.of(context).size.width - 40,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(28)),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              spreadRadius: 5.5,
              blurRadius: 5.5,
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              child: Column(
                children: <Widget>[
                  Text(
                    date,
                    style: TextStyle(
                      color: cDarkPink1,
                      fontSize: 24,
                    ),
                  ),
                  Text("Today's Date".toUpperCase()),
                ],
              ),
            ),
            Row(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text(
                      time,
                      style: TextStyle(
                        color: cDarkPink3,
                        fontSize: 36.0,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Positioned _dateTimeLoadder() {
    return Positioned(
      bottom: -45,
      child: Container(
        height: 100.0,
        width: MediaQuery.of(context).size.width - 40,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(28)),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                spreadRadius: 5.5,
                blurRadius: 5.5,
              )
            ]),
        child: getDateTimeShimmer(),
      ),
    );
  }
}
