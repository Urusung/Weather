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
      weatherMain: json['weather'][0]['main'],
      weatherDescription: json['weather'][0]['description'],
      weatherIcon: json['weather'][0]['icon'],
      base: json['base'],
      mainTemp: json['main']['temp'].toString(),
      mainFeelsLike: json['main']['feels_like'].toString(),
      mainTempMin: json['main']['temp_min'].toString(),
      mainTempMax: json['main']['temp_max'].toString(),
      mainPressure: json['main']['pressure'].toString(),
      mainHumidity: json['main']['humidity'].toString(),
      mainSeaLevel: json['main']['sea_level'].toString(),
      mainGrndLevel: json['main']['grnd_level'].toString(),
      visibility: json['visibility'].toString(),
      windSpeed: json['wind']['speed'].toString(),
      windDeg: json['wind']['deg'].toString(),
      windGust: json['wind']['gust'].toString(),
      rain1h: json['rain']['1h'].toString(),
      cloudsAll: json['clouds']['all'].toString(),
      dt: json['dt'].toString(),
      sysType: json['sys']['type'].toString(),
      sysId: json['sys']['id'].toString(),
      sysCountry: json['sys']['country'].toString(),
      sysSunrise: json['sys']['sunrise'].toString(),
      sysSunset: json['sys']['sunset'].toString(),
      timeZone: json['timezone'].toString(),
      id: json['id'].toString(),
      name: json['name'].toString(),
      cod: json['cod'].toString(),
    );
  }
}
