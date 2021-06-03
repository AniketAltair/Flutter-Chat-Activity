import 'package:flutter/material.dart';
import 'package:gallery_images/services/authser.dart';

class student extends StatefulWidget {
  @override
  _studentState createState() => _studentState();
}

class _studentState extends State<student> {

  final AuthService _auth=AuthService();
  final _formKey=GlobalKey<FormState>();

  String course_name="";
  String course_id="";
  String member_rollno="";
  List<String> members=[];

  var _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: AppBar(
        title: Text('Courses registered '),
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(
            onPressed: ()async{
              await _auth.signOut();
            },
            icon: Icon(Icons.person),
            label: Text('Logout'),
          )
        ],
      ),
      body:Container(
        padding: EdgeInsets.symmetric(vertical: 50,horizontal: 50),
        child:Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField(
                decoration: InputDecoration(hintText: "bfkaafakaffjak"),
                onChanged: (val){
                  setState(()=>course_name=val);
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: InputDecoration(hintText: "Enter Course Id"),
                onChanged: (val){
                  setState(()=>course_id=val);
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: _controller,
                onChanged: (val){
                  setState(()=>member_rollno=val);
                },
                decoration: InputDecoration(
                    hintText: "Enter Student Roll number",
                    suffixIcon: IconButton(icon: Icon(Icons.add),
                      onPressed: (){
                        _controller.clear();
                        members.add(member_rollno);
                      },
                    )
                ),
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                  color: Colors.pink[400],
                  child: Text('Create Course',style: TextStyle(color: Colors.white)),
                  onPressed: ()async{
                    for (int i=0;i<members.length;i++){
                      print(members[i]);
                    }
                  }
              ),
              SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    );
  }
}
