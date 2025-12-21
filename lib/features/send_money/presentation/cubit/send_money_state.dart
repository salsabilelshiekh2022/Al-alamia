import 'package:alalamia/core/enums/delivery_type_enum.dart';
import 'package:alalamia/features/send_money/data/models/send_money_request_params.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/enums/request_status.dart';
import '../../data/models/send_money_form_data.dart';

class SendMoneyState extends Equatable {
   final RequestStatus sendMoneyStatus;
   final String? message;
    final SendMoneyFormData? formData;
   final SendMoneyRequestParams? sendMoneyRequestParams;
    final ValidationResult? validationResult;
     final DeliveryTypeEnum deliveryType;
   const SendMoneyState({ this.sendMoneyStatus = RequestStatus.initial, this.message, this.sendMoneyRequestParams ,  this.formData, this.validationResult,  this.deliveryType  = DeliveryTypeEnum.internalDelivery});
  static SendMoneyState initial() => SendMoneyState(
        sendMoneyStatus: RequestStatus.initial,
        formData: SendMoneyFormData.empty(),
      
      );


  SendMoneyState copyWith({
    RequestStatus? sendMoneyStatus,
    String? message,
    SendMoneyFormData? formData,
    SendMoneyRequestParams? sendMoneyRequestParams,
    ValidationResult? validationResult,
    DeliveryTypeEnum? deliveryType
  }) {
    return SendMoneyState(
      sendMoneyStatus: sendMoneyStatus ?? this.sendMoneyStatus,
      message: message ?? this.message,
      formData: formData ?? this.formData,
      sendMoneyRequestParams: sendMoneyRequestParams ?? this.sendMoneyRequestParams,
      validationResult: validationResult ?? this.validationResult
      ,deliveryType: deliveryType ?? this.deliveryType
    );
  }


  @override
 
  List<Object?> get props => [sendMoneyStatus, message, sendMoneyRequestParams, formData, validationResult, deliveryType];
}

class ValidationResult {
  final bool isValid;
  final List<String> errors;

  const ValidationResult({
    required this.isValid,
    required this.errors,
  });

  String? get firstError => errors.isNotEmpty ? errors.first : null;
}