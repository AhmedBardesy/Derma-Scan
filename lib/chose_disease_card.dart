// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:test_cam_1/diseases.dart';


class chose_disease_card extends StatelessWidget {
  const chose_disease_card({
    super.key, 
     required this.itemIndex,
      required this.diseas, required this.press, 
  });

   final int itemIndex;
   final Disease diseas;
   final Function()   press;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Container(
                  margin:  EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                   ),
                   //color: Colors.blueAccent,
                   height: 160,
                   child: InkWell(
                    onTap: press,
                    //     (){
                    //     Navigator.push(
                    //     context,
                    //     MaterialPageRoute( builder: (context) =>  bridge(), 
                    //     ),
                    //     );
    
                    // },
                     child: Stack(
                                   alignment: Alignment.bottomCenter,
                      children: <Widget>[
                        //those our card back ground
                        Container(
                           height: 138,
                           decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(22),
                            color: itemIndex.isEven? Color.fromARGB(255, 191, 59, 231) 
                            :Color.fromARGB(255, 93, 78, 158),
                            boxShadow: [
                              BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                             offset: const Offset(0, 3), // changes position of shadow
                             ),
                            ],
                           ),
                           child: Container(
                            margin: const EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(22),
                            
                             ),
                           ),
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 50),
                            
                            height: 110,
                            width: 200,
                            child:CircleAvatar(
                              radius: 70, // change the radius as per your requirement
                              backgroundColor: Colors.transparent,
                              child: ClipOval(
                                child: Image.asset(diseas.imge
                                  //'lib/counter/disease2.png'
                                  ,
                                fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          )
                        ),
                        Positioned(
                          left: 20,
                          bottom: 0,
                          child: SizedBox(
                          height: 130,
                          width: size.width - 180,
                          child: 
                           Column(children: <Widget> [
                            Padding(
                              padding: EdgeInsets.only(top: 30,left: 0,),
                              child:  
                              Text(//diseas.title,
                              diseas.title
                              
                              //'${products.details[0]
                              ),
                            )
                          ],),
                        ))
                      ]
                     ),
                   ),
                ),
    );
  }
}
