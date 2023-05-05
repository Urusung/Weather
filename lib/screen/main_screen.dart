import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<MainScreen> createState() => MainScreenState();
}

class MainScreenState extends ConsumerState<MainScreen> {
  @override
  Widget build(BuildContext context) {
    double containerWidth = MediaQuery.of(context).size.width - 32;
    double deviceInfoContainerHeight = MediaQuery.of(context).size.height / 6;
    double gasInfoContainerHeight = MediaQuery.of(context).size.height / 2.6;

    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.black,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          automaticallyImplyLeading: false,
        ),
        backgroundColor: Colors.grey[100],
        body: SafeArea(
          child: Column(
            children: [
              Container(
                width: containerWidth,
                height: deviceInfoContainerHeight,
                padding: EdgeInsets.all(24.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: Colors.white),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'deviceName',
                          style: TextStyle(
                              fontSize: deviceInfoContainerHeight / 7,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'deviceMac',
                          style: TextStyle(
                              fontSize: deviceInfoContainerHeight / 8,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey[400]),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 4.0),
                        ),
                      ],
                    ),
                    Icon(
                      Icons.sunny,
                      weight: deviceInfoContainerHeight * 0.4,
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 18.0),
              ),
              Container(
                width: containerWidth,
                height: gasInfoContainerHeight,
                padding: EdgeInsets.only(top: 20.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: Colors.white),
                child: Center(
                  child: SfRadialGauge(
                    axes: <RadialAxis>[
                      RadialAxis(
                        minimum: 0.0,
                        maximum: 50.0,
                        showTicks: false,
                        showLabels: false,
                        pointers: <GaugePointer>[
                          RangePointer(
                            enableAnimation: true,
                            animationDuration: 1200,
                            value: 27.4,
                            width: 22,
                            pointerOffset: -6,
                            cornerStyle: CornerStyle.bothCurve,
                            color: Colors.indigo,
                            gradient: SweepGradient(colors: <Color>[
                              Colors.indigo[100]!,
                              Colors.indigo
                            ], stops: <double>[
                              0.25,
                              0.75
                            ]),
                          ),
                        ],
                        annotations: <GaugeAnnotation>[
                          GaugeAnnotation(
                            angle: 90,
                            widget: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  '27.4',
                                  style: TextStyle(
                                      fontSize: deviceInfoContainerHeight / 2,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 4.0),
                                ),
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Temp',
                                        style: TextStyle(
                                            fontSize:
                                                deviceInfoContainerHeight / 6,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.grey[400]),
                                      ),
                                      TextSpan(
                                        text: '°C',
                                        style: TextStyle(
                                            fontSize:
                                                deviceInfoContainerHeight / 6,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.grey[400]),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 18.0),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 16.0),
                  child: LayoutBuilder(
                    builder:
                        (BuildContext context, BoxConstraints constraints) {
                      return Row(
                        children: [
                          Container(
                            width: (MediaQuery.of(context).size.width - 48) / 3,
                            padding: EdgeInsets.all(24.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(24),
                                color: Colors.white),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  CupertinoIcons.thermometer_sun,
                                  size: constraints.maxHeight / 3,
                                  color: Colors.indigo,
                                ),
                                Text(
                                  '24.0',
                                  style: TextStyle(
                                      fontSize:
                                          (constraints.maxHeight - 48) / 5,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.indigo),
                                ),
                                RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Temp',
                                        style: TextStyle(
                                            fontSize:
                                                (constraints.maxHeight - 48) /
                                                    10,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.grey[400]),
                                      ),
                                      TextSpan(
                                        text: '(°C)',
                                        style: TextStyle(
                                            fontSize:
                                                (constraints.maxHeight - 48) /
                                                    10,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.grey[400]),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 8.0),
                          ),
                          Container(
                            width: (MediaQuery.of(context).size.width - 48) / 3,
                            padding: EdgeInsets.all(24.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(24),
                                color: Colors.white),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.water_drop_outlined,
                                  size: constraints.maxHeight / 3,
                                  color: Colors.indigo,
                                ),
                                Text(
                                  '32',
                                  style: TextStyle(
                                      fontSize:
                                          (constraints.maxHeight - 48) / 5,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.indigo),
                                ),
                                RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Humidity',
                                        style: TextStyle(
                                            fontSize:
                                                (constraints.maxHeight - 48) /
                                                    10,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.grey[400]),
                                      ),
                                      TextSpan(
                                        text: '(%)',
                                        style: TextStyle(
                                            fontSize:
                                                (constraints.maxHeight - 48) /
                                                    10,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.grey[400]),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 8.0),
                          ),
                          Container(
                            width: (MediaQuery.of(context).size.width - 48) / 3,
                            padding: EdgeInsets.all(24.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(24),
                                color: Colors.white),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  CupertinoIcons.cloud,
                                  size: constraints.maxHeight / 3,
                                  color: Colors.indigo,
                                ),
                                Text(
                                  '1014',
                                  style: TextStyle(
                                      fontSize:
                                          (constraints.maxHeight - 48) / 5,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.indigo),
                                ),
                                RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Atm',
                                        style: TextStyle(
                                            fontSize:
                                                (constraints.maxHeight - 48) /
                                                    10,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.grey[400]),
                                      ),
                                      TextSpan(
                                        text: '(hpa)',
                                        style: TextStyle(
                                            fontSize:
                                                (constraints.maxHeight - 48) /
                                                    10,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.grey[400]),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 32.0),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      onWillPop: () async {
        return false;
      },
    );
  }
}
