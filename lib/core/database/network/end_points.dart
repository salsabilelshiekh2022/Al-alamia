import '../../utils/app_config.dart';

class EndPoints {
  static String baseUrl = ApiConfig.baseUrl;
  static String homeBanners = '/users/banners';
  static String homeServices = "/users/services";
  static String notifications = "/users/notifications";
  static String createNewTicket = '/users/tickets';
  static String getTickets = '/users/tickets';
  static addMessageForTicket({required int id}) => '/users/tickets/$id';
  static String showATicket({required int id}) => '/users/tickets/$id';
  static String getServiceDetails({required int id}) => '/users/services/$id';
  static const String sendOtp = "/users/auth/login-register";
  static const String verifyOtp = "/users/auth/verify-otp";
  static const String logout = "/users/auth/logout";
  static const String bookAService = "/users/visits/new";
  static const String visits = "/users/visits/my-visits";
  static const String reports = "/users/visits/my-reports";
  static const String getCarTypes = "/users/car-types";
  static String getCarModels({required int id}) => "/users/car-types/$id";
  static const String getTimeAvalability = "/users/visits/times-availability";
  static const String editProfile = "/users/auth/update";
  static String rateVisit({required int id}) => "/users/rate/$id";
  static const String checkPhone = "/users/auth/check-phone";
  static const String getSocialMediaLinks = "/users/home/social";
  static const String workingTimes = "/users/home/working-times";
}
