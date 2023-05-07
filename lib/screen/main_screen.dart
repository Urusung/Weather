import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/model/weather_info_item_model.dart';
import 'package:weather_app/riverpod/weather_and_address_provider.dart';
import 'package:weather_app/widget/other_info_widget.dart';

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
                        fontSize: weatherInfoContainerHeight * 0.08),
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
                            fontSize: weatherInfoContainerHeight * 0.08),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 8.0),
                      ),
                      Text(
                        '최저:$mainTempMin°',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: weatherInfoContainerHeight * 0.08),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 62.0),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      OtherInfoWidget(
                        titleIcon: CupertinoIcons.drop_fill,
                        title: '강우',
                        value1: '${rain1h}mm',
                        value2: '지난 1시간',
                        value3: '',
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 8.0),
                      ),
                      OtherInfoWidget(
                        titleIcon: CupertinoIcons.thermometer,
                        title: '체감 온도',
                        value1: '$mainFeelsLike°',
                        value2: '',
                        value3: '',
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      OtherInfoWidget(
                        titleIcon: CupertinoIcons.drop_fill,
                        title: '습도',
                        value1: '$mainHumidity%',
                        value2: '',
                        value3: '',
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 8.0),
                      ),
                      OtherInfoWidget(
                        titleIcon: CupertinoIcons.cloud_fill,
                        title: '기압',
                        value1: '${mainPressure}hPa',
                        value2: '',
                        value3:
                            '지면 기압: ${mainGrndLevel}hPa\n해수면 기압: ${mainSeaLevel}hPa',
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      OtherInfoWidget(
                        titleIcon: CupertinoIcons.wind,
                        title: '바람',
                        value1: '',
                        value2: '',
                        value3:
                            '풍속: ${windSpeed}m/s\n풍향: $windDeg°\n돌풍 속도: ${windGust}m/s',
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 8.0),
                      ),
                      OtherInfoWidget(
                        titleIcon: CupertinoIcons.sunrise_fill,
                        title: '일출',
                        value1: sysSunrise,
                        value2: '',
                        value3: '일몰: $sysSunset',
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      OtherInfoWidget(
                        titleIcon: CupertinoIcons.eye_fill,
                        title: '가시거리',
                        value1: '${visibility}km',
                        value2: '',
                        value3: '',
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 8.0),
                      ),
                      OtherInfoWidget(
                        titleIcon: CupertinoIcons.cloud_fill,
                        title: '구름의 양',
                        value1: '$cloudsAll%',
                        value2: '',
                        value3: '',
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
