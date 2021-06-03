import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gallery_images/services/database.dart';

class chat extends StatefulWidget {


  @override
  _chatState createState() => _chatState();
}

class _chatState extends State<chat> {

  String message="";
  var _controller = TextEditingController();

  final CollectionReference courses=Firestore.instance.collection('Courses');


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text('Create new Course '),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
        ),
        body: Center(
            child:SingleChildScrollView(
              child:Column(
                children: <Widget>[
                  Container(height: 700),
                  TextFormField(
                    controller: _controller,
                    onChanged: (val){
                      setState(() {
                        message=val;
                      });
                    },
                    decoration: InputDecoration(hintText: "Message",
                      suffixIcon: IconButton(icon: Icon(Icons.add),
                        onPressed: (){
                          _controller.clear();
                          //print("++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
                          //print(Firestore.instance.collection('Courses').snapshots());
                          //print("++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
                        },
                      ),
                    ),
                  )
                ],
              ),
            )
        )

    );
  }


}