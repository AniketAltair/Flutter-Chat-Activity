import 'package:flutter/material.dart';
import 'package:gallery_images/model/User(brew).dart';

class BrewTile extends StatelessWidget {

  final Brew brew;
  BrewTile({this.brew});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin:EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          title:Text(brew.email),
          subtitle: Text(brew.position+" "+brew.rollno),
        ),
      ),
    );
  }
}
