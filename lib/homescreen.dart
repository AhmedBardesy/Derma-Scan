import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test_cam_1/constants.dart';

import 'homescreenbody.dart';


class homescreen extends StatelessWidget {
   Color kPrimaryColor = Color(0xFF035AA6);
  File? file;

  final ImagePicker image = ImagePicker();
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: appbarbuild(),
      body: Body(),
    );

}

  AppBar appbarbuild() {
    return AppBar(
      backgroundColor: kPrimaryColor,
      elevation: 0,
      title: Text('How can we help you'),
      centerTitle: false,
      
    );
  }

}