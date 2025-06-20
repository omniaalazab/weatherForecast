import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/data/repository/report_weather_per_hour.dart';
import 'package:weather_app/presentation/bloc/report_weather_per_hour_cubit/report_weather_per_hour_state.dart';

import '../../../data/models/weather_model.dart';

class ReportWeatherPerHourCubit extends Cubit<ReportWeatherStates> {
  final ReportWeatherForecastRepository reportWeatherRepository;

  ReportWeatherPerHourCubit({required this.reportWeatherRepository})
      : super(ReportWeatherInitialState());
  WeatherModel? weathermodel;
  Future<void> getReportWeatherPerHour(String cityName, int hour) async {
    emit(ReportWeatherLoadingState());

    final result = await reportWeatherRepository.getWeatherPerHour(cityName);
    result.fold((failure) => emit(ReportWeatherErrorState(failure.message)),
        (hourList) => emit(ReportWeatherSucessState(hourList: hourList)));
  }
}
