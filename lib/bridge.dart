import 'package:flutter/material.dart';

import 'package:test_cam_1/disease_discription.dart';
import 'package:test_cam_1/diseases.dart';

class bridge extends StatelessWidget {
   final Disease diseas;


  const bridge
  ({super.key,
   required this.diseas,
   });
  

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
        backgroundColor: Colors.blue,

      appBar: appbar(context),
       body: disease_discription(diseas: diseas) ,
    ));
  }
}


  AppBar appbar(BuildContext context) {
    return AppBar(
        backgroundColor: const Color.fromARGB(255, 223, 217, 217),
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
