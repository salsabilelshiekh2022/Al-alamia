import 'package:alalamia/features/home/data/repo/home_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/enums/request_status.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {

  HomeCubit({required this.homeRepo}) : super(HomeState());
  final HomeRepo homeRepo ;

  Future<void> getBranchCurrencies() async {
    emit(state.copyWith(homeStatus: RequestStatus.loading));
    final result = await homeRepo.getBranchCurrencies();
    result.fold(
      (failure) => emit(state.copyWith(homeStatus: RequestStatus.error)),
      (currenciesList) => emit(state.copyWith(homeStatus: RequestStatus.success, currenciesList: currenciesList)),
    );
  }

}