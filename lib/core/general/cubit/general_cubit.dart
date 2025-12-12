import 'package:alalamia/core/general/data/repos/general_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../enums/request_status.dart';
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
}
