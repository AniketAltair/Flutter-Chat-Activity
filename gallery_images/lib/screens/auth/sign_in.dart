import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gallery_images/model/User(brew).dart';
import 'package:gallery_images/screens/NewCourse.dart';
import 'package:gallery_images/services/authser.dart';
import 'package:gallery_images/screens/home/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gallery_images/services/database.dart';
import 'package:gallery_images/shared/loading.dart';
import 'package:provider/provider.dart';
import 'package:gallery_images/screens/Student.dart';
import 'package:gallery_images/screens/wrapper.dart';
import 'package:gallery_images/model/user.dart';


class SignIn extends StatefulWidget {

  final Function toggleView;
  final Brew b;
  SignIn({ this.toggleView,this.b});


  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {


  final AuthService _auth=AuthService();
  final _formKey=GlobalKey<FormState>();
  bool loading=false;

  String email="";
  String password="";
  String error="";

  @override
  Widget build(BuildContext context) {


    return loading?Loading():Scaffold(
            backgroundColor: Colors.grey[50],
            appBar: AppBar(
              backgroundColor: Colors.brown[100],
              elevation: 0.0,
              title: Text('Sign In'),
              actions: <Widget>[
                FlatButton.icon(onPressed: (){widget.toggleView();}, icon: Icon(Icons.person), label: Text('Register'))
              ],
            ),
            body: Container(
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
                    RaisedButton(
                      color: Colors.pink[400],
                      child: Text('Sign In',style: TextStyle(color: Colors.white)),
                      onPressed: ()async{
                        if(_formKey.currentState.validate()){
                          setState(()=>loading=true);
                          dynamic result=await _auth.signInWithEmailAndPassword(email, password);
                          if (result==null){
                            setState((){
                              error="Username or Password not correct!!!";
                              loading=false;
                            });
                          }else{

                            //String s=result.uid;
                            //String pos="";
                            //Firestore.instance.collection('Users').document(s).get().then((value) {value.data.map((vl){});print(value.data);});
                            //print(pos+"234242342");
                            //Navigator.push(context, MaterialPageRoute(builder: (context) => wrapper(data:pos)));
                          }
                        }
                      },
                    ),
                    SizedBox(height: 20.0),
                    Text(error,style: TextStyle(color: Colors.black)),

                  ],
                ),
              ),
            ),
          );

      }
  }

