import 'package:alalamia/features/send_money/data/models/send_money_request_params.dart';
import 'package:alalamia/features/send_money/data/repos/send_money_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/enums/delivery_type_enum.dart';
import '../../../../core/enums/request_status.dart';
import '../../data/models/send_money_form_data.dart';
import 'send_money_state.dart';

@injectable
class SendMoneyCubit extends Cubit<SendMoneyState> {
  SendMoneyCubit({required this.sendMoneyRepo}) : super(SendMoneyState.initial());
  final SendMoneyRepo sendMoneyRepo;

  /// Change delivery type and sync with form data
  void changeDeliveryType(DeliveryTypeEnum deliveryType) {
    final updatedFormData = state.formData?.copyWith(deliveryType: deliveryType);
    emit(state.copyWith(
      deliveryType: deliveryType,
      formData: updatedFormData,
    ));
  }

  /// Update form data
  void updateFormData(SendMoneyFormData formData) {
    emit(state.copyWith(formData: formData));
  }

  /// Send money request
  Future<void> sendMoney({
    required SendMoneyRequestParams sendMoneyRequestParams,
  }) async {
    emit(state.copyWith(sendMoneyStatus: RequestStatus.loading));
    final result = await sendMoneyRepo.sendMoney(
      params: sendMoneyRequestParams,
    );
    result.fold(
      (failure) => emit(
        state.copyWith(
          sendMoneyStatus: RequestStatus.error,
          message: failure.message,
        ),
      ),
      (message) => emit(
        state.copyWith(
          sendMoneyStatus: RequestStatus.success,
          message: message,
        ),
      ),
    );
  }
}