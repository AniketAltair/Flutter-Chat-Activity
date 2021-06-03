import 'package:flutter/material.dart';
import 'package:gallery_images/model/user.dart';
import 'package:gallery_images/screens/wrapper.dart';
import 'package:gallery_images/services/authser.dart';
import 'package:provider/provider.dart';

void main()=> runApp(Myapp());

class Myapp extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value:AuthService().user,
      child: MaterialApp(
        home: wrapper(),
      ),
    );

  }
}

