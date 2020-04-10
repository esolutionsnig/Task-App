import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasks/models/task.dart';
import 'package:tasks/screens/task/all_task.dart';
import 'package:tasks/screens/task/task_tile.dart';
import 'package:tasks/shared/color.dart';
import 'package:tasks/shared/general.dart';

class AllTaskInfo extends StatefulWidget {
  @override
  _AllTaskInfoState createState() => _AllTaskInfoState();
}

class _AllTaskInfoState extends State<AllTaskInfo> {
  @override
  Widget build(BuildContext context) {
    final tasks = Provider.of<List<Task>>(context) ?? [];
    int tasksCount = tasks.length;

    return Column(
      children: <Widget>[
        headerText("Your Total Tasks", tasksCount),
        tasksCount != 0
            ? Container(
                height: 350,
                padding: EdgeInsets.all(15),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    return TaskTile(task: tasks[index]);
                  },
                ),
              )
            : Text(""),
        tasksCount != 0 ? FlatButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => AllTask(),
              ),
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "View All Tasks".toUpperCase(),
                style: TextStyle(color: cDarkPink3, fontSize: 16.0),
              ),
              SizedBox(width: 15,),
              Icon(Icons.arrow_forward, color: cDarkPink3,)
            ],
          ),
        ) : Text(""),
      ],
    );
  }
}
