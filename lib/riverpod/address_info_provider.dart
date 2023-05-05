import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

final addressInfoProvider = FutureProvider<String>(
  (ref) async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    final latitude = position.latitude.toString();
    final longitude = position.longitude.toString();

    final googleMapsUrl =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=AIzaSyDG7l0GqvNIGmesrZa30vt0iuv8MBX6k6o&language=ko';

    final googleMapsUriResponse = await http.get(Uri.parse(googleMapsUrl));

    if (googleMapsUriResponse.statusCode == 200) {
      return jsonDecode(googleMapsUriResponse.body)['results'][0]
          ['address_components'][2]['long_name'];
    } else {
      throw Exception('Failed to load google maps data');
    }
  },
);
