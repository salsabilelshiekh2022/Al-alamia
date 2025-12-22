import 'package:dartz/dartz.dart';

import '../../../../core/database/network/failure.dart';
import '../models/in_and_out_request_params.dart';

abstract class InAndOutRepo {
  Future<Either<Failure, String>> inAndOutTransaction({
    required InAndOutRequestParams params,
  });
}