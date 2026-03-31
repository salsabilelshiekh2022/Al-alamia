import 'package:alalamia/features/transfer_money/data/repos/transfer_money_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/enums/request_status.dart';
import '../../data/models/transfer_money_request_params.dart';
import 'transfer_money_state.dart';

@injectable
class TransferCurrencyCubit extends Cubit<TransferMoneyState> {
  TransferCurrencyCubit(this.transferMoneyRepo)
    : super(TransferMoneyState.initial());
  final TransferMoneyRepo transferMoneyRepo;

  Future<void> transferMoney({
    required TransferMoneyRequestParams transferMoneyRequestParams,
  }) async {
    await submitTransaction(
      transferMoneyRequestParams: transferMoneyRequestParams,
    );
  }

  Future<void> submitTransaction({
    required TransferMoneyRequestParams transferMoneyRequestParams,
    int? transactionId,
  }) async {
    emit(state.copyWith(transferMoneyState: RequestStatus.loading));
    final result = transactionId == null
        ? await transferMoneyRepo.transferMoney(
            transferMoneyRequestParams: transferMoneyRequestParams,
          )
        : await transferMoneyRepo.updateTransaction(
            transactionId: transactionId,
            transferMoneyRequestParams: transferMoneyRequestParams,
          );

    result.fold(
      (failure) => emit(
        state.copyWith(
          transferMoneyState: RequestStatus.error,
          message: failure.message,
        ),
      ),
      (message) => emit(
        state.copyWith(
          transferMoneyState: RequestStatus.success,
          message: message,
        ),
      ),
    );
  }
}
