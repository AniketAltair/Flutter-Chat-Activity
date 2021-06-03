import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:gallery_images/model/User(brew).dart';
import 'package:gallery_images/screens/home/brew_tile.dart';

class UserList extends StatefulWidget {

  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  @override
  Widget build(BuildContext context) {

    final Userlist=Provider.of<List<Brew>>(context);
    print("++++++++++++++++++++++++++++==");
    print(Userlist.length);
    print("++++++++++++++++++++++++++++==");

    //return ListView.builder(
      //itemCount: Userlist.length,
      //itemBuilder: (context,index){
        //return BrewTile(brew: Userlist[index]);
      //},
    //);
  }
}
