import '../../utils/app_config.dart';

class EndPoints {
  static String baseUrl = ApiConfig.baseUrl;

  static String login = '/employee/auth/login';
  static String getBranchCurrencies = '/employee/home/get-branch-currencies';
  static String getDenominations({required int id}) =>
      '/employee/home/currency/$id/get-denominations';
}
