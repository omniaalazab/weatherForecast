// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../../../data/models/weather_model.dart';

class GetWeatherStates {}

class WeatherInitialState extends GetWeatherStates {}

class WeatherLoadingState extends GetWeatherStates {}

class WeatherSucessState extends GetWeatherStates {
  WeatherModel weatherModel;
  WeatherSucessState({
    required this.weatherModel,
  });
}

class WeatherErrorState extends GetWeatherStates {
  final String errorMessage;
  WeatherErrorState({required this.errorMessage});
}
