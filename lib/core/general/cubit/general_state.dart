import 'package:alalamia/core/enums/request_status.dart';
import 'package:alalamia/core/general/data/models/user_by_phone_model.dart';
import 'package:equatable/equatable.dart';

class GeneralState extends Equatable {
  final RequestStatus getUserByPhoneStatus;
  final UserByPhoneModel? userByPhone;

  static GeneralState initial() {
    return const GeneralState();
  }

  const GeneralState({
    this.getUserByPhoneStatus = RequestStatus.initial,
    this.userByPhone,
  });

  GeneralState copyWith({
    RequestStatus? getUserByPhoneStatus,
    UserByPhoneModel? userByPhone,
  }) {
    return GeneralState(
      getUserByPhoneStatus: getUserByPhoneStatus ?? this.getUserByPhoneStatus,
      userByPhone: userByPhone ?? this.userByPhone,
    );
  }

  @override
  List<Object?> get props => [getUserByPhoneStatus, userByPhone];
}
