import 'package:alalamia/core/enums/request_status.dart';
import 'package:alalamia/core/general/data/models/fee_details_model.dart';
import 'package:alalamia/core/general/data/models/user_by_phone_model.dart';
import 'package:equatable/equatable.dart';

class GeneralState extends Equatable {
  final RequestStatus getUserByPhoneStatus;
  final RequestStatus getFeeDetailsStatus;
  final UserByPhoneModel? userByPhone;
  final FeeDetailsModel? feeDetails;

  static GeneralState initial() {
    return const GeneralState();
  }

  const GeneralState({
    this.getUserByPhoneStatus = RequestStatus.initial,
    this.getFeeDetailsStatus = RequestStatus.initial,
    this.userByPhone,
    this.feeDetails,
  });

  GeneralState copyWith({
    RequestStatus? getUserByPhoneStatus,
    RequestStatus? getFeeDetailsStatus,
    UserByPhoneModel? userByPhone,
    FeeDetailsModel? feeDetails,
  }) {
    return GeneralState(
      getUserByPhoneStatus: getUserByPhoneStatus ?? this.getUserByPhoneStatus,
      getFeeDetailsStatus: getFeeDetailsStatus ?? this.getFeeDetailsStatus,
      userByPhone: userByPhone ?? this.userByPhone,
      feeDetails: feeDetails ?? this.feeDetails,
    );
  }

  @override
  List<Object?> get props => [
    getUserByPhoneStatus,
    userByPhone,
    getFeeDetailsStatus,
    feeDetails,
  ];
}
