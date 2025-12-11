import 'package:alalamia/features/expenses/data/repos/expenses_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/enums/request_status.dart';
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
}
