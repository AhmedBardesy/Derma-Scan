import 'package:flutter/material.dart';
import 'package:test_cam_1/bridge.dart';
import 'package:test_cam_1/chose_disease_card.dart';
import 'package:test_cam_1/diseases.dart';

class find_disease_body extends StatelessWidget {
  const find_disease_body({super.key, });
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 223, 217, 217),
        appBar: appbar(context),


        body:  ListView.builder(
          itemCount: diseases.length,
          itemBuilder: (context, index) => chose_disease_card(
            itemIndex: index,
            diseas: diseases[index],
            press: (){
              Navigator.push(
                context, MaterialPageRoute(builder: (context)=>bridge(diseas: diseases[index])));
            },
          ))
       
        // ListView.builder(
        //   itemCount: diseases.length,
        //   itemBuilder: (context,index)=>
        //   chose_disease(
        //   itemIndex: index,
        //    diseas:diseases[index] ,))
        //chose_disease(),
        ),
        
      );
     
  }


  AppBar appbar(BuildContext context) {
    return AppBar(
        backgroundColor: Colors.white,
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