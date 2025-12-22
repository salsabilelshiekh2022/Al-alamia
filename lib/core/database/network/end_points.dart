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
  static  String getExpenses = '/employee/transactions/expenses';
  static String getExpensesByCurrency({required int id}) => '/employee/general/currencies/$id/expenses';
  static String getDebtsByCurrency({required int id}) => '/employee/general/currencies/$id/debts';
  static String getDebtsTransactions ({required String type}) => '/employee/transactions/debts?type=$type';
  static String getAllBranches = '/employee/general/get-all-branches';
  static String getPaymentMethods = '/employee/general/get-all-payment-methods';
  static String sendMoney = '/employee/transactions/sending-money';
  static String inAndOutTransaction = '/employee/transactions/add-in-out';
}
