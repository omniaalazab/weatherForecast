import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:weather_app/core/error/failure.dart';

import '../../core/api_constant.dart';

import '../models/weather_model.dart';

class WeatherGetAPIServices {
  final Dio dio;
  WeatherGetAPIServices(this.dio);
  Future<Either<Failure, WeatherModel>> getCurrentWeatherData({
    required String searchedcityName,
  }) async {
    try {
      Response response = await dio.get(
        '${APIConstant.weatherAPIBaseUrl}/forecast.json',
        queryParameters: {
          'key': APIConstant.weatherAPIKey,
          'q': searchedcityName,
          'days': 1,
        },
      );
      if (response.statusCode != 200 || response.data == null) {
        return Left(Failure('Failed to fetch weather data'));
      } else {
        Map<String, dynamic> jsonData = response.data;
        WeatherModel weatherModel = WeatherModel.fromJson(jsonData);

        return Right(weatherModel);
      }
    } on DioException catch (e) {
      String errorMsg = e.response?.data['error']['message'] ??
          'There is Error, try again Later...';
      return Left(Failure(errorMsg));
    } catch (e) {
      log(e.toString());
      return Left(Failure("There is error, try again"));
    }
  }

  Future<Either<Failure, List<Hour>>> getWeatherDataPerHour({
    required String searchedcityName,
  }) async {
    try {
      Response response = await dio.get(
        '${APIConstant.weatherAPIBaseUrl}/forecast.json',
        queryParameters: {
          'key': APIConstant.weatherAPIKey,
          'q': searchedcityName,
          'days': 1,
        },
      );
      if (response.statusCode != 200 || response.data == null) {
        return Left(Failure('Failed to fetch weather data'));
      } else {
        Map<String, dynamic> jsonData = response.data;
        WeatherModel weatherModel = WeatherModel.fromJson(jsonData);
        return Right(weatherModel.forecast.forecastDays[0].hours);
      }
    } on DioException catch (e) {
      String errorMsg = e.response?.data['error']['message'] ??
          'There is Error, try again Later...';
      return Left(Failure(errorMsg));
    } catch (e) {
      log(e.toString());
      return Left(Failure('There is error, try again'));
    }
  }

  Future<Either<Failure, WeatherModel>> getWeatherData10Days({
    required String searchedcityName,
    required int day,
  }) async {
    try {
      Response response = await dio.get(
        '${APIConstant.weatherAPIBaseUrl}/forecast.json',
        queryParameters: {
          'key': APIConstant.weatherAPIKey,
          'q': searchedcityName,
          'days': day,
        },
      );
      if (response.statusCode != 200 || response.data == null) {
        return Left(Failure('Failed to fetch weather data'));
      } else {
        Map<String, dynamic> jsonData = response.data;
        WeatherModel weatherModel = WeatherModel.fromJson(jsonData);
        return Right(weatherModel);
      }
    } on DioException catch (e) {
      String errorMsg = e.response?.data['error']['message'] ??
          'There is Error, try again Later...';
      return Left(Failure(errorMsg));
    } catch (e) {
      log(e.toString());
      return Left(Failure('There is error, try again'));
    }
  }
}
