import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gallery_images/model/User(brew).dart';
import 'package:gallery_images/model/user.dart';

class DatabaseService{

  final String uid;
  final String courseuid;
  DatabaseService({this.uid,this.courseuid});


  final CollectionReference coll=Firestore.instance.collection('Users');
  final CollectionReference courses=Firestore.instance.collection('Courses');


  Future updateUserData(String email,String password,String position,String rollno) async{
    return await coll.document(uid).setData({
      'email':email,
      'password':password,
      'position':position,
      'rollno':rollno,
    });
  }

  Future updateCourseData(String coursename,String courseid,List<String> members) async{
    return await courses.document(uid).setData({
      'coursename':coursename,
      'courseid':courseid,
      'members':members,

    });
  }

  Future updatemessages(String id,String email,String message,int n) async {
    final CollectionReference pa=Firestore.instance.collection(id);
    return await pa.document(uid).setData({
      'email':email,
      'message':message,
      'time':n,
    });
  }


  Future updateprofData(String coursename,String courseid) async{
    return await coll.document(uid).setData({
      'coursename':coursename,
      'courseid':courseid,
    });
  }



  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return Brew(
        email:doc.data['email'] ?? "",
        password:doc.data['password'] ?? "",
        position:doc.data['position'] ?? "",
        rollno:doc.data['rollno'] ?? "",

      );
    }).toList();
  }

  Stream<List<Brew>> get UserInfo{
    return coll.snapshots().map(_brewListFromSnapshot);
  }

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot){
    return UserData(
      uid: uid,
      position: snapshot.data['position'] ?? "noPos",
      email:snapshot.data['email']?? "noemail",
      rollno:snapshot.data['rollno']?? "noroll",
    );
  }

  Stream<UserData> get userData {
    return coll.document(uid).snapshots().map(_userDataFromSnapshot);
  }

}