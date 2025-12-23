import 'package:alalamia/features/reports/data/repos/reports_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/enums/reports_enum.dart';
import '../../../../core/enums/request_status.dart';
import 'reports_state.dart';

@injectable
class ReportsCubit extends  Cubit<ReportsState>{
  ReportsCubit({required this.reportsRepo}) : super(const ReportsState());
  final ReportsRepo reportsRepo ;

  Future<void> getReports({required ReportsEnum type}) async {
    emit(state.copyWith(requestStatus: RequestStatus.loading));
    final result = await reportsRepo.getReports(type: type);
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
}