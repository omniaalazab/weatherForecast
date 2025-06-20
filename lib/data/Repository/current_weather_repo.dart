import 'package:dartz/dartz.dart';
import 'package:weather_app/core/error/failure.dart';

import '../api/weather_api_services.dart';
import '../models/weather_model.dart';

class CurrentWeatherRepository {
  final WeatherGetAPIServices weatherService;
  CurrentWeatherRepository(this.weatherService);

  Future<Either<Failure, WeatherModel>> getWeather(String cityName) async {
    if (cityName.isEmpty || cityName.trim().isEmpty) {
      return Left(Failure("City name cannot be empty"));
    }
    try {
      // Call the API service and return the Either result directly
      final result = await weatherService.getCurrentWeatherData(
        searchedcityName: cityName,
      );
      return result;
    } catch (e) {
      return Left(Failure("Failed to fetch weather data: $e"));
    }
  }
}
