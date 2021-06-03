import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gallery_images/screens/home/UserList.dart';
import 'package:gallery_images/screens/home/home.dart';
import 'package:gallery_images/services/authser.dart';
import 'package:gallery_images/services/database.dart';

class newcourse extends StatefulWidget {
  @override
  _newcourseState createState() => _newcourseState();
}

class _newcourseState extends State<newcourse> {
  @override

  final AuthService _auth=AuthService();
  final _formKey=GlobalKey<FormState>();


  String email;

  void initState() {
    super.initState();
    _getUserName();
  }

  Future<void> _getUserName() async {
    Firestore.instance
        .collection('Users')
        .document((await FirebaseAuth.instance.currentUser()).uid)
        .get()
        .then((value) {
      setState(() {
        email = value.data['email'].toString();
      });
    });
  }

  String course_name="";
  String course_id="";
  String member_rollno="";
  List<String> members=[];
  String error="";

  var _controller = TextEditingController();


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: AppBar(
        title: Text('Create new Course '),
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
      ),
      body:Container(
        padding: EdgeInsets.symmetric(vertical: 50,horizontal: 50),
        child:Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField(
                decoration: InputDecoration(hintText: "Enter Course Name"),
                onChanged: (val){
                  setState(() {
                    course_name=val;
                  });
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: InputDecoration(hintText: "Enter Course Id"),
                onChanged: (val){
                  setState(() {
                    course_id=val;
                  });
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: _controller,
                onChanged: (val){
                  setState(() {
                    member_rollno=val;
                  });
                },
                decoration: InputDecoration(
                    hintText: "Enter Student Roll number",
                    suffixIcon: IconButton(icon: Icon(Icons.add),
                      onPressed: (){
                        members.add(email);
                        _controller.clear();
                        AuthService().Searchservice(member_rollno).then((QuerySnapshot docs){
                          print("&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&");
                          for (int i=0;i<=docs.documents.length;++i){
                            if(docs.documents[i].data!=null)
                            {
                              print(i);
                              print(docs.documents[i].data);
                              members.add(member_rollno);
                              error="";
                            }
                            else{
                              error="No such roll number exists!!!";
                            }
                          }
                          print("&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&");
                        });

                      },
                    )
                ),
              ),
              SizedBox(height: 20.0),
              Text(error,style: TextStyle(color: Colors.grey),),
              SizedBox(height: 20.0),
              RaisedButton(
                  color: Colors.pink[400],
                  child: Text('Create Course',style: TextStyle(color: Colors.white)),
                  onPressed: ()async{
                    members=members.toSet().toList();
                    DatabaseService().updateCourseData( course_name, course_id, members);
                    DatabaseService().updatemessages(course_id,email,"Welcome to new group!",1);
                    print("&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&");
                    print(email);
                    print(members);
                    print("&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&");
                    Navigator.pop(context, MaterialPageRoute(builder: (context) => home()));
                    //for(int i=0;i<members.length;i++){
                    //print("&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&");
                    //print(members[i]);
                    //print("&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&");
                    //}
                  }
              ),
            ],
          ),
        ),
      ),
    );
  }
  }



