import 'package:alalamia/core/database/network/failure.dart';
import 'package:alalamia/features/home/data/models/currency_model.dart';
import 'package:alalamia/features/home/data/models/transfer_currency_model.dart';
import 'package:alalamia/features/home/data/models/wallet_model.dart';
import 'package:alalamia/features/home/data/models/denominations_model.dart';
import 'package:alalamia/features/home/data/repo/home_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/database/network/api_consumer.dart';
import '../../../../core/database/network/end_points.dart';
import '../models/transfer_currency_request_params.dart';

@LazySingleton(as: HomeRepo)
class HomeRepoImpl extends HomeRepo {
  final ApiConsumer apiConsumer;
  HomeRepoImpl({required this.apiConsumer});

  @override
  Future<Either<Failure, List<WalletModel>>> getBranchCurrencies() {
    return apiConsumer.handleRequest(
      request: () => apiConsumer.get(EndPoints.getBranchCurrencies),
      onSuccess: (result) {
        final data = result['data'] as List;
        return data.map((e) => WalletModel.fromJson(e)).toList();
      },
    );
  }

  @override
  Future<Either<Failure, List<DenominationsModel>>> getDenominationsOfCurrency({
    required int currencyId,
  }) {
    return apiConsumer.handleRequest(
      request: () =>
          apiConsumer.get(EndPoints.getDenominations(id: currencyId)),
      onSuccess: (result) {
        final data = result['data'] as List;
        return data.map((e) => DenominationsModel.fromJson(e)).toList();
      },
    );
  }

  @override
  Future<Either<Failure, List<CurrencyModel>>> getCurrencies() {
    return apiConsumer.handleRequest(
      request: () => apiConsumer.get(EndPoints.getCurrencies),
      onSuccess: (result) {
        final data = result['data'] as List;
        return data.map((e) => CurrencyModel.fromJson(e)).toList();
      },
    );
  }

  @override
  Future<Either<Failure, TransferCurrencyModel>> transferCurrency({
    required TransferCurrencyRequestParams transferCurrencyRequestParams,
  }) {
    return apiConsumer.handleRequest(
      request: () => apiConsumer.post(
        path: EndPoints.transferCurrency,
        data: transferCurrencyRequestParams.toJson(),
      ),
      onSuccess: (result) {
        return TransferCurrencyModel.fromJson(result['data']);
      },
    );
  }
}
