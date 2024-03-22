import 'package:flutter/material.dart';
import 'package:test_cam_1/diseases.dart';


class disease_discription extends StatelessWidget {
   final Disease diseas;

  const disease_discription
  ({super.key, 
   required this.diseas,

   });
 @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ListView(
         children: 
               [Column(
          children: <Widget>[
            Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 20),
               // height: 400,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 223, 217, 217),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                  )
                ),
                
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
       
                    Center(child:

                     disease_picture(size: size,diseas: diseas,)

                     ),
                      Padding(padding: const EdgeInsets.symmetric(vertical: 20),
                     child: Text(diseas.title),
                     ),
       
                     Text(
                      diseas.description,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold
                    ),
                    ),
                    const SizedBox(
                      height: 50,
                    )
                  ],
                ),
                
            )
          
          ]
               ),
             const SizedBox(
                      height: 50,
                    )],
       );
       }
}
class disease_picture extends StatelessWidget {
     final Disease diseas;

  const disease_picture( {required this.diseas,
    super.key,
    required this.size, 
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      height: size.width*0.8,
      //color: Colors.black,
      child: Stack(
        alignment: Alignment.center ,
        children: <Widget>[
          Container(
            height: size.width*0.7,
            width: size.width*0.7,
            // ignore: prefer_const_constructors
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
          Image.asset(
            diseas.imge
            ,
            height: size.width*0.73,
            width: size.width*0.73,
            fit: BoxFit.cover,
          )
        ],
      ),
    );
  }
}


