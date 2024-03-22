import 'package:flutter/material.dart';
import 'package:test_cam_1/find_disease_body.dart';
//import 'package:test_cam_1/find_disease_body.dart';


class Find_diease extends StatelessWidget {
  const Find_diease({super.key,// required this.press,
  });


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                 ),
                 //color: Colors.blueAccent,
                 height: 160,
                 child: InkWell(
                  onTap: (){
                      Navigator.push(
                      context,MaterialPageRoute( builder: (context) => const find_disease_body(), 
                      ),
                      );

                  },
                   child: Stack(
                                 alignment: Alignment.bottomCenter,
                    children: <Widget>[
                      //those our card back ground
                      Container(
                         height: 138,
                         decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(22),
                          color: Color.fromARGB(255, 110, 87, 211),
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
                          width: 220,
                          child: Image.asset('lib/counter/disease2.png',
                          fit: BoxFit.cover,
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
                         Column(children:const <Widget> [
                          Padding(
                            padding: EdgeInsets.only(top: 30,left: 0,),
                            child: Text('find Disease',
                            style: TextStyle(
                              //fontWeight: FontWeight.bold,
                              fontSize: 30
                            ),
                            ),
                          )
                        ],),
                      ))
                    ]
                   ),
                 ),
              );
  }
}
