import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test_cam_1/notification/notification1.dart';
import 'package:test_cam_1/test.dart';

class bodycamera extends StatefulWidget {
  const bodycamera({super.key});

  @override
  State<bodycamera> createState() => _bodycameraState();
}

class _bodycameraState extends State<bodycamera> {
  File? file;
  bool is_loading = false;
  ImagePicker image = ImagePicker();

  Future<String
  > isSkin(String imageUrl) async {
    var request = http.MultipartRequest('POST', Uri.parse('http://192.168.1.9:3000/user/updateImage'));
    request.files.add(await http.MultipartFile.fromPath('image', imageUrl));
    var response = await request.send();
    String responseString = await response.stream.bytesToString();
    print(responseString);
    Map<String, dynamic> jsonResponse = jsonDecode(responseString);
    print(jsonResponse);

    return jsonResponse['message'];
  }

  // Future<bool> isSkin(String imageUrl) async {
  //   var request = http.MultipartRequest('POST', Uri.parse('http://baleegh.nationaldm.com:3000/user/updateImage'));
  //   request.files.add(await http.MultipartFile.fromPath('image', imageUrl));
  //   var response = await request.send();
  //   String responseString = await response.stream.bytesToString();
  //   print(responseString);
  //   Map<String, dynamic> jsonResponse = jsonDecode(responseString);

  //   return jsonResponse['result'];
  // }

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
                
                children: <Widget>[
                  SizedBox(
                      height: 20,
                    ),
                  Stack(
                    children: 
                      [file == null ?
                      pictureadd(size: size)
                      :
                      Image.file(file!,fit:BoxFit.cover),
                       if (is_loading) Positioned.fill(child: Center(child: CircularProgressIndicator(),))

                    ],
                  ),
                  SizedBox(
                      height: 30,
                    ),
                  Text(file == null?' Set image':"chose other",
                  style: TextStyle(
                    fontWeight: FontWeight.bold
                  ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ElevatedButton.icon(
                          onPressed: (){
                            //getcam();

                            Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => cam_pordder(),));
                          },
                         icon: const Icon(Icons.enhance_photo_translate), 
                          label: const Text('Camera')),
    
                          const SizedBox(width: 10,),
    
                        ElevatedButton.icon(
                          onPressed: (){
                           getgall(); 
                           // NotificationServicesHelper.instance.dailyRoutine(title: 'hi',body: 'hello', vibrate: true, scheduledNotificationDateTime: DateTime(2023 , 6,24,00,25));





                          },
                         icon: const Icon(Icons.crop_original_outlined),
                          label: const Text('gallery')),
                        
                        
                      ],
                    ),
                  ),
                  ElevatedButton(onPressed: ()async{
                    if(file == null){return;}

                    setState(() {
                      is_loading = true;
                    });
                      String isSkinResult = await isSkin(file!.path);
                      setState(() {
                        is_loading = false;
                      });
                      // ignore: use_build_context_synchronously
                      showDialog(context: context,
                       builder: (BuildContext context)
                       {
                        return AlertDialog(
                          title: Text('Result'),
                          content: Text('it is  $isSkinResult skin'),
                          actions: [
                            TextButton(onPressed: ()
                            {Navigator.pop(context);},
                             child: Text('Ok'))
                          ],
                        );
                       }
                       );

                    }, 
                        child: Text('Check image')),
                        SizedBox(
                      height: 30,
                    ),

                ],
              ),
            )
          ]
        ),
        SizedBox(
                      height: 50,
                    ),
      ],
    );
  }

   getcam() async {
    var img = await image.getImage(source: ImageSource.camera);
    setState(() {
      if(img !=null){
      file = File(img.path);}
    });
  }



  getgall() async {
    // ignore: deprecated_member_use
    var img = await image.getImage(source: ImageSource.gallery);
    setState(() {
      if(img !=null){
      file = File(img.path);}
    });
  }
}



class pictureadd extends StatelessWidget {
  const pictureadd({
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
        alignment: Alignment.bottomCenter ,
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
            'lib/counter/addimage2.png',
            height: size.width*0.73,
            width: size.width*0.73,
            fit: BoxFit.cover,
          )
        ],
      ),
    );
  }
  
}



