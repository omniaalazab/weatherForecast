import 'package:dartz/dartz.dart';
import 'package:weather_app/core/error/failure.dart';

import '../api/weather_api_services.dart';
import '../models/weather_model.dart';

class ReportWeatherForecastRepository {
  final WeatherGetAPIServices weatherService;
  ReportWeatherForecastRepository(this.weatherService);

  // Get weather data per hour
  Future<Either<Failure, List<Hour>>> getWeatherPerHour(String cityName) async {
    try {
      return await weatherService.getWeatherDataPerHour(
        searchedcityName: cityName,
      );
    } catch (e) {
      throw Exception("Failed to fetch hourly weather data: $e");
    }
  }

  // Get weather forecast for multiple days
  Future<Either<Failure, WeatherModel>> getWeatherForecast(
      String cityName, int days) async {
    try {
      return await weatherService.getWeatherData10Days(
        searchedcityName: cityName,
        day: days,
      );
    } catch (e) {
      throw Exception("Failed to fetch weather forecast data: $e");
    }
  }
}
