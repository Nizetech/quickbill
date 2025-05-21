class ApiRoute {
  // static String baseUrl = 'https://api.paypointapp.africa/api/';
  static String baseUrl = 'https://project.jostpay.com/apis/';

  //Auth
  static String signup = 'signup';
  static String login = 'login';
  static String resendOtp = 'get-email-code';
  static String verifyOtp = 'verify-email';
  static String verify2fa = 'verify-2fa';
  static String changePassword = 'change-password';

  // Dashboard
  static String userProfile = 'get-user-profile';
  static String updateProfile = 'update-profile';
  static String getBalance = 'get-balance';
  static String getTransactions = 'get-purchases';
  static String getNotification = 'get-news';
  static String getPromo = 'get-promos';
}
