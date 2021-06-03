import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gallery_images/model/user.dart';
import 'package:gallery_images/screens/auth/auth.dart';
import 'package:gallery_images/screens/home/home.dart';
import 'package:provider/provider.dart';
import 'package:gallery_images/screens/NewCourse.dart';
import 'package:gallery_images/screens/Student.dart';

class wrapper extends StatelessWidget{

  //final String data;
  //wrapper({this.data});

  @override
  Widget build(BuildContext context) {

    final user=Provider.of<User>(context);
    //print("#######################");
    //print(data);
    //print("#########################");



    if(user==null){
      return Auth();
    }else{


        return home();
      //return home();
    }


  }
}