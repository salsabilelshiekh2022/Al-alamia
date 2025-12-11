import 'package:alalamia/core/enums/request_status.dart';
import 'package:equatable/equatable.dart';

class DebtsState extends Equatable {
  final RequestStatus debtsStatus;
  final String? message;

  const DebtsState({this.debtsStatus = RequestStatus.initial, this.message});

  DebtsState copyWith({RequestStatus? debtsStatus, String? message}) {
    return DebtsState(
      debtsStatus: debtsStatus ?? this.debtsStatus,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [debtsStatus, message];
}
