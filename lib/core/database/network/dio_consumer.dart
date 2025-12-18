import 'dart:io';

import 'package:alalamia/core/database/network/end_points.dart';
import 'package:alalamia/core/database/network/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:requests_inspector/requests_inspector.dart';

import '../../../features/auth/data/models/user_model.dart';
import '../../utils/app_constatnts.dart';
import '../../utils/app_keys.dart';
import '../../utils/app_logs.dart';
import '../cache/cache_helper.dart';
import '../cache/cache_services.dart';
import 'api_consumer.dart';

@LazySingleton(as: ApiConsumer)
class DioConsumer extends ApiConsumer {
  final dio = Dio()..interceptors.add(RequestsInspectorInterceptor());
  final CacheServices cacheServices;

  DioConsumer({required this.cacheServices}) {
    dio.options.baseUrl = EndPoints.baseUrl;

    if (kDebugMode) {
      dio.interceptors.add(_buildLogger());
    }

    dio.interceptors.add(_buildInterceptor());
  }

  Interceptor _buildLogger() {
    return PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
      maxWidth: 90,
      enabled: kDebugMode,
    );
  }

  Interceptor _buildInterceptor() {
    return InterceptorsWrapper(
      onRequest: (options, handler) async {
        options.headers = await _buildHeaders();
        handler.next(options);
      },
      onResponse: (response, handler) => handler.next(response),
      onError: (error, handler) => handler.next(error),
    );
  }

  Future<Map<String, String>> _buildHeaders() async {
   final user = cacheServices.getDataFromCache<UserModel?>(
      boxName: CacheBoxes.userModelBox,
      key: 'user',
    );
   final token = user?.token ?? '';
   
    final locale =
        EasyLocalization.of(
          AppKeys.navigatorKey.currentContext!,
        )?.locale.languageCode ??
        'ar';
    // final deviceId = await _getDeviceToken() ?? '';

    return {
      'Content-Type': 'application/json',
      'accept': 'application/json',
      'lang': locale,
      'client-type': Platform.isIOS ? 'ios' : 'android',
      'client-version': AppConstants.appVersion,
      //'Device-ID': deviceId,
      if (token.isNotEmpty)
        AppConstants.authorizationKey: '${AppConstants.bearerKey} $token',
    };
  }

  Future<String?> _getDeviceToken() async {
    return FirebaseMessaging.instance.getToken();
  }

  @override
  Future<Either<Failure, T>> handleRequest<T>({
    required Future<dynamic> Function() request,
    required T Function(dynamic) onSuccess,
  }) async {
    try {
      final result = await request();
      return Right(onSuccess(result));
    } on SocketException catch (e) {
      AppLogs.errorLog(e.toString(), 'SocketException');
      return Left(ServerFailure(message: e.message));
    } on DioException catch (e) {
      AppLogs.errorLog(e.toString(), 'DioException');
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      AppLogs.errorLog(e.toString(), 'General Exception');
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<dynamic> get(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
  }) {
    return dio
        .get(path, data: data, queryParameters: queryParameters)
        .then((response) => response.data);
  }

  @override
  Future<dynamic> post({
    required String path,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isFromData = false,
  }) {
    return dio
        .post(
          path,
          data: isFromData ? FormData.fromMap(data) : data,
          queryParameters: queryParameters,
        )
        .then((response) => response.data);
  }

  @override
  Future<dynamic> delete({
    required String path,
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    data ??= {};
    data["fcm_token"] = await _getDeviceToken();
    final response = await dio.delete(
      path,
      data: data,
      queryParameters: queryParameters,
    );
    return response.data;
  }
}
