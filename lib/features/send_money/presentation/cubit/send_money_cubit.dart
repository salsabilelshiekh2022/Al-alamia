import 'package:alalamia/features/send_money/data/models/send_money_request_params.dart';
import 'package:alalamia/features/send_money/data/repos/send_money_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/enums/delivery_type_enum.dart';
import '../../../../core/enums/request_status.dart';
import 'send_money_state.dart';
@injectable
class SendMoneyCubit extends Cubit<SendMoneyState> {
  SendMoneyCubit({ required this.sendMoneyRepo}) : super(SendMoneyState());
  final SendMoneyRepo sendMoneyRepo;

  changeDeliveryType(DeliveryTypeEnum deliveryType) => emit(state.copyWith(deliveryType: deliveryType));

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