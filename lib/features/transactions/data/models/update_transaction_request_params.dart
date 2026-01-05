import 'package:alalamia/core/enums/update_transaction_state_enum.dart';

import '../../../transfer_money/data/models/transfer_money_request_params.dart';

class UpdateTransactionRequestParams {
  final UpdateTransactionStatusEnum status;
  final List<DenominationsRequestParams>? denominations;

  UpdateTransactionRequestParams({required this.status, this.denominations});

  Map<String, dynamic> toJson() => {'status': status.name, 'denominations': denominations};
}