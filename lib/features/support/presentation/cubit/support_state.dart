import 'package:alalamia/features/support/data/models/massage_model.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/enums/request_status.dart';

class SupportState extends Equatable {
  final RequestStatus requestStatus;
  final List<MessageModel> messages;
  final String? message;

 const SupportState({
    this.message,
    this.requestStatus = RequestStatus.initial,
    this.messages = const [],
  });



  SupportState copyWith({
    RequestStatus? requestStatus,
    List<MessageModel>? messages, 
    String? message,
  }) {
    return SupportState(
      requestStatus: requestStatus ?? this.requestStatus,
      messages: messages ?? this.messages,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [
    requestStatus,
    messages,
    message,
  ];
}