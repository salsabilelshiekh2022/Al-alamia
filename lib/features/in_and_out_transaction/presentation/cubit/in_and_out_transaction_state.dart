import 'package:alalamia/core/enums/request_status.dart';
import 'package:equatable/equatable.dart';

class InAndOutTransactionState  extends Equatable {
  final RequestStatus inAndOutTransactionStatus;
  final String? message;
  const InAndOutTransactionState({this.inAndOutTransactionStatus = RequestStatus.initial, this.message});

  InAndOutTransactionState copyWith({RequestStatus? inAndOutTransactionStatus, String? message}) {
    return InAndOutTransactionState(
      inAndOutTransactionStatus: inAndOutTransactionStatus ?? this.inAndOutTransactionStatus,
      message: message ?? this.message,
    );
  }


  @override
  List<Object?> get props => [inAndOutTransactionStatus, message];

}