import 'package:alalamia/features/reports/data/repos/reports_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/enums/reports_enum.dart';
import '../../../../core/enums/request_status.dart';
import 'reports_state.dart';

@injectable
class ReportsCubit extends Cubit<ReportsState> {
  ReportsCubit({required this.reportsRepo}) : super(const ReportsState());
  final ReportsRepo reportsRepo;

  Future<void> getReports({required ReportsEnum type, DateTime? date}) async {
    // Format date as yyyy-M-d if provided
    String? formattedDate;
    if (date != null) {
      formattedDate = '${date.year}-${date.month}-${date.day}';
    }

    // Avoid duplicate API calls if the same date and type are selected
    if (state.reportsType == type &&
        state.selectedDate == date &&
        state.requestStatus == RequestStatus.success) {
      return;
    }

    emit(
      state.copyWith(
        requestStatus: RequestStatus.loading,
        reportsType: type,
        selectedDate: date,
      ),
    );

    final result = await reportsRepo.getReports(
      type: type,
      date: formattedDate,
    );

    result.fold(
      (failure) => emit(
        state.copyWith(
          requestStatus: RequestStatus.error,
          message: failure.message,
        ),
      ),
      (reports) => emit(
        state.copyWith(
          requestStatus: RequestStatus.success,
          reportsModel: reports,
        ),
      ),
    );
  }

  void updateSelectedDate(DateTime? date) {
    if (state.reportsType != null) {
      getReports(type: state.reportsType!, date: date);
    }
  }

  void clearDate() {
    if (state.reportsType != null) {
      getReports(type: state.reportsType!, date: null);
    }
  }
}
