import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gallery_images/services/authser.dart';

class Register extends StatefulWidget {

  final Function toggleView;
  Register({ this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth=AuthService();
  final _formKey=GlobalKey<FormState>();

  String email="";
  String password="";
  String rollno="";
  String error="";

  bool _switch=false;
  String text="Professor";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.brown[100],
        elevation: 0.0,
        title: Text('Sign Up'),
        actions: <Widget>[
          FlatButton.icon(onPressed: (){widget.toggleView();}, icon: Icon(Icons.person), label: Text('Sign In'))
        ],
      ),
      body: Center(
        child:SingleChildScrollView(
        child:Container(
        padding: EdgeInsets.symmetric(vertical: 50,horizontal: 50),
        child:Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField(
                validator:(val)=>val.isEmpty?"Enter Your Email-Id":null,
                decoration: InputDecoration(hintText: "Enter Your EmailId"),
                onChanged: (val){
                  setState(()=>email=val);
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                validator:(val)=>val.length<6?"Enter Password +6+ chars long":null,
                decoration: InputDecoration(hintText: "Enter Password"),
                obscureText: true,
                onChanged: (val){
                  setState(()=>password=val);
                },
              ),
              SizedBox(height: 20.0),
          TextFormField(
            decoration: InputDecoration(hintText: "Enter Your Roll number"),
            onChanged: (val){
              setState(()=>rollno=val);
            },
          ),
              SizedBox(height: 20.0),
              SwitchListTile(
                title: Text(text),
                secondary: Icon(Icons.swap_horizontal_circle),
                value: _switch,
                onChanged: (bool value){
                  setState(() {
                    _switch=value;
                    if(text=="Professor"){
                      text="Student";
                    }else{
                      text="Professor";
                    }
                  });
                },
              ),
              SizedBox(height: 20.0),
              Text(error,style: TextStyle(color: Colors.red),),
              RaisedButton(
                color: Colors.pink[400],
                child: Text('Register',style: TextStyle(color: Colors.white)),
                onPressed: (){
                      Firestore.instance.collection("Users").where('rollno',isEqualTo: rollno).getDocuments().then((QuerySnapshot docs){
                        if(docs.documents.length>0){
                          setState(() {
                            error="Enter Correct Roll Number!!!";
                          });
                        }else{
                          if(_formKey.currentState.validate()){
                            dynamic result= _auth.registerWithEmailAndPassword(email, password,text,rollno);
                            if(result==null){
                              setState(()=>error="Please supply valid email");
                            }}
                        }
                      });


                }
              ),

            ],
          ),
        ),
      ),
      )
      )
    );
  }
}
