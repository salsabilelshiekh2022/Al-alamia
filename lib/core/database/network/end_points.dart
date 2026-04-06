import 'package:alalamia/core/enums/transactions_enum.dart';

import '../../enums/reports_enum.dart';
import '../../utils/app_config.dart';

class EndPoints {
  static String baseUrl = ApiConfig.baseUrl;

  static String login = '/employee/auth/login';
  static String getBranchCurrencies = '/employee/home/get-branch-currencies';
  static String getDenominations({required int id}) =>
      '/employee/home/currency/$id/get-denominations';

  static String getCurrencies = '/employee/general/get-all-currencies';
  static String addExpenses = '/employee/transactions/expenses';
  static String addDebt = '/employee/transactions/add-debt';
  static String payDebt = '/employee/transactions/pay-debt';
  static String transferCurrency = '/employee/home/transfer-currency';
  static String getUserByPhone({required String phone}) =>
      '/employee/transactions/get-user-by-phone?phone=$phone';
  static String getFeeDetails = '/employee/transactions/get-fee-details';
  static String getAllDenominations = '/employee/general/get-all-denominations';
  static String transferMoney = '/employee/transactions/transfering-money';
  static String getExpenses = '/employee/transactions/expenses';
  static String getExpensesByCurrency({required int id}) =>
      '/employee/general/currencies/$id/expenses';
  static String getDebtsByCurrency({required int id}) =>
      '/employee/general/currencies/$id/debts';
  static String getDebtsTransactions({required String type}) =>
      '/employee/transactions/debts?type=$type';
  static String getAllBranches = '/employee/general/get-all-branches';
  static String getPaymentMethods({required int branchId}) =>
      '/employee/general/get-all-payment-methods?branch_id=$branchId';
  static String sendMoney = '/employee/transactions/sending-money';
  static String inAndOutTransaction = '/employee/transactions/add-in-out';

  static String getNotifications = '/employee/notifications';
  static String getTransactionList({required TransactionsEnum transaction}) =>
      '/employee/transactions?type=${transaction.name}';
  static String showTransactionDetails({required String transactionId}) =>
      '/employee/transactions/$transactionId/client-transaction';
  static String getReports({required ReportsEnum type, String? date}) {
    final baseUrl = '/employee/reports?type=${type.name}';
    return date != null ? '$baseUrl&date=$date' : baseUrl;
  }

  static String sendMessage = '/employee/ticket-messages';
  static String getMessages = '/employee/ticket-messages';
  static String changePassword = '/employee/auth/change-password';
  static String updateTransactionStatus({required int transactionId}) =>
      '/employee/transactions/$transactionId/update-status';
  static String cancelTransaction({required int transactionId}) =>
      '/employee/transactions/$transactionId/cancel';
  static String payBackTransaction({required String transactionId}) =>
      '/employee/transactions/$transactionId/pay-back-money';
  static String updateTransaction({required int transactionId}) =>
      '/employee/transactions/$transactionId/update';
  static String sendOtp = '/employee/auth/send-code';
  static String verifyOtp = '/employee/auth/verify-code';
  static String resetPassword = '/employee/auth/reset-password';
  static String toggleNotifications = '/employee/auth/toggle-notifications';
  static String getAllExpensesTypes = "/employee/general/get-all-expenses";
}
