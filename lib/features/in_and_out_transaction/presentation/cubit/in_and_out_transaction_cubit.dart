import 'package:alalamia/features/in_and_out_transaction/data/repos/in_and_out_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/enums/request_status.dart';
import '../../data/models/in_and_out_request_params.dart';
import 'in_and_out_transaction_state.dart';

@injectable
class InAndOutTransactionCubit extends Cubit<InAndOutTransactionState> {

  InAndOutTransactionCubit({required this.inAndOutRepo}) : super(const InAndOutTransactionState());

  final InAndOutRepo inAndOutRepo;

  Future<void> inAndOutTransaction({required InAndOutRequestParams params}) async {
    emit(state.copyWith(inAndOutTransactionStatus: RequestStatus.loading));
    final result = await inAndOutRepo.inAndOutTransaction(params: params);
    result.fold(
      (failure) => emit(state.copyWith(inAndOutTransactionStatus: RequestStatus.error, message: failure.message)),
      (message) => emit(state.copyWith(inAndOutTransactionStatus: RequestStatus.success, message: message)),
    );
  }
}