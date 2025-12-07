// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/auth/data/repos/auth_repo.dart' as _i507;
import '../../features/auth/data/repos/auth_repo_impl.dart' as _i152;
import '../../features/home/data/repo/home_repo.dart' as _i429;
import '../../features/home/data/repo/home_repo_impl.dart' as _i1024;
import '../database/cache/cache_services.dart' as _i408;
import '../database/network/api_consumer.dart' as _i742;
import '../database/network/dio_consumer.dart' as _i1062;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.lazySingleton<_i408.CacheServices>(() => _i408.CacheServices());
    gh.lazySingleton<_i742.ApiConsumer>(
      () => _i1062.DioConsumer(cacheServices: gh<_i408.CacheServices>()),
    );
    gh.lazySingleton<_i429.HomeRepo>(
      () => _i1024.HomeRepoImpl(apiConsumer: gh<_i742.ApiConsumer>()),
    );
    gh.lazySingleton<_i507.AuthRepo>(
      () => _i152.AuthRepoImpl(apiConsumer: gh<_i742.ApiConsumer>()),
    );
    return this;
  }
}
