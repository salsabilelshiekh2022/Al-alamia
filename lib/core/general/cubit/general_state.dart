import 'package:alalamia/core/enums/request_status.dart';
import 'package:alalamia/core/general/data/models/branch_model.dart';
import 'package:alalamia/core/general/data/models/denomination_model.dart';
import 'package:alalamia/core/general/data/models/fee_details_model.dart';
import 'package:alalamia/core/general/data/models/user_by_phone_model.dart';
import 'package:equatable/equatable.dart';

import '../data/models/payment_method_model.dart';

class GeneralState extends Equatable {
  final RequestStatus getUserByPhoneStatus;
  final RequestStatus getFeeDetailsStatus;
  final RequestStatus getAllDenominationsStatus;
  final RequestStatus getAllBranchesStatus;
  final RequestStatus getPaymentMethodsStatus;
  final UserByPhoneModel? userByPhone;
  final FeeDetailsModel? feeDetails;
  final List<DenominationModel?>? denominations;
  final List<BranchModel?>? branches;
  final List<PaymentMethodModel?>? paymentMethods;

  static GeneralState initial() {
    return const GeneralState();
  }

  const GeneralState({
    this.getUserByPhoneStatus = RequestStatus.initial,
    this.getFeeDetailsStatus = RequestStatus.initial,
    this.getAllDenominationsStatus = RequestStatus.initial,
    this.getAllBranchesStatus = RequestStatus.initial,
    this.getPaymentMethodsStatus = RequestStatus.initial,
    this.userByPhone,
    this.feeDetails,
    this.denominations,
    this.branches,
    this.paymentMethods,
  });

  GeneralState copyWith({
    RequestStatus? getUserByPhoneStatus,
    RequestStatus? getFeeDetailsStatus,
    RequestStatus? getAllDenominationsStatus,
    RequestStatus? getAllBranchesStatus,
    RequestStatus? getPaymentMethodsStatus,
    UserByPhoneModel? userByPhone,
    FeeDetailsModel? feeDetails,
    List<DenominationModel?>? denominations,
    List<BranchModel?>? branches,
    List<PaymentMethodModel?>? paymentMethods,
  }) {
    return GeneralState(
      getUserByPhoneStatus: getUserByPhoneStatus ?? this.getUserByPhoneStatus,
      getFeeDetailsStatus: getFeeDetailsStatus ?? this.getFeeDetailsStatus,
      getAllBranchesStatus: getAllBranchesStatus ?? this.getAllBranchesStatus,
      getPaymentMethodsStatus:
          getPaymentMethodsStatus ?? this.getPaymentMethodsStatus,
      getAllDenominationsStatus:
          getAllDenominationsStatus ?? this.getAllDenominationsStatus,
      userByPhone: userByPhone ?? this.userByPhone,
      feeDetails: feeDetails ?? this.feeDetails,
      denominations: denominations ?? this.denominations,
      branches: branches ?? this.branches,
      paymentMethods: paymentMethods ?? this.paymentMethods,
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
    getAllBranchesStatus,
    branches,
    getPaymentMethodsStatus,
    paymentMethods
  ];
}
