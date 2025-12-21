import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/enums/delivery_type_enum.dart';
import 'send_money_state.dart';
@injectable
class SendMoneyCubit extends Cubit<SendMoneyState> {
  SendMoneyCubit() : super(SendMoneyState());

  changeDeliveryType(DeliveryTypeEnum deliveryType) => emit(state.copyWith(deliveryType: deliveryType));


}