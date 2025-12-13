import 'package:alalamia/core/enums/request_status.dart';
import 'package:equatable/equatable.dart';

class TransferMoneyState extends Equatable {
  final RequestStatus transferMoneyState;
  final String? message;

  static TransferMoneyState initial() =>
      TransferMoneyState(transferMoneyState: RequestStatus.initial);

  const TransferMoneyState({
    this.transferMoneyState = RequestStatus.initial,
    this.message,
  });

  TransferMoneyState copyWith({
    RequestStatus? transferMoneyState,
    String? message,
  }) {
    return TransferMoneyState(
      transferMoneyState: transferMoneyState ?? this.transferMoneyState,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [transferMoneyState, message];
}
