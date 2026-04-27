import 'package:alalamia/features/home/data/repo/home_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/enums/request_status.dart';
import '../../data/models/currency_model.dart';
import '../../data/models/transfer_currency_request_params.dart';
import 'home_state.dart';

@Singleton()
class HomeCubit extends Cubit<HomeState> {
  HomeCubit({required this.homeRepo}) : super(HomeState.initial());
  final HomeRepo homeRepo;

  Future<void> getBranchCurrencies() async {
    emit(state.copyWith(homeStatus: RequestStatus.loading));
    final result = await homeRepo.getBranchCurrencies();
    result.fold(
      (failure) => emit(state.copyWith(homeStatus: RequestStatus.error)),
      (walletsList) => emit(
        state.copyWith(
          homeStatus: RequestStatus.success,
          walletsList: walletsList,
        ),
      ),
    );
  }

  Future<void> getDenominationsOfCurrency({required int currencyId}) async {
    emit(
      state.copyWith(
        denominationsStatus: RequestStatus.loading,
        denominations: [],
      ),
    );
    final result = await homeRepo.getDenominationsOfCurrency(
      currencyId: currencyId,
    );
    result.fold(
      (failure) =>
          emit(state.copyWith(denominationsStatus: RequestStatus.error)),
      (response) => emit(
        state.copyWith(
          denominationsStatus: RequestStatus.success,
          denominations: response.data,
          denominationsMeta: response.meta,
        ),
      ),
    );
  }

  Future<void> getCurrencies({int toCurrencies = 0}) async {
    emit(state.copyWith(homeStatus: RequestStatus.loading));
    final result = await homeRepo.getCurrencies(toCurrencies: toCurrencies);
    result.fold(
      (failure) => emit(state.copyWith(homeStatus: RequestStatus.error)),
      (currenciesList) => _handleCurrenciesSuccess(currenciesList),
    );
  }

  void _handleCurrenciesSuccess(List<CurrencyModel> currenciesList) {
    if (currenciesList.length >= 2) {
      transferCurrency(
        transferCurrencyRequestParams: TransferCurrencyRequestParams(
          fromCurrencyId: currenciesList.first.id!,
          toCurrencyId: currenciesList[1].id!,
        ),
      );
    }

    emit(
      state.copyWith(
        homeStatus: RequestStatus.success,
        currenciesList: currenciesList,
      ),
    );
  }

  Future<void> transferCurrency({
    required TransferCurrencyRequestParams transferCurrencyRequestParams,
  }) async {
    emit(state.copyWith(transferCurrencyStatus: RequestStatus.loading));
    final result = await homeRepo.transferCurrency(
      transferCurrencyRequestParams: transferCurrencyRequestParams,
    );
    result.fold(
      (failure) =>
          emit(state.copyWith(transferCurrencyStatus: RequestStatus.error)),
      (transferCurrency) => emit(
        state.copyWith(
          transferCurrencyStatus: RequestStatus.success,
          transferCurrency: transferCurrency,
        ),
      ),
    );
  }
}
