import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gallery_images/services/database.dart';

class chat extends StatelessWidget {

  String cid;
  String email;
  chat({this.cid,this.email});



  String message="";
  var _controller = TextEditingController();

  final CollectionReference courses=Firestore.instance.collection('Courses');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text('Chats'),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
        ),
        body: Center(
            child:SingleChildScrollView(
              child:Column(
                children: <Widget>[
                  StreamBuilder(
                    stream: Firestore.instance.collection(cid).orderBy('time').snapshots(),
                    builder: (context,snapshot){
                      if(snapshot.hasData){

                        return SizedBox(height: 700,
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount:snapshot.data.documents.length,
                            itemBuilder: (context,index){
                              int l=snapshot.data.documents.length;
                              DocumentSnapshot mess=snapshot.data.documents[l-index-1];
                              print("{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{[");
                              String s=mess.documentID;
                              String time=mess["time"].toString();
                              int t=mess['time'];
                              print(s);
                              print(time);
                              print("{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{[");
                              return ListTile(
                                title: Text(mess['message']),
                                subtitle: Text(mess['email'].toString()),
                              );
                            }
                        )
                        );

                      }
                      else{

                        return Container(
                          child: Text('No messages'),
                        );

                      }
                    },
                  ),
                  TextFormField(
                    controller: _controller,
                    onChanged: (val){
                      message=val;
                    },
                    decoration: InputDecoration(hintText: "Message",
                      suffixIcon: IconButton(icon: Icon(Icons.add),
                        onPressed: (){
                          _controller.clear();
                          //write here time updating code
                          Firestore.instance.collection(cid).where('time',isGreaterThan:0).getDocuments().then((QuerySnapshot docs){
                            for (int i=0;i<=docs.documents.length;++i){
                              int time=docs.documents[i].data['time'];
                              time=time+1;
                              Firestore.instance.collection(cid).document(docs.documents[i].documentID).updateData({'time':time});
                            }
                            //print("TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT");
                            //print(docs.documents[0].documentID);
                            //print("TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT");
                          });
                          DatabaseService().updatemessages(cid, email,message,1);
                          //print("++++++++++++++++++++++++++++++++++++++++++++****************************************");
                          //print(message);
                          //print("++++++++++++++++++++++++++++++++++++++++++++******************************************");
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











