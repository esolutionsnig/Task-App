import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tasks/models/profile.dart';
import 'package:tasks/models/task.dart';
import 'package:tasks/models/user.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  // Collection reference
  final CollectionReference profileCollection = Firestore.instance.collection('profiles');
  final CollectionReference taskCollection = Firestore.instance.collection('tasks');

  // Add new task
  Future addUserTask(
      String userId,
      String title,
      String description,
      DateTime startDateTime,
      DateTime endDateTime,
      String priority,
      String status) async {
    var data = ({
      'userId': userId,
      'title': title,
      'description': description,
      'startDateTime': startDateTime,
      'endDateTime': endDateTime,
      'priority': priority,
      'status': status,
    });
    return await taskCollection.document().setData(data);
  }

  // Task List
  List<Task> _tasksFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Task(
        id: doc.documentID,
        userId: doc.data['userId'] ?? '',
        title: doc.data['title'] ?? '',
        description: doc.data['description'] ?? '',
        startDateTime: doc.data['startDateTime'] ?? '',
        endDateTime: doc.data['endDateTime'] ?? '',
        priority: doc.data['priority'] ?? '',
        status: doc.data['status'] ?? '',
      );
    }).toList();
  }

  // Get task doc stream
  Stream<List<Task>> get userTaskData {
    return taskCollection.snapshots().map(_tasksFromSnapshot);
  }

  // Get User Task Stream
  Stream<List<Task>> get tasks {
    return taskCollection.orderBy('startDateTime').snapshots().map(_tasksFromSnapshot);
  }

  // Get User Current Task Stream
  Stream<List<Task>> get currentTask {
    return taskCollection.where('status', isEqualTo: 'Not Started').where('status', isEqualTo: 'Started').limit(1).snapshots().map(_tasksFromSnapshot);
  }

  // Get User Upcoming Task Stream
  Stream<List<Task>> get upcomingTasks {
    return taskCollection.orderBy('startDateTime').where('status', isEqualTo: 'Not Started').snapshots().map(_tasksFromSnapshot);
  }

  // Get User Completed Task Stream
  Stream<List<Task>> get completedTasks {
    return taskCollection.orderBy('startDateTime').where('status', isEqualTo: 'Completed').snapshots().map(_tasksFromSnapshot);
  }

  // Mark task as started
  Future markTaskStarted(String taskId, String status) async {
    return await taskCollection.document(taskId).updateData({'status': status});
  }

  // Mark task as completed
  Future markTaskCompleted(String taskId, String status) async {
    return await taskCollection.document(taskId).updateData({'status': status});
  }

  // Delete task
  Future deleteTask(String taskId) async {
    return await taskCollection.document(taskId).delete();
  }

  // Update user profile
  Future updateUserData(String surname, String firstname, int gender, String avatar) async {
    return await profileCollection.document(uid).setData({
      'surname': surname,
      'firstname': firstname,
      'gender': gender,
      'avatar': avatar,
    });
  }

  // Profile List
  List<Profile> _profileFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Profile(
        surname: doc.data['surname'] ?? '',
        firstname: doc.data['firstname'] ?? '',
        gender: doc.data['gender'] ?? '',
        avatar: doc.data['avatar'] ?? '',
      );
    }).toList();
  }

  // userData from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      surname: snapshot.data['surname'],
      firstname: snapshot.data['firstname'],
      gender: snapshot.data['gender'],
      avatar: snapshot.data['avatar'],
    );
  }

  // Get User Profile Stream
  Stream<List<Profile>> get profiles {
    return profileCollection.snapshots().map(_profileFromSnapshot);
  }

  // Get user doc stream'
  Stream<UserData> get userData {
    return profileCollection
        .document(uid)
        .snapshots()
        .map(_userDataFromSnapshot);
  }
}
