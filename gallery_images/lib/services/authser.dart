import 'package:firebase_auth/firebase_auth.dart';
import 'package:gallery_images/model/user.dart';
import 'package:gallery_images/screens/auth/auth.dart';
import 'package:gallery_images/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService{

  final FirebaseAuth _auth=FirebaseAuth.instance;


  User _userFromFirebaseUser(FirebaseUser user){
    return user!=null?User(uid: user.uid):null;
  }


  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }


  Future signInAnon() async{
    try{
      AuthResult result=await _auth.signInAnonymously();
      FirebaseUser user= result.user;
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }


  Future signInWithEmailAndPassword(String email,String password) async {
    try{
      AuthResult result=await _auth.signInWithEmailAndPassword(email: email, password: password);
      String s=result.user.uid;
      FirebaseUser user=result.user;
      return _userFromFirebaseUser(user);
    }catch(e){
      return null;
    }
  }


  Future registerWithEmailAndPassword(String email,String password,String position,String rollno) async {
    try{
      AuthResult result=await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user=result.user;
      await DatabaseService(uid:user.uid).updateUserData(email,password,position,rollno);
      return _userFromFirebaseUser(user);
    }catch(e){
      return null;
    }
  }


  Future signOut() async{
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  Future<QuerySnapshot>Searchservice(String rollno){

    return Firestore.instance.collection('Users').where('rollno', isEqualTo:rollno ).getDocuments();
  }


  Future<QuerySnapshot>updatetime(String rollno){

    return Firestore.instance.collection('Users').where('rollno', isEqualTo:rollno ).getDocuments();
  }

}

