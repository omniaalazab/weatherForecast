import 'package:weather_app/data/models/weather_model.dart';

class ReportWeatherStates {}

class ReportWeatherInitialState extends ReportWeatherStates {}

class ReportWeatherLoadingState extends ReportWeatherStates {}

class ReportWeatherSucessState extends ReportWeatherStates {
  List<Hour> hourList;
  ReportWeatherSucessState({
    required this.hourList,
  });
}

class ReportWeatherErrorState extends ReportWeatherStates {
  final String errorMessage;
  ReportWeatherErrorState(this.errorMessage);
}
