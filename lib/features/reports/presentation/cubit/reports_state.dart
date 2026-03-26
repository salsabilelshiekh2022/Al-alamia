import 'package:alalamia/core/enums/request_status.dart';
import 'package:alalamia/features/reports/data/models/reports_model.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/enums/reports_enum.dart';

class ReportsState extends Equatable {
  final String? message;
  final bool isLoading;
  final ReportsEnum? reportsType;
  final RequestStatus requestStatus;
  final ReportsModel? reportsModel;
  final DateTime? selectedDate;

  const ReportsState({
    this.message,
    this.isLoading = false,
    this.reportsType,
    this.requestStatus = RequestStatus.initial,
    this.reportsModel,
    this.selectedDate,
  });

  ReportsState copyWith({
    String? message,
    bool? isLoading,
    ReportsEnum? reportsType,
    RequestStatus? requestStatus,
    ReportsModel? reportsModel,
    DateTime? selectedDate,
  }) {
    return ReportsState(
      message: message ?? this.message,
      isLoading: isLoading ?? this.isLoading,
      reportsType: reportsType ?? this.reportsType,
      requestStatus: requestStatus ?? this.requestStatus,
      reportsModel: reportsModel ?? this.reportsModel,
      selectedDate: selectedDate ?? this.selectedDate,
    );
  }

  @override
  List<Object?> get props => [
    message,
    isLoading,
    reportsType,
    requestStatus,
    reportsModel,
    selectedDate,
  ];
}
