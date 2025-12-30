import 'package:alalamia/features/support/data/repos/support_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/enums/request_status.dart';
import '../../data/models/massage_model.dart';
import 'support_state.dart';
@injectable
class SupportCubit extends Cubit<SupportState> {
  SupportCubit(this.supportRepo) : super(SupportState());
  final SupportRepo supportRepo;

  Future<void> getMessages() async {
    emit(state.copyWith(requestStatus: RequestStatus.loading));
    final result = await supportRepo.gettMessages();
    result.fold(
      (failure) => emit(
        state.copyWith(
          requestStatus: RequestStatus.error,
          message: failure.message,
        ),
      ),
      (messages) => emit(
        state.copyWith(
          requestStatus: RequestStatus.success,
          messages: messages,
        ),
      ),
    );
  }

  Future<void> sendMessage({required String message}) async {
    MessageModel messageModel = MessageModel(message: message, senderType: 'me', sender:
     'me', createdAt: DateTime.now().toString(), id: -1);
    emit(state.copyWith(requestStatus: RequestStatus.loading , messages: [...state.messages, messageModel]));
    final result = await supportRepo.sendMessage(message: message);
    result.fold(
      (failure) => emit(
        state.copyWith(
          requestStatus: RequestStatus.error,
          message: failure.message,
        ),
      ),
      (successMessage) => emit(
        state.copyWith(
          requestStatus: RequestStatus.success,
          message: successMessage,
        ),
      ),
    );
  }

}