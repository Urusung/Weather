import 'package:intl/intl.dart';

class WeatherInfo {
  final String coordLongitude;
  final String coordLatitude;
  final int weatherId;
  final String weatherMain;
  final String weatherDescription;
  final String weatherIcon;
  final String base;
  final String mainTemp;
  final String mainFeelsLike;
  final String mainTempMin;
  final String mainTempMax;
  final String mainPressure;
  final String mainHumidity;
  final String mainSeaLevel;
  final String mainGrndLevel;
  final String visibility;
  final String windSpeed;
  final String windDeg;
  final String windGust;
  final String rain1h;
  final String cloudsAll;
  final String dt;
  final String sysType;
  final String sysId;
  final String sysCountry;
  final String sysSunrise;
  final String sysSunset;
  final String timeZone;
  final String id;
  final String name;
  final String cod;

  WeatherInfo({
    required this.coordLongitude,
    required this.coordLatitude,
    required this.weatherId,
    required this.weatherMain,
    required this.weatherDescription,
    required this.weatherIcon,
    required this.base,
    required this.mainTemp,
    required this.mainFeelsLike,
    required this.mainTempMin,
    required this.mainTempMax,
    required this.mainPressure,
    required this.mainHumidity,
    required this.mainSeaLevel,
    required this.mainGrndLevel,
    required this.visibility,
    required this.windSpeed,
    required this.windDeg,
    required this.windGust,
    required this.rain1h,
    required this.cloudsAll,
    required this.dt,
    required this.sysType,
    required this.sysId,
    required this.sysCountry,
    required this.sysSunrise,
    required this.sysSunset,
    required this.timeZone,
    required this.id,
    required this.name,
    required this.cod,
  });

  factory WeatherInfo.fromJson(Map<String, dynamic> json) {
    return WeatherInfo(
      coordLongitude: json['coord']['lon'].toString(),
      coordLatitude: json['coord']['lat'].toString(),
      weatherId: json['weather'][0]['id'],
      weatherMain: getWeatherMain(json['weather'][0]['main'].toString()),
      weatherDescription: json['weather'][0]['description'],
      weatherIcon: json['weather'][0]['icon'],
      base: json['base'],
      mainTemp:
          double.parse(json['main']['temp'].toString()).toStringAsFixed(0),
      mainFeelsLike: double.parse(json['main']['feels_like'].toString())
          .toStringAsFixed(0),
      mainTempMin:
          double.parse(json['main']['temp_min'].toString()).toStringAsFixed(0),
      mainTempMax:
          double.parse(json['main']['temp_max'].toString()).toStringAsFixed(0),
      mainPressure: json['main']['pressure'].toString(),
      mainHumidity: json['main']['humidity'].toString(),
      mainSeaLevel: json['main']['sea_level'].toString(),
      mainGrndLevel: json['main']['grnd_level'].toString(),
      visibility: (double.parse(json['visibility'].toString()) / 1000)
          .toStringAsFixed(0),
      windSpeed: json['wind']['speed'].toString(),
      windDeg: json['wind']['deg'].toString(),
      windGust: json['wind']['gust'].toString(),
      rain1h: json['rain'] != null && json['rain']['1h'] != null
          ? json['rain']['1h'].toString()
          : '0',
      cloudsAll: json['clouds']['all'].toString(),
      dt: json['dt'].toString(),
      sysType: json['sys']['type'].toString(),
      sysId: json['sys']['id'].toString(),
      sysCountry: json['sys']['country'].toString(),
      sysSunrise: DateFormat('a hh:mm', 'ko_KR').format(
        DateTime.fromMillisecondsSinceEpoch(
                int.parse(json['sys']['sunrise'].toString()) * 1000,
                isUtc: true)
            .toLocal(),
      ),
      sysSunset: DateFormat('a hh:mm', 'ko_KR').format(
        DateTime.fromMillisecondsSinceEpoch(
                int.parse(json['sys']['sunset'].toString()) * 1000,
                isUtc: true)
            .toLocal(),
      ),
      timeZone: json['timezone'].toString(),
      id: json['id'].toString(),
      name: json['name'].toString(),
      cod: json['cod'].toString(),
    );
  }
}

String getWeatherMain(String main) {
  switch (main) {
    case 'Thunderstorm':
      return '천둥번개';
    case 'Drizzle':
      return '이슬비';
    case 'Rain':
      return '비';
    case 'Snow':
      return '눈';
    case 'Atmosphere':
      return '안개';
    case 'Clear':
      return '맑음';
    case 'Clouds':
      return '구름';
    case 'Mist':
      return '안개';
    case 'Smoke':
      return '연기';
    case 'Haze':
      return '실안개';
    case 'Dust':
      return '먼지';
    case 'Fog':
      return '안개';
    case 'Sand':
      return '모래';
    case 'Ash':
      return '화산재';
    case 'Squall':
      return '돌풍';
    case 'Tornado':
      return '토네이도';
    default:
      return '정보 없음';
  }
}
