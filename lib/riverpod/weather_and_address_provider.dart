import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/model/weather_info_item_model.dart';
import 'package:tuple/tuple.dart';

final weatherAndAddressProvider =
    FutureProvider<Tuple2<WeatherInfo, String>>((ref) async {
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
    final googleMapsUrl =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=AIzaSyDG7l0GqvNIGmesrZa30vt0iuv8MBX6k6o&language=ko';
    final googleMapsUriResponse = await http.get(Uri.parse(googleMapsUrl));

    if (googleMapsUriResponse.statusCode == 200) {
      final address = jsonDecode(googleMapsUriResponse.body)['results'][0]
          ['address_components'][2]['long_name'];
      return Tuple2(weatherInfo, address);
    } else {
      throw Exception('Failed to load address data');
    }
  } else {
    throw Exception('Failed to load weather data');
  }
});
