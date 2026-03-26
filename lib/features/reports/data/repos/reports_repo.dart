import 'package:alalamia/features/reports/data/models/reports_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/database/network/failure.dart';
import '../../../../core/enums/reports_enum.dart';

abstract class ReportsRepo {
  Future<Either<Failure, ReportsModel>> getReports({
    required ReportsEnum type,
    String? date,
  });
}
