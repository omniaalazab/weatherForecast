import '../api/weather_api_services.dart';
import '../models/weather_model.dart';

class CurrentWeatherRepository {
  Future<WeatherModel> getWeather(String cityName) async {
    try {
      return await WeatherGetAPIServices.getCurrentWeatherData(
          searchedcityName: cityName);
    } catch (e) {
      throw Exception("Failed to fetch weather data: $e");
    }
  }
}
