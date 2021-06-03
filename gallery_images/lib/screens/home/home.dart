 // ignore: avoid_web_libraries_in_flutter

import 'package:gallery_images/model/User(brew).dart';
import 'package:flutter/material.dart';
import 'package:gallery_images/screens/NewCourse.dart';
import 'package:gallery_images/services/authser.dart';
import 'package:gallery_images/services/database.dart';
import 'package:provider/provider.dart';
import 'package:gallery_images/screens/home/UserList.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gallery_images/model/user.dart';
import 'package:gallery_images/chat.dart';


class home extends StatefulWidget {
  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {
  @override
  Widget build(BuildContext context) {
    final user=Provider.of<User>(context);
    final AuthService _auth=AuthService();

    List<dynamic> members=[];

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        // ignore: missing_return
        builder: (context, snapshot) {
          UserData userData=snapshot.data;
          if(snapshot.hasData){
            UserData u=snapshot.data;
            if(u.position=="Student"){

              return Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.brown[100],
                  elevation: 0.0,
                  title: Text('Home'),
                  actions: <Widget>[
                    FlatButton.icon(onPressed: ()async{
                      await _auth.signOut();
                    },
                      icon: Icon(Icons.person),
                      label: Text('Logout'),)
                  ],
                ) ,
                body: StreamBuilder(
                  stream: Firestore.instance.collection('Courses').snapshots(),
                  builder: (context,snapshot){
                    if(snapshot.hasData){

                      return ListView.builder(
                        itemCount:snapshot.data.documents.length,
                        itemBuilder: (context,index){
                          DocumentSnapshot course=snapshot.data.documents[index];
                          members=course['members'];
                          String cid=course['courseid'];


                          int k=0;
                          for(int i=0;i<members.length;i++){
                            if(members[i]==u.rollno){k=1;break;}
                          }

                          if(k==1){
                            return ListTile(
                              title: Text(course['coursename']),
                              subtitle: Text(course['courseid']),
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>chat(email:u.email,cid: cid)));
                              },
                            );
                          }
                          else{
                            return Container(width: 0.0,height: 0.0);

                          }



                        },
                      );

                    }
                    else{
                      return Container(width: 0.0,height: 0.0);
                    }

                  },



                ),
              );

            }
            else{

              return Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.brown[100],
                  elevation: 0.0,
                  title: Text('Home'),
                  actions: <Widget>[
                    FlatButton.icon(onPressed: ()async{
                      await _auth.signOut();
                    },
                      icon: Icon(Icons.person),
                      label: Text('Logout'),),
                    FlatButton.icon(onPressed: ()async{
                      Navigator.push(context, MaterialPageRoute(builder: (context) => newcourse()));
                    },
                      icon: Icon(Icons.plus_one),
                      label: Text('Create a Course'),)
                  ],
                ) ,
                body:
                StreamBuilder(
                  stream: Firestore.instance.collection('Courses').snapshots(),
                  builder: (context,snapshot){
                    //print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
                    //print(snapshot.hasData);
                    //print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
                    if(snapshot.hasData){

                      return SizedBox(height: 700,
                      child: ListView.builder(
                        itemCount:snapshot.data.documents.length,
                        itemBuilder: (context,index){
                          DocumentSnapshot course=snapshot.data.documents[index];
                          members=course['members'];
                         // print("++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=");
                          //print(snapshot.data.documents[index]);
                          //print("++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=");
                          String cid=course['courseid'];
                          if(u.email==members[0]){
                            return ListTile(
                              title: Text(course['coursename']),
                              subtitle: Text(course['courseid']),
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>chat(email:u.email,cid: cid)));
                              },
                            );

                          }
                          else {
                            return Container(width: 0.0,height: 0.0);
                          }

                        },
                      )
                      );

                    }
                    else{
                      return Container(width: 0.0,height: 0.0);
                    }

                  },



                ),
              );

            }

          }
          else{
            return Container(width: 0.0,height: 0.0);
          }

        }
    );
  }
  }



