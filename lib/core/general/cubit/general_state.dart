import 'package:alalamia/core/enums/request_status.dart';
import 'package:alalamia/core/general/data/models/denomination_model.dart';
import 'package:alalamia/core/general/data/models/fee_details_model.dart';
import 'package:alalamia/core/general/data/models/user_by_phone_model.dart';
import 'package:equatable/equatable.dart';

class GeneralState extends Equatable {
  final RequestStatus getUserByPhoneStatus;
  final RequestStatus getFeeDetailsStatus;
  final RequestStatus getAllDenominationsStatus;
  final UserByPhoneModel? userByPhone;
  final FeeDetailsModel? feeDetails;
  final List<DenominationModel?>? denominations;

  static GeneralState initial() {
    return const GeneralState();
  }

  const GeneralState({
    this.getUserByPhoneStatus = RequestStatus.initial,
    this.getFeeDetailsStatus = RequestStatus.initial,
    this.getAllDenominationsStatus = RequestStatus.initial,
    this.userByPhone,
    this.feeDetails,
    this.denominations,
  });

  GeneralState copyWith({
    RequestStatus? getUserByPhoneStatus,
    RequestStatus? getFeeDetailsStatus,
    RequestStatus? getAllDenominationsStatus,
    UserByPhoneModel? userByPhone,
    FeeDetailsModel? feeDetails,
    List<DenominationModel?>? denominations,
  }) {
    return GeneralState(
      getUserByPhoneStatus: getUserByPhoneStatus ?? this.getUserByPhoneStatus,
      getFeeDetailsStatus: getFeeDetailsStatus ?? this.getFeeDetailsStatus,
      getAllDenominationsStatus:
          getAllDenominationsStatus ?? this.getAllDenominationsStatus,
      userByPhone: userByPhone ?? this.userByPhone,
      feeDetails: feeDetails ?? this.feeDetails,
      denominations: denominations ?? this.denominations,
    );
  }

  @override
  List<Object?> get props => [
    getUserByPhoneStatus,
    userByPhone,
    getFeeDetailsStatus,
    feeDetails,
    getAllDenominationsStatus,
    denominations,
  ];
}
