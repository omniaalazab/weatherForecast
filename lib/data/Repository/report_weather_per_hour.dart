import '../api/weather_api_services.dart';
import '../models/weather_model.dart';

class ReportWeatherForecastRepository {
  // Get current weather data
  // Future<WeatherModel> getCurrentWeather(String cityName) async {
  //   try {
  //     return await WeatherGetAPIServices.getCurrentWeatherData(
  //       searchedcityName: cityName,
  //     );
  //   } catch (e) {
  //     throw Exception("Failed to fetch current weather data: $e");
  //   }
  // }

  // Get weather data per hour
  Future<List<Hour>> getWeatherPerHour(String cityName) async {
    try {
      return await WeatherGetAPIServices.getWeatherDataPerHour(
        searchedcityName: cityName,
      );
    } catch (e) {
      throw Exception("Failed to fetch hourly weather data: $e");
    }
  }

  // Get weather forecast for multiple days
  Future<WeatherModel> getWeatherForecast(String cityName, int days) async {
    try {
      return await WeatherGetAPIServices.getWeatherData10Days(
        searchedcityName: cityName,
        day: days,
      );
    } catch (e) {
      throw Exception("Failed to fetch weather forecast data: $e");
    }
  }
}
