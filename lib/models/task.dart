import 'package:cloud_firestore/cloud_firestore.dart';

class Task {

  final String id;
  final String userId; 
  final String title;
  final String description;
  final Timestamp startDateTime;
  final Timestamp endDateTime;
  final String priority;
  final String status;

  Task({ this.id, this.userId, this.title, this.description, this.startDateTime, this.endDateTime, this.priority, this.status });
  
}