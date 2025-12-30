import 'package:alalamia/features/support/data/models/massage_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/database/network/failure.dart';

abstract class SupportRepo {
  Future<Either<Failure, String>> sendMessage({required String message});

  Future<Either<Failure, List<MessageModel>>> gettMessages();
}
