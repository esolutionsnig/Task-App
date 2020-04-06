import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tasks/models/profile.dart';
import 'package:tasks/models/user.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  // Collection reference
  final CollectionReference profileCollection =
      Firestore.instance.collection('profiles');
  final CollectionReference taskCollection =
      Firestore.instance.collection('tasks');

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
    return profileCollection.document(uid).snapshots().map(_userDataFromSnapshot);
  }

}
