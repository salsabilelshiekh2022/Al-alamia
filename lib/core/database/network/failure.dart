// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';

class CacheFailure extends Failure {
  CacheFailure({required super.message});
}

class Failure implements Exception {
  final String message;
  final int? statusCode;

  Failure({required this.message, this.statusCode});

  @override
  int get hashCode => message.hashCode;

  @override
  bool operator ==(covariant Failure other) {
    if (identical(this, other)) return true;

    return other.message == message;
  }
}

class ServerFailure extends Failure {
  ServerFailure({required super.message, super.statusCode});

  factory ServerFailure.fromDioError(DioException e) {
    if (e.response?.statusCode == 401) {
      // Future.microtask(() async {
      //   await Hive.box(HiveBoxes.userModelBox).clear();
      //   AppKeys.navigatorKey.currentState!
      //       .pushNamedAndRemoveUntil(Routes.loginView, (route) => false);
      //   GlobalUiUtils.showSnackBar(
      //     AppKeys.navigatorKey.currentContext!,
      //     msg: e.response!.data['error']['message'],
      //     title: S.of(AppKeys.navigatorKey.currentContext!).error,
      //   );
      // });
      return ServerFailure(message: 'Unauthorized access.');
    }
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure(message: 'Connection timeout with ApiServer');
      case DioExceptionType.sendTimeout:
        return ServerFailure(message: 'Send timeout with ApiServer');
      case DioExceptionType.receiveTimeout:
        return ServerFailure(message: 'Receive timeout with ApiServer');
      case DioExceptionType.badCertificate:
        return ServerFailure(message: 'Bad certification with ApiServer');
      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
          e.response!.statusCode!,
          e.response!.data,
        );
      case DioExceptionType.cancel:
        return ServerFailure(message: 'Request to ApiServer was canceld');
      case DioExceptionType.connectionError:
        return ServerFailure(message: 'NoInternet connection');
      case DioExceptionType.unknown:
        return ServerFailure(
          message: 'Opps there was an error, Please try again',
        );
    }
  }

  factory ServerFailure.fromResponse(int statusCode, dynamic response) {
    if (statusCode == 404) {
      return ServerFailure(message: response['error']['message']);
    } else if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      return ServerFailure(message: response['error']['message']);
    } else if (statusCode == 428) {
      return ServerFailure(
        message: response['error']['message'],
        statusCode: statusCode,
      );
    } else if (statusCode == 500) {
      return ServerFailure(
          message: response['message'], statusCode: statusCode);
    } else if (statusCode == 422) {
      return ServerFailure(
        message: response['error']['message'],
        statusCode: statusCode,
      );
    } else {
      return ServerFailure(message: response?['error']?['message'] ?? '');
    }
  }
}

class LogInWithGoogleFailure implements Failure {
  const LogInWithGoogleFailure([
    this.message = 'An unknown exception occurred.',
  ]);

  factory LogInWithGoogleFailure.fromCode(String code) {
    switch (code) {
      case 'account-exists-with-different-credential':
        return const LogInWithGoogleFailure(
          'Account exists with different credentials.',
        );
      case 'invalid-credential':
        return const LogInWithGoogleFailure(
          'The credential received is malformed or has expired.',
        );
      case 'operation-not-allowed':
        return const LogInWithGoogleFailure(
          'Operation is not allowed.  Please contact support.',
        );
      case 'user-disabled':
        return const LogInWithGoogleFailure(
          'This user has been disabled. Please contact support for help.',
        );
      case 'user-not-found':
        return const LogInWithGoogleFailure(
          'Email is not found, please create an account.',
        );
      case 'wrong-password':
        return const LogInWithGoogleFailure(
          'Incorrect password, please try again.',
        );
      case 'invalid-verification-code':
        return const LogInWithGoogleFailure(
          'The credential verification code received is invalid.',
        );
      case 'invalid-verification-id':
        return const LogInWithGoogleFailure(
          'The credential verification ID received is invalid.',
        );
      default:
        return const LogInWithGoogleFailure();
    }
  }

  @override
  final String message;

  @override
  int? get statusCode => throw UnimplementedError();
}
