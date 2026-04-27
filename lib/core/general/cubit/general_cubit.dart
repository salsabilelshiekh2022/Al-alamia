import 'package:alalamia/core/general/data/repos/general_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../enums/request_status.dart';
import '../data/models/fee_details_request_params.dart';
import 'general_state.dart';

@injectable
class GeneralCubit extends Cubit<GeneralState> {
  GeneralCubit({required this.generalRepo}) : super(GeneralState.initial());
  final GeneralRepo generalRepo;
  int _latestFeeDetailsRequestId = 0;

  Future<void> getUserByPhone({
    required String phone,
    String? requestSource,
  }) async {
    emit(
      state.copyWith(
        getUserByPhoneStatus: RequestStatus.loading,
        userByPhoneRequestSource: requestSource,
      ),
    );
    final result = await generalRepo.getUserByPhone(phone: phone);
    result.fold(
      (failure) => emit(
        state.copyWith(
          getUserByPhoneStatus: RequestStatus.error,
          userByPhoneRequestSource: requestSource,
        ),
      ),
      (userByPhone) => emit(
        state.copyWith(
          getUserByPhoneStatus: RequestStatus.success,
          userByPhone: userByPhone,
          userByPhoneRequestSource: requestSource,
        ),
      ),
    );
  }

  Future<void> getFeeDetails({required FeeDetailsRequestParams params}) async {
    final requestId = ++_latestFeeDetailsRequestId;
    emit(state.copyWith(getFeeDetailsStatus: RequestStatus.loading));
    final result = await generalRepo.getFeeDetails(
      feeDetailsRequestParams: params,
    );

    // Ignore stale responses when a newer fee-details request exists.
    if (requestId != _latestFeeDetailsRequestId) {
      return;
    }

    result.fold(
      (failure) => emit(
        state.copyWith(
          getFeeDetailsStatus: RequestStatus.error,
          clearFeeDetails: true,
        ),
      ),
      (feeDetails) => emit(
        state.copyWith(
          getFeeDetailsStatus: RequestStatus.success,
          feeDetails: feeDetails,
        ),
      ),
    );
  }

  void clearFeeDetails() {
    _latestFeeDetailsRequestId++;
    emit(
      state.copyWith(
        getFeeDetailsStatus: RequestStatus.initial,
        clearFeeDetails: true,
      ),
    );
  }

  Future<void> getAllDenominations() async {
    emit(state.copyWith(getAllDenominationsStatus: RequestStatus.loading));
    final result = await generalRepo.getAllDenominations();
    result.fold(
      (failure) =>
          emit(state.copyWith(getAllDenominationsStatus: RequestStatus.error)),
      (denominations) => emit(
        state.copyWith(
          getAllDenominationsStatus: RequestStatus.success,
          denominations: denominations,
        ),
      ),
    );
  }

  Future<void> getAllBranches({Map<String, dynamic>? queryParameters}) async {
    emit(state.copyWith(getAllBranchesStatus: RequestStatus.loading));
    final result = await generalRepo.getAllBranches(
      queryParameters: queryParameters,
    );
    result.fold(
      (failure) =>
          emit(state.copyWith(getAllBranchesStatus: RequestStatus.error)),
      (branches) => emit(
        state.copyWith(
          getAllBranchesStatus: RequestStatus.success,
          branches: branches,
        ),
      ),
    );
  }

  Future<void> getPaymentMethods({required int branchId}) async {
    emit(state.copyWith(getPaymentMethodsStatus: RequestStatus.loading));
    final result = await generalRepo.getPaymentMethods(branchId: branchId);
    result.fold(
      (failure) =>
          emit(state.copyWith(getPaymentMethodsStatus: RequestStatus.error)),
      (paymentMethods) => emit(
        state.copyWith(
          getPaymentMethodsStatus: RequestStatus.success,
          paymentMethods: paymentMethods,
          selectedBranchId: branchId,
        ),
      ),
    );
  }

  void clearPaymentMethods() {
    emit(
      state.copyWith(
        paymentMethods: [],
        getPaymentMethodsStatus: RequestStatus.initial,
        selectedBranchId: null,
      ),
    );
  }

  Future<void> getExpensesTypes() async {
    emit(state.copyWith(getAllBranchesStatus: RequestStatus.loading));
    final result = await generalRepo.getExpensesTypes();
    result.fold(
      (failure) =>
          emit(state.copyWith(getAllBranchesStatus: RequestStatus.error)),
      (expensesTypes) => emit(
        state.copyWith(
          getAllBranchesStatus: RequestStatus.success,
          expensesTypes: expensesTypes,
        ),
      ),
    );
  }
}
