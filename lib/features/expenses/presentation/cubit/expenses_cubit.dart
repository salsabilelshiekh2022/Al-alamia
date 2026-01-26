import 'package:alalamia/features/expenses/data/repos/expenses_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/enums/request_status.dart';
import '../../data/models/expense_model.dart';
import '../../data/models/expenses_request_params.dart';
import 'expenses_state.dart';

@injectable
class ExpensesCubit extends Cubit<ExpensesState> {
  ExpensesCubit({required this.expensesRepo}) : super(ExpensesState());

  final ExpensesRepo expensesRepo;

  Future<void> addExpense({
    required ExpensesRequestParams expensesRequestParams,
  }) async {
    emit(state.copyWith(expensesStatus: RequestStatus.loading));
    final result = await expensesRepo.addExpense(
      expensesRequestParams: expensesRequestParams,
    );
    result.fold(
      (failure) => emit(
        state.copyWith(
          expensesStatus: RequestStatus.error,
          message: failure.message,
        ),
      ),
      (message) => emit(
        state.copyWith(expensesStatus: RequestStatus.success, message: message),
      ),
    );
  }

  Future<void> fetchExpenses() async {
    emit(state.copyWith(expensesStatus: RequestStatus.loading));
    final result = await expensesRepo.getExpenses(page: 1);
    result.fold(
      (failure) => emit(
        state.copyWith(
          expensesStatus: RequestStatus.error,
          message: failure.message,
        ),
      ),
      (expensesResponse) {
        final hasReachedMax = _checkIfReachedMax(expensesResponse);
        emit(
          state.copyWith(
            expensesStatus: RequestStatus.success,
            expensesResponse: expensesResponse,
            expensesList: expensesResponse.expensesList ?? [],
            expenses: expensesResponse.expensesList,
            currentPage: 1,
            hasReachedMax: hasReachedMax,
          ),
        );
      },
    );
  }

  Future<void> loadMoreExpenses() async {
    if (state.hasReachedMax || state.isLoadingMore) return;

    emit(state.copyWith(expensesStatus: RequestStatus.loadingMore));

    final nextPage = state.currentPage + 1;
    final result = await expensesRepo.getExpenses(page: nextPage);

    result.fold(
      (failure) => emit(
        state.copyWith(
          expensesStatus: RequestStatus.error,
          message: failure.message,
        ),
      ),
      (expensesResponse) {
        final newExpenses = expensesResponse.expensesList ?? [];
        final updatedList = List<ExpenseModel>.from(state.expensesList)..addAll(newExpenses);
        
        final hasReachedMax = _checkIfReachedMax(expensesResponse) || newExpenses.isEmpty;

        emit(
          state.copyWith(
            expensesStatus: RequestStatus.success,
            expensesResponse: expensesResponse,
            expensesList: updatedList,
            expenses: updatedList,
            currentPage: nextPage,
            hasReachedMax: hasReachedMax,
          ),
        );
      },
    );
  }

  Future<void> refreshExpenses() async {
    emit(state.copyWith(expensesStatus: RequestStatus.refreshing));

    final result = await expensesRepo.getExpenses(page: 1);
    result.fold(
      (failure) => emit(
        state.copyWith(
          expensesStatus: RequestStatus.error,
          message: failure.message,
        ),
      ),
      (expensesResponse) {
        final hasReachedMax = _checkIfReachedMax(expensesResponse);
        emit(
          state.copyWith(
            expensesStatus: RequestStatus.success,
            expensesResponse: expensesResponse,
            expensesList: expensesResponse.expensesList ?? [],
            expenses: expensesResponse.expensesList,
            currentPage: 1,
            hasReachedMax: hasReachedMax,
          ),
        );
      },
    );
  }

  bool _checkIfReachedMax(ExpensesResponseModel expensesResponse) {
    if (expensesResponse.meta == null) return true;

    final currentPage = expensesResponse.meta!.currentPage ?? 1;
    final lastPage = expensesResponse.meta!.lastPage ?? 1;

    return currentPage >= lastPage;
  }

  // Helper to maintain backward compatibility if needed, though we should migrate calls
  Future<void> getExpenses() async {
    await fetchExpenses();
  }

  Future<void> getExpensesByCurrency({required int id}) async {
    emit(state.copyWith(expensesStatus: RequestStatus.loading));
    final result = await expensesRepo.getExpensesByCurrency(id: id);
    result.fold(
      (failure) => emit(
        state.copyWith(
          expensesStatus: RequestStatus.error,
          message: failure.message,
        ),
      ),
      (amount) => emit(
        state.copyWith(expensesStatus: RequestStatus.success, expensesAmountByCurrency: amount),
      ),
    );
  }
}
