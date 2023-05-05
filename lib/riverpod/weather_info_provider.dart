import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/model/weather_info_item_model.dart';

final weatherInfoProvider = FutureProvider<WeatherInfo>(
  (ref) async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    final latitude = position.latitude.toString();
    final longitude = position.longitude.toString();
    final openWeatherMapUri =
        'http://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=1fc4bd3fb5b5bf0ba2bed28670567f49&units=metric';

    final openWeatherMapUriResponse =
        await http.get(Uri.parse(openWeatherMapUri));

    if (openWeatherMapUriResponse.statusCode == 200) {
      final weatherInfo =
          WeatherInfo.fromJson(jsonDecode(openWeatherMapUriResponse.body));
      return weatherInfo;
    } else {
      throw Exception('Failed to load weather data');
    }
  },
);
