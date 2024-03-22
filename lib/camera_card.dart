import 'package:flutter/material.dart';
import 'package:test_cam_1/bodycamera.dart';

class cameracard extends StatelessWidget {
  const cameracard({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blue,
        appBar: appbar(context),
        body: bodycamera(),
        ),
        
      );
     
  }


  AppBar appbar(BuildContext context) {
    return AppBar(
        backgroundColor: Color.fromARGB(255, 223, 217, 217),
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
            }, 
          // ignore: prefer_const_constructors
          icon: Icon(Icons.keyboard_backspace,
          color: Colors.black,
           ),
        ),
        centerTitle: false,
        title: const Text('Back',style: TextStyle(color: Colors.black),
        
        )
        );
  }
}