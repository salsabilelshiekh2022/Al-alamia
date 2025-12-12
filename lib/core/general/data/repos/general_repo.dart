import 'package:dartz/dartz.dart';

import '../../../database/network/failure.dart';
import '../models/user_by_phone_model.dart';

abstract class GeneralRepo {
  Future<Either<Failure, UserByPhoneModel>> getUserByPhone({
    required String phone,
  });
}
