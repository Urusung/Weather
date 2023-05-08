import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:page_transition/page_transition.dart';
import 'package:weather_app/screen/main_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(milliseconds: 1500), () {
      Future.delayed(Duration(milliseconds: 500));
      requestLocationPermission();
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Image.asset(
                'assets/images/weather_app.png',
                width: screenWidth * 0.4,
                height: screenHeight * 0.4,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void requestLocationPermission() async {
    var requestLocationStatus = await Permission.location.request();
    var locationStatus = await Permission.location.status;

    if (requestLocationStatus.isGranted) {
      // 요청 동의됨
      if (await Permission.locationWhenInUse.serviceStatus.isEnabled) {
        // 요청 동의 + gps 켜짐
        print("serviceStatusIsEnabled position");
        Navigator.pushReplacement(
          context,
          PageTransition(
            type: PageTransitionType.fade,
            child: MainScreen(),
          ),
        );
      } else {
        // 요청 동의 + gps 꺼짐
        print("serviceStatusIsDisabled");
      }
    } else if (requestLocationStatus.isPermanentlyDenied ||
        locationStatus.isPermanentlyDenied) {
      // 권한 요청 거부 (android)
      openAppSettings();
    } else if (locationStatus.isRestricted) {
      // 권한 요청 거부 (ios)
      openAppSettings();
    } else if (locationStatus.isDenied) {
      // 권한 요청 거절
    }
  }

  void permissionWarningDialog(Text title, Text content) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: title,
        content: content,
        actions: <Widget>[
          TextButton(
            child: Text('확인'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}
