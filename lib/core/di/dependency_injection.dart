import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:requests_inspector/requests_inspector.dart';
import '../database/cache/cache_services.dart';
import '../database/network/api_consumer.dart';
import '../database/network/dio_consumer.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerLazySingleton<CacheServices>(
    () => CacheServices(),
  );
  getIt.registerSingleton<ApiConsumer>(DioConsumer(
    dio: Dio()
      ..interceptors.add(
        RequestsInspectorInterceptor(),
      ),
    cacheServices: getIt<CacheServices>(),
  ));
  
}
