import '../../../data/models/weather_model.dart';

class ReportWeather10DaysStates {}

class ReportWeatherInitial10DaysState extends ReportWeather10DaysStates {}

class ReportWeatherLoading10DaysState extends ReportWeather10DaysStates {}

class ReportWeatherSucess10DaysState extends ReportWeather10DaysStates {
  WeatherModel weatherModel;
  ReportWeatherSucess10DaysState({
    required this.weatherModel,
  });
}

class ReportWeatherError10DaysState extends ReportWeather10DaysStates {
  final String errorMessage;
  ReportWeatherError10DaysState(this.errorMessage);
}
