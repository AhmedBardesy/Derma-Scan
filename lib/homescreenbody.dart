import 'package:flutter/material.dart';
import 'package:test_cam_1/body_card_diagnose.dart';
import 'package:test_cam_1/find_diaease.dart';

import 'reminder/reminder_card.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: 
          <Widget>[
            const SizedBox(height: 30),
            Expanded(
              child: Stack(
                children: <Widget>[
                  //back ground
                  Container(
                    margin: const EdgeInsets.only(top: 70),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(40),
                        topLeft: Radius.circular(40),
                      )
                     ),
                  ),
                  ListView.builder(
                    itemCount: 1,
                    itemBuilder: (context,index)=>Column(
                   children: [
                    bodycard(),
                    Find_diease(),
                    reminder_card(),
                      ],
                  ))
                  ]
              )
              )
          ],
        
      ),
    );
  }

}
