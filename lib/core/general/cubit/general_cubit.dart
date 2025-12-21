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

  Future<void> getUserByPhone({required String phone}) async {
    emit(state.copyWith(getUserByPhoneStatus: RequestStatus.loading));
    final result = await generalRepo.getUserByPhone(phone: phone);
    result.fold(
      (failure) =>
          emit(state.copyWith(getUserByPhoneStatus: RequestStatus.error)),
      (userByPhone) => emit(
        state.copyWith(
          getUserByPhoneStatus: RequestStatus.success,
          userByPhone: userByPhone,
        ),
      ),
    );
  }

  Future<void> getFeeDetails({required FeeDetailsRequestParams params}) async {
    emit(state.copyWith(getFeeDetailsStatus: RequestStatus.loading));
    final result = await generalRepo.getFeeDetails(
      feeDetailsRequestParams: params,
    );
    result.fold(
      (failure) =>
          emit(state.copyWith(getFeeDetailsStatus: RequestStatus.error)),
      (feeDetails) => emit(
        state.copyWith(
          getFeeDetailsStatus: RequestStatus.success,
          feeDetails: feeDetails,
        ),
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

  Future<void> getAllBranches() async {
    emit(state.copyWith(getAllBranchesStatus: RequestStatus.loading));
    final result = await generalRepo.getAllBranches();
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

  Future<void> getPaymentMethods() async {
    emit(state.copyWith(getPaymentMethodsStatus: RequestStatus.loading));
    final result = await generalRepo.getPaymentMethods();
    result.fold(
      (failure) =>
          emit(state.copyWith(getPaymentMethodsStatus: RequestStatus.error)),
      (paymentMethods) => emit(
        state.copyWith(
          getPaymentMethodsStatus: RequestStatus.success,
          paymentMethods: paymentMethods,
        ),
      ),
    );
  }
}
