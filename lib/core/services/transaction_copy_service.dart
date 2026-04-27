import 'package:alalamia/core/enums/delivery_type_enum.dart';
import 'package:alalamia/features/send_money/data/models/send_money_form_data.dart';
import 'package:alalamia/features/transactions/data/models/transaction_details_model.dart';
import 'package:alalamia/features/transfer_money/data/models/transfer_money_data_params.dart';

/// Service for copying transaction data and mapping to form data models
class TransactionCopyService {
  /// Map transaction details to TransferMoneyDataParams for transfering type
  static TransferMoneyDataParams? mapToTransferMoneyData(
    TransactionDetailsModel transaction, {
    int? transactionId,
    bool preserveNote = false,
  }) {
    try {
      return TransferMoneyDataParams(
        clientPhone: transaction.receiver?.phone ?? '',
        clientName: transaction.receiver?.name ?? '',
        whatsappNumber: transaction.receiver?.whatsappNumber ?? '',
        // Currency IDs will be set from the currencies list in the UI based on names
        fromCurrencyId: 0, // Will be matched by currency name
        toCurrencyId: 0, // Will be matched by currency name
        amount: transaction.amountSent ?? "0",
        totalPrice: transaction.amountReceived ?? "0",
        amountByChar: transaction.details?.amountCharacter ?? '',
        note: preserveNote
            ? transaction.notes ?? ''
            : '', // Notes are not copied in copy mode to allow fresh notes
        sendingMessageType: null, // User will select new message type
        transactionId: transactionId,
      );
    } catch (e) {
      print('Error mapping to transfer money data: $e');
      return null;
    }
  }

  /// Map transaction details to SendMoneyFormData for sending type
  static SendMoneyFormData? mapToSendMoneyFormData(
    TransactionDetailsModel transaction, {
    int? transactionId,
    bool preserveNote = false,
  }) {
    try {
      return SendMoneyFormData(
        // Sender Info - Keep original sender info
        senderPhone: transaction.sender?.phone ?? '',
        senderWhatsApp: transaction.sender?.whatsappNumber ?? '',
        senderName: transaction.sender?.name ?? '',
        senderAddress: transaction.sender?.address,

        // Receiver Info
        receiverPhone: transaction.receiver?.phone ?? '',
        receiverWhatsApp: transaction.receiver?.whatsappNumber ?? '',
        receiverName: transaction.receiver?.name ?? '',
        receiverAddress: transaction.receiver?.address,
        receiverPhone2: transaction.receiver?.phone_2,

        // Transaction Details
        amount: transaction.amount ?? "0",
        totalPrice: transaction.amountReceived ?? "0",
        amountByChar: transaction.details?.amountCharacter ?? '',
        note: preserveNote ? transaction.notes ?? '' : '',

        // Commission & Payment
        commissionType: transaction.details?.commissionType,
        paymentMethodId: transaction.paymentMethod?.id,

        // Delivery Type
        deliveryType: transaction.recieveType ?? DeliveryTypeEnum.inside,

        // Note: The following fields need to be set from UI/state after loading:
        // - fromCurrency, toCurrency (will be matched from currencies list by name)
        // - fromBranch, toBranch (will be matched from branches list by ID)
        // - paymentMethodId (if external delivery, will be selected fresh)
        // - denominations (will be entered fresh)
        // - sendingMessageType (user will select new)

        // These are intentionally left as defaults and will be set by UI:
        fromCurrency: null, // To be matched by currency name
        toCurrency: null, // To be matched by currency name
        fromBranch: transaction.fromBranch?.id ?? 0, // Branch ID for matching
        toBranch: transaction.toBranch?.id ?? 0 , // Branch ID for matching
        transactionId: transactionId,
      );
    } catch (e) {
      print('Error mapping to send money form data: $e');
      return null;
    }
  }

  /// Get the currency name from transaction for matching
  static String getFromCurrencyName(TransactionDetailsModel transaction) {
    return transaction.currency ?? '';
  }

  /// Get the to currency name from transaction for matching
  static String getToCurrencyName(TransactionDetailsModel transaction) {
    return transaction.toCurrency ?? '';
  }

  /// Get the from branch ID
  static int getFromBranchId(TransactionDetailsModel transaction) {
    return transaction.fromBranch?.id ?? 0;
  }

  /// Get the to branch ID
  static int getToBranchId(TransactionDetailsModel transaction) {
    return transaction.toBranch?.id ?? 0;
  }

  /// Determine the transaction type for navigation
  static String getTransactionType(TransactionDetailsModel transaction) {
    return transaction.details?.transactionType ?? '';
  }

  /// Determine if it's external delivery
  static bool isExternalDelivery(TransactionDetailsModel transaction) {
    return transaction.recieveType == DeliveryTypeEnum.outside;
  }
}
