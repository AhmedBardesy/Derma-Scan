import 'package:flutter/material.dart';
import 'package:mask_for_camera_view/mask_for_camera_view.dart';
import 'package:provider/provider.dart';
import 'package:test_cam_1/homescreen.dart';
import 'package:test_cam_1/introductionscreen.dart';
import 'package:test_cam_1/local.dart';
import 'package:test_cam_1/notification/notification1.dart';
import 'package:test_cam_1/reminder/global_bloc.dart';
import 'package:timezone/data/latest.dart' as tz;

Future<void> main() async { 
  WidgetsFlutterBinding.ensureInitialized();
  
  await MaskForCameraView.initialize();
  await CashHelper.init();

await NotificationServicesHelper.instance.initNotification();
  tz.initializeTimeZones();
  Widget? screen;
  var navigat_screen = CashHelper.getData(key: "onBorading");

  if (navigat_screen == true) {
    screen = homescreen();
  } else {
    screen = OnBoardingPage();
  }

  runApp(MyApp(screen: screen));
}

class MyApp extends StatelessWidget {
  final Widget screen;

  const MyApp({Key? key, required this.screen}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider<GlobalBloc>.value(
      value: GlobalBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: screen,
      ),
    );
  }
}
