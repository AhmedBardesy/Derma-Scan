import 'package:flutter/material.dart';
import 'package:test_cam_1/camera_card.dart';


class bodycard extends StatelessWidget {
  const bodycard({super.key,
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
                      context,MaterialPageRoute( builder: (context) => const cameracard(), 
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
                          color: Colors.blue,
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
                          height: 160,
                          width: 180,
                          child: Image.asset('lib/counter/chick2image.png',
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
                            padding: EdgeInsets.only(top: 30,left: 0),
                            child: Text('Diagnose',
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
