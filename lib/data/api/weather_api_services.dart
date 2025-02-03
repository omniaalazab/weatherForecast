import 'dart:developer';

import 'package:dio/dio.dart';

import '../../core/api_constant.dart';
import '../../helper/dio_helper.dart';
import '../models/weather_model.dart';

class WeatherGetAPIServices {
  static Future<WeatherModel> getCurrentWeatherData({
    required String searchedcityName,
  }) async {
    try {
      Response response = await DioHelper.dio.get(
        '${APIConstant.weatherAPIBaseUrl}/forecast.json',
        queryParameters: {
          'key': APIConstant.weatherAPIKey,
          'q': searchedcityName,
          'days': 1,
        },
      );

      Map<String, dynamic> jsonData = response.data;
      WeatherModel weatherModel = WeatherModel.fromJson(jsonData);
      return weatherModel;
    } on DioException catch (e) {
      String errorMsg = e.response?.data['error']['message'] ??
          'There is Error, try again Later...';
      throw Exception(errorMsg);
    } catch (e) {
      log(e.toString());
      throw Exception('There is error, try again');
    }
  }

  static Future<List<Hour>> getWeatherDataPerHour({
    required String searchedcityName,
  }) async {
    try {
      Response response = await DioHelper.dio.get(
        '${APIConstant.weatherAPIBaseUrl}/forecast.json',
        queryParameters: {
          'key': APIConstant.weatherAPIKey,
          'q': searchedcityName,
          'days': 1,
        },
      );

      Map<String, dynamic> jsonData = response.data;
      WeatherModel weatherModel = WeatherModel.fromJson(jsonData);
      return weatherModel.forecast.forecastDays[0].hours;
    } on DioException catch (e) {
      String errorMsg = e.response?.data['error']['message'] ??
          'There is Error, try again Later...';
      throw Exception(errorMsg);
    } catch (e) {
      log(e.toString());
      throw Exception('There is error, try again');
    }
  }

  static Future<WeatherModel> getWeatherData10Days({
    required String searchedcityName,
    required int day,
  }) async {
    try {
      Response response = await DioHelper.dio.get(
        '${APIConstant.weatherAPIBaseUrl}/forecast.json',
        queryParameters: {
          'key': APIConstant.weatherAPIKey,
          'q': searchedcityName,
          'days': day,
        },
      );

      Map<String, dynamic> jsonData = response.data;
      WeatherModel weatherModel = WeatherModel.fromJson(jsonData);
      return weatherModel;
    } on DioException catch (e) {
      String errorMsg = e.response?.data['error']['message'] ??
          'There is Error, try again Later...';
      throw Exception(errorMsg);
    } catch (e) {
      log(e.toString());
      throw Exception('There is error, try again');
    }
  }
}
