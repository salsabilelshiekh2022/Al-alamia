import 'package:alalamia/core/database/network/api_consumer.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/database/network/end_points.dart';
import '../../../../core/database/network/failure.dart';
import '../../../../core/enums/reports_enum.dart';
import '../models/reports_model.dart';
import 'reports_repo.dart';

@LazySingleton(as: ReportsRepo)
class ReportsRepoImpl implements ReportsRepo {
  final ApiConsumer apiConsumer;
  ReportsRepoImpl({required this.apiConsumer});
  @override
  Future<Either<Failure, ReportsModel>> getReports({required ReportsEnum type}) {
     return apiConsumer.handleRequest(
      request: () => apiConsumer.post(
        path: EndPoints.getReports(type: type),
      
      ),
      onSuccess: (result) {
        return ReportsModel.fromJson(result['data']);
      },
    );
  }
}