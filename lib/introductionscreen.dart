import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:test_cam_1/const.dart';
import 'package:test_cam_1/homescreen.dart';
import 'package:test_cam_1/local.dart';

class OnBoardingPage extends StatefulWidget {
  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  @override
  savepref() {
    setState(() {
      CashHelper.saveData(key: "onBorading", value: true).then((value) {
        if (value) {
          print(isOnBorad);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => homescreen(),
            ),
          );
        }
      });
    });
  }

  // getpref()async{
  Widget build(BuildContext context) => SafeArea(
        child: IntroductionScreen(
          pages: [
            PageViewModel(
              title: 'Taking an image',
              body:
                  'To help you identify the disease you want to diagnose on the camera screen, please position the lesion area within the square,to provide you with a more accurate identification.',
              image: buildImage('lib/counter/phone33.jpg'),
              decoration: getPageDecoration(),
            ),
            PageViewModel(
              title: 'Knowledge',
              body:
                  'now you can know better about your diagnosis in our new section disease',
              image: buildImage('lib/counter/idea.png'),
              decoration: getPageDecoration(),
            ),
            PageViewModel(
              title: 'Are you worry',
              body:
                  'Please note that the images displayed in the "Find Disease" section are for general reference purposes only, and they may or may not apply to your specific case.',
              image: buildImage('lib/counter/woory.png'),
              decoration: getPageDecoration(),
            ),
            PageViewModel(
              title: "Finally, don't forget",
              body:
                  "Your health is important to us, and we genuinely care about your well-being. Rest assured that you are in good hands",
              image: buildImage('lib/counter/hra.png'),
              decoration: getPageDecoration(),
            ),
          ],

          done: const Text('Done',
              style:
                  TextStyle(fontWeight: FontWeight.w600, color: Colors.black)),
          onDone: () => savepref(),

          showSkipButton: true,
          skip: Text(
            'Skip',
            style: TextStyle(color: Colors.black.withOpacity(0.8)),
          ),

          onSkip: () => savepref(),
          next: const Icon(
            Icons.arrow_forward,
            color: Colors.black,
          ),
          dotsDecorator: getDotDecoration(),
          onChange: (index) => print('Page $index selected'),
          globalBackgroundColor: Theme.of(context).primaryColor,

          nextFlex: 0,
          // isProgressTap: false,
          // isProgress: false,
          // showNextButton: false,
          // freeze: true,
          // animationDuration: 1000,
        ),
      );

  // void goToHome(context) => Navigator.of(context).pushReplacement(
  Widget buildImage(String path) =>
      Center(child: Image.asset(path, width: 350));

  DotsDecorator getDotDecoration() => DotsDecorator(
        color: const Color.fromARGB(255, 24, 21, 21),
        activeColor: Colors.black,
        size: const Size(10, 10),
        activeSize: const Size(22, 10),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      );

  PageDecoration getPageDecoration() => const PageDecoration(
        titleTextStyle: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        bodyTextStyle: TextStyle(fontSize: 20),
        // descriptionPadding: EdgeInsets.all(16).copyWith(bottom: 0),
        imagePadding: EdgeInsets.all(24),
        pageColor: Colors.white,
      );
}
