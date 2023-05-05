import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/riverpod/address_info_provider.dart';
import 'package:weather_app/riverpod/weather_and_address_provider.dart';
import 'package:weather_app/riverpod/weather_info_provider.dart';

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
    //final weatherInfo = ref.watch(weatherInfoProvider);
    //final addressInfo = ref.watch(addressInfoProvider);

    // String weatherId = weatherInfo.value?.weatherId.toString() ?? '--';
    // String weatherMain = weatherInfo.value?.weatherMain ?? '--';
    // String weatherDescription = weatherInfo.value?.weatherDescription ?? '--';
    // String weatherIcon = weatherInfo.value?.weatherIcon ?? '--';
    String mainTemp =
        weatherAndAdressInfo.value?.item1.mainTemp.toString() ?? '--';
    // String mainFeelsLike = weatherInfo.value?.mainFeelsLike.toString() ?? '--';
    // String mainTempMin = weatherInfo.value?.mainTempMin.toString() ?? '--';
    // String mainTempMax = weatherInfo.value?.mainTempMax.toString() ?? '--';
    // String mainPressure = weatherInfo.value?.mainPressure.toString() ?? '--';
    // String mainHumidity = weatherInfo.value?.mainHumidity.toString() ?? '--';
    // String mainSeaLevel = weatherInfo.value?.mainSeaLevel.toString() ?? '--';
    // String mainGrndLevel = weatherInfo.value?.mainGrndLevel.toString() ?? '--';
    // String visibility = weatherInfo.value?.visibility.toString() ?? '--';
    // String windSpeed = weatherInfo.value?.windSpeed.toString() ?? '--';
    // String windDeg = weatherInfo.value?.windDeg.toString() ?? '--';
    // String windGust = weatherInfo.value?.windGust.toString() ?? '--';
    // String rain1h = weatherInfo.value?.rain1h.toString() ?? '--';
    // String cloudsAll = weatherInfo.value?.cloudsAll.toString() ?? '--';
    // String dt = weatherInfo.value?.dt.toString() ?? '--';
    // String sysType = weatherInfo.value?.sysType.toString() ?? '--';
    // String sysId = weatherInfo.value?.sysId.toString() ?? '--';
    // String sysCountry = weatherInfo.value?.sysCountry.toString() ?? '--';
    // String sysSunrise = weatherInfo.value?.sysSunrise.toString() ?? '--';
    // String sysSunset = weatherInfo.value?.sysSunset.toString() ?? '--';
    // String timeZone = weatherInfo.value?.timeZone.toString() ?? '--';
    // String id = weatherInfo.value?.id.toString() ?? '--';
    String address = weatherAndAdressInfo.value?.item2 ?? '--';

    double containerWidth = MediaQuery.of(context).size.width - 32;
    double weatherInfoContainerHeight =
        MediaQuery.of(context).size.height * 0.6;

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.black,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          automaticallyImplyLeading: false,
        ),
        backgroundColor: Colors.grey[100],
        body: SafeArea(
          child: Center(
            child: Column(
              children: [
                Container(
                  width: containerWidth,
                  height: weatherInfoContainerHeight,
                  padding: EdgeInsets.all(24.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      color: Colors.white),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(address),
                          Text('Today PM 00:00'),
                        ],
                      ),
                      Text(
                        mainTemp,
                        style: TextStyle(
                            fontSize: weatherInfoContainerHeight * 0.2),
                      ),
                      Text('비'),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('720hpa'),
                          Text('32%'),
                          Text('12km/h'),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
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
