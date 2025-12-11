import 'package:alalamia/features/debts/data/models/add_debt_request_params.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/database/network/failure.dart';

abstract class DebtRepo {
  Future<Either<Failure, String>> addDebt({
    required AddDebtRequestParams addDebtRequestParams,
  });
}
