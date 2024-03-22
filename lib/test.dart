// ignore_for_file: use_build_context_synchronously, prefer_const_constructors

import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mask_for_camera_view/mask_for_camera_view_border_type.dart';
import 'package:path_provider/path_provider.dart';
import 'package:mask_for_camera_view/mask_for_camera_view.dart';
import 'package:mask_for_camera_view/mask_for_camera_view_camera_description.dart';

import 'package:mask_for_camera_view/mask_for_camera_view_result.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class cam_pordder extends StatefulWidget {
  const cam_pordder({Key? key}) : super(key: key);
 
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

  @override
  _cam_pordderState createState() => _cam_pordderState();
}

class _cam_pordderState extends State<cam_pordder> {
    bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home:Scaffold(body: 
      isLoading
    ? Center(child: CircularProgressIndicator())
    : 
      HomePage(
          

        ), 
      appBar:  AppBar(
              backgroundColor: Colors.black,
               leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
            }, 
          // ignore: prefer_const_constructors
          icon: Icon(Icons.keyboard_backspace,
          color: Colors.white,
           ),
        ),
              centerTitle: false,
              title: Text('Back',style: TextStyle(color: Colors.black),)
               ), ),
    );
  }
}

class HomePage extends StatefulWidget {

  
  const HomePage({Key? key,}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;

  Future<String> isSkin(File imageFile) async {
 setState(() {
      isLoading = true;
    });
    //http://baleegh.nationaldm.com:3000/user/updateImage
    var request = http.MultipartRequest('POST', Uri.parse('http://192.168.1.9:3000/user/updateImage'));
    request.files.add(await http.MultipartFile.fromPath('image', imageFile.path));
    var response = await request.send();
    String responseString = await response.stream.bytesToString();
    print(responseString);
    Map<String, dynamic> jsonResponse = jsonDecode(responseString);
setState(() {
      isLoading = false;
    });

    return jsonResponse['message'];
  }

  @override
  Widget build(BuildContext context) {
    return MaskForCameraView(
      // insideLine: MaskForCameraViewInsideLine(
      //   position: MaskForCameraViewInsideLinePosition.center, // Change position to center
      //   direction: MaskForCameraViewInsideLineDirection.horizontal,
      // ),
      boxBorderWidth: 2.6,
      title:'' ,
        boxHeight: 200,
       boxWidth: 200,
         borderType: MaskForCameraViewBorderType.dotted,
       appBarColor: Colors.black,
       visiblePopButton: false, 
      cameraDescription: MaskForCameraViewCameraDescription.rear,

      onTake: (MaskForCameraViewResult res) async {
        setState(() {
    isLoading = true;
  });
        
        
        final directory = await getTemporaryDirectory();
        final timestamp = DateTime.now().millisecondsSinceEpoch;
        final imagePath = '${directory.path}/cropped_image_$timestamp.png';
        final File imageFile = File(imagePath);
        await imageFile.writeAsBytes(res.croppedImage!);
       
        String isSkinResult = await isSkin(imageFile);

        showModalBottomSheet(
          enableDrag: false,
           isScrollControlled: true,
           useRootNavigator: true,
           useSafeArea: true,
          context: context,
          
          backgroundColor: Colors.yellow,

          builder: (context) => Scaffold(
            backgroundColor: Colors.blue,

            appBar: AppBar(
              elevation: 0,
              backgroundColor: Color.fromARGB(255, 223, 217, 217),
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
              title: Text('Back',style: TextStyle(color: Colors.black),)
               ),

            body: 
            
           

              Column(
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
                    Center(
                      child: Text(
                        "yor image",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold
                      ),
                      ),
                      
                    ),
                  const SizedBox(
                      height: 50,
                    ),
                    
                    Center(child:Image.file(imageFile),
                     ),

                      Padding(padding: const EdgeInsets.symmetric(vertical: 20),
                      
                     child: Center(child: Text("it is $isSkinResult  ",style: const TextStyle(
                        fontWeight: FontWeight.bold
                      ),)),
                     ),
       
                     
                    const SizedBox(
                      height: 50,
                    )
                  ],
                ),
                
            )
          
          ]
               )
              
          ),
        );
      },
    );
  }
}
