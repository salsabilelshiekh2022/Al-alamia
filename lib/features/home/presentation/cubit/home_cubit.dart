import 'package:alalamia/features/home/data/repo/home_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/enums/request_status.dart';
import 'home_state.dart';

@Singleton()
class HomeCubit extends Cubit<HomeState> {
  HomeCubit({required this.homeRepo}) : super(HomeState());
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
      (denominations) => emit(
        state.copyWith(
          denominationsStatus: RequestStatus.success,
          denominations: denominations,
        ),
      ),
    );
  }

  Future<void> getCurrencies() async {
    emit(state.copyWith(homeStatus: RequestStatus.loading));
    final result = await homeRepo.getCurrencies();
    result.fold(
      (failure) => emit(state.copyWith(homeStatus: RequestStatus.error)),
      (currenciesList) => emit(
        state.copyWith(
          homeStatus: RequestStatus.success,
          currenciesList: currenciesList,
        ),
      ),
    );
  }
}
