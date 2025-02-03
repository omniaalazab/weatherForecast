class WeatherModel {
  late Location location;
  late Current current;
  late Forecast forecast;

  WeatherModel();

  WeatherModel.fromJson(Map<String, dynamic> json) {
    location = json['location'] != null
        ? Location.fromJson(json['location'])
        : Location();
    current =
        json['current'] != null ? Current.fromJson(json['current']) : Current();
    forecast = json['forecast'] != null
        ? Forecast.fromJson(json['forecast'])
        : Forecast();
  }
}

class Location {
  late String name;

  Location({this.name = ''});

  Location.fromJson(Map<String, dynamic> json) {
    name = json['name'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    return data;
  }
}

class Current {
  late int humidity;
  late double windKph;
  late Condition condition;
  late double tempC;

  Current(
      {this.humidity = 0,
      this.windKph = 0.0,
      this.tempC = 0,
      Condition? condition})
      : condition = condition ?? Condition();

  Current.fromJson(Map<String, dynamic> json) {
    tempC = (json['temp_c'] ?? 0.0).toDouble();
    humidity = json['humidity'] ?? 0;
    windKph = (json['wind_kph'] ?? 0.0).toDouble();
    condition = json['condition'] != null
        ? Condition.fromJson(json['condition'])
        : Condition();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['humidity'] = humidity;
    data['wind_kph'] = windKph;
    data['condition'] = condition.toJson();
    data['temp_c'] = tempC;
    return data;
  }
}

class Condition {
  late String text;
  late String icon;

  Condition({this.text = '', this.icon = ''});

  Condition.fromJson(Map<String, dynamic> json) {
    text = json['text'] ?? '';
    icon = json['icon'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['text'] = text;
    data['icon'] = icon;
    return data;
  }
}

class Forecast {
  late List<ForecastDay> forecastDays;

  Forecast({List<ForecastDay>? forecastDays})
      : forecastDays = forecastDays ?? [];

  Forecast.fromJson(Map<String, dynamic> json) {
    forecastDays = [];
    if (json['forecastday'] != null) {
      forecastDays = (json['forecastday'] as List)
          .map((day) => ForecastDay.fromJson(day))
          .toList();
    }
  }
}

class ForecastDay {
  late String date;
  late DayForecast day;
  late List<Hour> hours;

  ForecastDay({
    this.date = '',
    DayForecast? day,
    List<Hour>? hours,
  })  : day = day ?? DayForecast(),
        hours = hours ?? [];

  ForecastDay.fromJson(Map<String, dynamic> json) {
    date = json['date'] ?? '';
    day =
        json['day'] != null ? DayForecast.fromJson(json['day']) : DayForecast();
    hours = [];
    if (json['hour'] != null) {
      hours = List<Hour>.from(
          (json['hour'] as List).map((hour) => Hour.fromJson(hour)));
    }
  }
}

class DayForecast {
  late double maxtempC;
  late double mintempC;
  late Condition condition;

  DayForecast({
    this.maxtempC = 0.0,
    this.mintempC = 0.0,
    Condition? condition,
  }) : condition = condition ?? Condition();

  DayForecast.fromJson(Map<String, dynamic> json) {
    maxtempC = (json['maxtemp_c'] ?? 0.0).toDouble();
    mintempC = (json['mintemp_c'] ?? 0.0).toDouble();
    condition = json['condition'] != null
        ? Condition.fromJson(json['condition'])
        : Condition();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['maxtemp_c'] = maxtempC;
    data['mintemp_c'] = mintempC;
    data['condition'] = condition.toJson();
    return data;
  }
}

class Day {
  late double maxtempC;
  late double mintempC;
  late double avghumidity;
  late double maxwindKph;
  late Condition condition;

  Day({
    this.maxtempC = 0.0,
    this.mintempC = 0.0,
    this.avghumidity = 0.0,
    this.maxwindKph = 0.0,
    Condition? condition,
  }) : condition = condition ?? Condition();

  Day.fromJson(Map<String, dynamic> json) {
    maxtempC = (json['maxtemp_c'] ?? 0.0).toDouble();
    mintempC = (json['mintemp_c'] ?? 0.0).toDouble();
    avghumidity = (json['avghumidity'] ?? 0.0).toDouble();
    maxwindKph = (json['maxwind_kph'] ?? 0.0).toDouble();
    condition = json['condition'] != null
        ? Condition.fromJson(json['condition'])
        : Condition();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['maxtemp_c'] = maxtempC;
    data['mintemp_c'] = mintempC;
    data['avghumidity'] = avghumidity;
    data['maxwind_kph'] = maxwindKph;
    data['condition'] = condition.toJson();
    return data;
  }
}

class Hour {
  late String time;
  late double tempC;
  late String icon;

  Hour({this.time = '', this.tempC = 0.0, this.icon = ''});

  Hour.fromJson(Map<String, dynamic> json) {
    time = json['time'] ?? '';
    tempC = (json['temp_c'] ?? 0.0).toDouble();
    icon = json['condition']?['icon'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['time'] = time;
    data['temp_c'] = tempC;
    data['icon'] = icon;
    return data;
  }
}
