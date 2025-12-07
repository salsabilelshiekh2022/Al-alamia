import 'package:alalamia/core/database/network/failure.dart';
import 'package:alalamia/features/home/data/models/currency_model.dart';
import 'package:alalamia/features/home/data/repo/home_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/database/network/api_consumer.dart';
import '../../../../core/database/network/end_points.dart';
@LazySingleton(as: HomeRepo)
class HomeRepoImpl extends HomeRepo {
  final ApiConsumer apiConsumer;
  HomeRepoImpl({required this.apiConsumer});

  @override
  Future<Either<Failure, List<CurrencyModel>>> getBranchCurrencies() {
     return apiConsumer.handleRequest(
      request: () => apiConsumer.get( EndPoints.getBranchCurrencies,
         ),
      onSuccess: (result) {
        return (result as List).map((e) => CurrencyModel.fromJson(e)).toList();
      },
    );
  }
}