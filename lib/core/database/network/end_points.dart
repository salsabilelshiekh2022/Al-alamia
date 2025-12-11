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
}
