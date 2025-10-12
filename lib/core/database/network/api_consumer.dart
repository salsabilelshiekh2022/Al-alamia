import 'package:dartz/dartz.dart';

import 'failure.dart';

abstract class ApiConsumer {
  Future<dynamic> get(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
  });
  Future<dynamic> post({
    required String path,
    Object? data,
    Map<String, dynamic>? queryParameters,
    bool isFromData = false,
  });
  Future<dynamic> delete({
    required String path,
    Object? data,
    Map<String, dynamic>? queryParameters,
  });

  Future<Either<Failure, T>> handleRequest<T>({
    required Future<dynamic> Function() request,
    required T Function(dynamic) onSuccess,
  });
}
