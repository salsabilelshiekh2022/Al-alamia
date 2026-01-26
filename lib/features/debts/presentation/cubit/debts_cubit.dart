import 'package:alalamia/features/debts/data/repos/debt_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/enums/request_status.dart';
import '../../data/models/add_debt_request_params.dart';
import '../../data/models/debt_model.dart';
import '../../data/models/get_debts_by_currency_request_params.dart';
import '../../data/models/pay_debt_request_params.dart';
import 'debt_state.dart';

@injectable
class DebtsCubit extends Cubit<DebtsState> {
  DebtsCubit({required this.debtRepo}) : super(const DebtsState());

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

  Future<void> payDebt({
    required PayDebtRequestParams payDebtRequestParams,
  }) async {
    emit(state.copyWith(debtsStatus: RequestStatus.loading));
    final result = await debtRepo.payDebt(
      payDebtRequestParams: payDebtRequestParams,
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

  Future<void> getDebtsByCurrency({required int id, required GetDebtsByCurrencyRequestParams params}) async {
    emit(state.copyWith(getDebtsByCurrencyStatus: RequestStatus.loading));
    final result = await debtRepo.getDebtsByCurrency(id: id, params: params);
    result.fold(
      (failure) => emit(
        state.copyWith(
          getDebtsByCurrencyStatus: RequestStatus.error,
          message: failure.message,
        ),
      ),
      (debts) => emit(
        state.copyWith(
          getDebtsByCurrencyStatus: RequestStatus.success,
          debtsAmountByCurrency: debts,
        ),
      ),
    );
  }

  // Pagination methods
  Future<void> fetchDebtsTransactions({required String type}) async {
    emit(state.copyWith(debtsStatus: RequestStatus.loading));
    final result = await debtRepo.getDebtsTransactions(type: type, page: 1);
    result.fold(
      (failure) => emit(
        state.copyWith(
          debtsStatus: RequestStatus.error,
          message: failure.message,
        ),
      ),
      (debtsResponse) {
        final hasReachedMax = _checkIfReachedMax(debtsResponse);
        emit(
          state.copyWith(
            debtsStatus: RequestStatus.success,
            debtsResponse: debtsResponse,
            debtsList: debtsResponse.debtsList ?? [],
            debtsTransactions: debtsResponse.debtsList,
            currentPage: 1,
            hasReachedMax: hasReachedMax,
          ),
        );
      },
    );
  }

  Future<void> loadMoreDebts({required String type}) async {
    if (state.hasReachedMax || state.isLoadingMore) return;

    emit(state.copyWith(debtsStatus: RequestStatus.loadingMore));

    final nextPage = state.currentPage + 1;
    final result = await debtRepo.getDebtsTransactions(type: type, page: nextPage);

    result.fold(
      (failure) => emit(
        state.copyWith(
          debtsStatus: RequestStatus.error,
          message: failure.message,
        ),
      ),
      (debtsResponse) {
        final newDebts = debtsResponse.debtsList ?? [];
        final updatedList = List<DebtModel>.from(state.debtsList)..addAll(newDebts);

        final hasReachedMax = _checkIfReachedMax(debtsResponse) || newDebts.isEmpty;

        emit(
          state.copyWith(
            debtsStatus: RequestStatus.success,
            debtsResponse: debtsResponse,
            debtsList: updatedList,
            debtsTransactions: updatedList,
            currentPage: nextPage,
            hasReachedMax: hasReachedMax,
          ),
        );
      },
    );
  }

  Future<void> refreshDebtsTransactions({required String type}) async {
    emit(state.copyWith(debtsStatus: RequestStatus.refreshing));

    final result = await debtRepo.getDebtsTransactions(type: type, page: 1);
    result.fold(
      (failure) => emit(
        state.copyWith(
          debtsStatus: RequestStatus.error,
          message: failure.message,
        ),
      ),
      (debtsResponse) {
        final hasReachedMax = _checkIfReachedMax(debtsResponse);
        emit(
          state.copyWith(
            debtsStatus: RequestStatus.success,
            debtsResponse: debtsResponse,
            debtsList: debtsResponse.debtsList ?? [],
            debtsTransactions: debtsResponse.debtsList,
            currentPage: 1,
            hasReachedMax: hasReachedMax,
          ),
        );
      },
    );
  }

  bool _checkIfReachedMax(DebtsResponseModel debtsResponse) {
    if (debtsResponse.meta == null) return true;

    final currentPage = debtsResponse.meta!.currentPage ?? 1;
    final lastPage = debtsResponse.meta!.lastPage ?? 1;

    return currentPage >= lastPage;
  }

  // Keep old method for backward compatibility (deprecated)
  @Deprecated('Use fetchDebtsTransactions instead')
  Future<void> getDebtsTransactions({required String type}) async {
    await fetchDebtsTransactions(type: type);
  }
}
