import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/data/Repository/report_weather_per_hour.dart';
import 'package:weather_app/presentation/view_model/report_weather_per_hour_cubit/report_weather_per_hour_state.dart';

import '../../../data/models/weather_model.dart';

class ReportWeatherPerHourCubit extends Cubit<ReportWeatherStates> {
  final ReportWeatherForecastRepository reportWeatherRepository;

  ReportWeatherPerHourCubit({required this.reportWeatherRepository})
      : super(ReportWeatherInitialState());
  WeatherModel? weathermodel;
  Future<void> getReportWeatherPerHour(String cityName, int hour) async {
    emit(ReportWeatherLoadingState());
    try {
      final List<Hour> hourList =
          await reportWeatherRepository.getWeatherPerHour(cityName);
      emit(ReportWeatherSucessState(hourList: hourList));
    } catch (e) {
      emit(ReportWeatherErrorState(
          "Failed to fetch weather data :$e.toString()"));
    }
  }
}
