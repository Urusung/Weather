import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/riverpod/weather_and_address_provider.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<MainScreen> createState() => MainScreenState();
}

class MainScreenState extends ConsumerState<MainScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    requestLocationPermission();
  }

  @override
  Widget build(BuildContext context) {
    final weatherAndAdressInfo = ref.watch(weatherAndAddressProvider);

    //String weatherId = weatherAndAdressInfo.value?.item1.weatherId.toString() ?? '--';
    String weatherMain = weatherAndAdressInfo.value?.item1.weatherMain ?? '--';
    String weatherDescription =
        weatherAndAdressInfo.value?.item1.weatherDescription ?? '--';
    //String weatherIcon = weatherAndAdressInfo.value?.item1.weatherIcon ?? '--';
    String mainTemp = weatherAndAdressInfo.value?.item1.mainTemp ?? '--';
    String mainFeelsLike =
        weatherAndAdressInfo.value?.item1.mainFeelsLike ?? '--';
    String mainTempMin = weatherAndAdressInfo.value?.item1.mainTempMin ?? '--';
    String mainTempMax = weatherAndAdressInfo.value?.item1.mainTempMax ?? '--';
    String mainPressure =
        weatherAndAdressInfo.value?.item1.mainPressure ?? '--';
    String mainHumidity =
        weatherAndAdressInfo.value?.item1.mainHumidity ?? '--';
    String mainSeaLevel =
        weatherAndAdressInfo.value?.item1.mainSeaLevel ?? '--';
    String mainGrndLevel =
        weatherAndAdressInfo.value?.item1.mainGrndLevel ?? '--';
    String visibility = weatherAndAdressInfo.value?.item1.visibility ?? '--';
    String windSpeed = weatherAndAdressInfo.value?.item1.windSpeed ?? '--';
    String windDeg = weatherAndAdressInfo.value?.item1.windDeg ?? '--';
    String windGust = weatherAndAdressInfo.value?.item1.windGust ?? '--';
    String rain1h = weatherAndAdressInfo.value?.item1.rain1h ?? '--';
    String cloudsAll = weatherAndAdressInfo.value?.item1.cloudsAll ?? '--';
    //String dt = weatherAndAdressInfo.value?.item1.dt ?? '--';
    //String sysType = weatherAndAdressInfo.value?.item1.sysType ?? '--';
    //String sysId = weatherAndAdressInfo.value?.item1.sysId ?? '--';
    //String sysCountry = weatherAndAdressInfo.value?.item1.sysCountry ?? '--';
    String sysSunrise = weatherAndAdressInfo.value?.item1.sysSunrise ?? '--';
    String sysSunset = weatherAndAdressInfo.value?.item1.sysSunset ?? '--';
    //String timeZone = weatherAndAdressInfo.value?.item1.timeZone ?? '--';
    //String id = weatherAndAdressInfo.value?.item1.id ?? '--';
    String address = weatherAndAdressInfo.value?.item2 ?? '--';

    double weatherInfoContainerHeight = MediaQuery.of(context).size.height / 3;
    double otherInfoContainerWidth =
        (MediaQuery.of(context).size.width - 40) / 2;
    double otherInfoContainerHeight = MediaQuery.of(context).size.height / 5;

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            '',
            style: TextStyle(color: Colors.white),
          ),
          foregroundColor: Colors.black,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              onPressed: () async {
                ref.watch(weatherAndAddressProvider);
              },
              icon: Icon(
                Icons.refresh,
                color: Colors.white,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.lightBlue[900],
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SafeArea(
            child: Center(
              child: Column(
                children: [
                  Text(
                    address,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: weatherInfoContainerHeight * 0.12),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        mainTemp,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: weatherInfoContainerHeight * 0.4,
                            height: 1.0),
                      ),
                      SizedBox(
                        height: weatherInfoContainerHeight * 0.4,
                        child: Text(
                          '°',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: weatherInfoContainerHeight * 0.2,
                              height: 1.0),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    weatherMain,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: weatherInfoContainerHeight * 0.07),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '최고:$mainTempMax°',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: weatherInfoContainerHeight * 0.07),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 8.0),
                      ),
                      Text(
                        '최저:$mainTempMin°',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: weatherInfoContainerHeight * 0.07),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 62.0),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.all(16.0),
                        width: otherInfoContainerWidth,
                        height: otherInfoContainerHeight,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(
                            otherInfoContainerHeight / 10,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '강우',
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.5),
                                  fontSize: otherInfoContainerHeight * 0.08),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 8.0),
                            ),
                            Text(
                              '${rain1h}mm',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: otherInfoContainerHeight * 0.16),
                            ),
                            Text(
                              '지난 1시간',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: otherInfoContainerHeight * 0.12),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 8.0),
                      ),
                      Container(
                        padding: EdgeInsets.all(16.0),
                        width: otherInfoContainerWidth,
                        height: otherInfoContainerHeight,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(
                            otherInfoContainerHeight / 10,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '체감 온도',
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.5),
                                  fontSize: otherInfoContainerHeight * 0.08),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 8.0),
                            ),
                            Text(
                              '$mainFeelsLike°',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: otherInfoContainerHeight * 0.16),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.all(16.0),
                        width: otherInfoContainerWidth,
                        height: otherInfoContainerHeight,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(
                            otherInfoContainerHeight / 10,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '습도',
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.5),
                                  fontSize: otherInfoContainerHeight * 0.08),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 8.0),
                            ),
                            Text(
                              '${mainHumidity}%',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: otherInfoContainerHeight * 0.16),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 8.0),
                      ),
                      Container(
                        padding: EdgeInsets.all(16.0),
                        width: otherInfoContainerWidth,
                        height: otherInfoContainerHeight,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(
                            otherInfoContainerHeight / 10,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '기압',
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.5),
                                  fontSize: otherInfoContainerHeight * 0.08),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 8.0),
                            ),
                            Text(
                              '${mainPressure}hPa',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: otherInfoContainerHeight * 0.16),
                            ),
                            Spacer(),
                            Text(
                              '해수면 기압: ${mainSeaLevel}hPa',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: otherInfoContainerHeight * 0.08),
                            ),
                            Text(
                              '지면 기압: ${mainGrndLevel}hPa',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: otherInfoContainerHeight * 0.08),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.all(16.0),
                        width: otherInfoContainerWidth,
                        height: otherInfoContainerHeight,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(
                            otherInfoContainerHeight / 10,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '바람',
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.5),
                                  fontSize: otherInfoContainerHeight * 0.08),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 8.0),
                            ),
                            Text(
                              '풍속: ${windSpeed}m/s',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: otherInfoContainerHeight * 0.08),
                            ),
                            Text(
                              '풍향: $windDeg°',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: otherInfoContainerHeight * 0.08),
                            ),
                            Text(
                              '돌풍 속도: ${windGust}m/s',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: otherInfoContainerHeight * 0.08),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 8.0),
                      ),
                      Container(
                        padding: EdgeInsets.all(16.0),
                        width: otherInfoContainerWidth,
                        height: otherInfoContainerHeight,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(
                            otherInfoContainerHeight / 10,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '일출',
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.5),
                                  fontSize: otherInfoContainerHeight * 0.08),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 8.0),
                            ),
                            Text(
                              sysSunrise,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: otherInfoContainerHeight * 0.16),
                            ),
                            Spacer(),
                            Text(
                              '일몰: $sysSunset',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: otherInfoContainerHeight * 0.08),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.all(16.0),
                        width: otherInfoContainerWidth,
                        height: otherInfoContainerHeight,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(
                            otherInfoContainerHeight / 10,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '가시거리',
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.5),
                                  fontSize: otherInfoContainerHeight * 0.08),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 8.0),
                            ),
                            Text(
                              '${visibility}km',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: otherInfoContainerHeight * 0.16),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 8.0),
                      ),
                      Container(
                        padding: EdgeInsets.all(16.0),
                        width: otherInfoContainerWidth,
                        height: otherInfoContainerHeight,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(
                            otherInfoContainerHeight / 10,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '구름의 양',
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.5),
                                  fontSize: otherInfoContainerHeight * 0.08),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 8.0),
                            ),
                            Text(
                              '$cloudsAll%',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: otherInfoContainerHeight * 0.16),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 16.0),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> requestLocationPermission() async {
    await Permission.location.request();
    var permissionLocationStatus = await Permission.location.status;

    if (permissionLocationStatus.isGranted) {
      // 요청 동의됨
      if (await Permission.locationWhenInUse.serviceStatus.isEnabled) {
        // 요청 동의 + gps 켜짐
        print("serviceStatusIsEnabled position");
      } else {
        // 요청 동의 + gps 꺼짐
        print("serviceStatusIsDisabled");
      }
    } else {
      // 요청 거부됨
      print("requestLocationStatus.isDenied");
    }
  }
}
