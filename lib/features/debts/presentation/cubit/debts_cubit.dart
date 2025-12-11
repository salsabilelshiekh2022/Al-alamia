import 'package:alalamia/features/debts/data/repos/debt_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/enums/request_status.dart';
import '../../../expenses/presentation/cubit/expenses_state.dart';
import '../../data/models/add_debt_request_params.dart';
import 'debt_state.dart';

@injectable
class DebtsCubit extends Cubit<DebtsState> {
  DebtsCubit({required this.debtRepo}) : super(DebtsState());

  final DebtRepo debtRepo;

  Future<void> addDebt({
    required AddDebtRequestParams addDebtRequestParams,
  }) async {
    emit(state.copyWith(debtsStatus: RequestStatus.loading));
    final result = await debtRepo.addDebt(
      addDebtRequestParams: addDebtRequestParams,
    );
    result.fold(
      (failure) => emit(
        state.copyWith(
          debtsStatus: RequestStatus.error,
          message: failure.message,
        ),
      ),
      (message) => emit(
        state.copyWith(debtsStatus: RequestStatus.success, message: message),
      ),
    );
  }
}
