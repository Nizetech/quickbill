class ApiRoute {
  // static String baseUrl = 'https://api.paypointapp.africa/api/';
  static String baseUrl = 'https://project.jostpay.com/apis/';

  //Auth
  static String signup = 'signup';
  static String login = 'login';
  static String resendOtp = 'get-email-code';
  static String verifyOtp = 'verify-email';
  static String verify2fa = 'verify-2fa';
  static String verifyAuth = 'verify-auth';
  static String enable2fa = 'enable-2fa';
  static String changePassword = 'change-password';
  static String resetPassword = 'forget-password';

  // Dashboard
  static String userProfile = 'get-user-profile';
  static String updateProfile = 'update-profile';
  static String getBalance = 'get-balance';
  static String getTransactions = 'get-purchases';
  static String getNotification = 'get-news';
  static String readNotification = 'read-news';
  static String getPromo = 'get-promos';
  static String getReferrals = 'get-referrals';

  // Services
  static String getCarTypes = 'services/spray-land';
  static String getColorPaint = 'services/spray-main';
  static String getSprayHistory = 'services/spray-history';
  static String getSpraydetails = 'services/spray-history/details';
  static String sharePdf = 'services/spray-history/share';
  static String payPending = 'services/spray-history/pay';
  static String rentSpray = 'services/rent-spray';
}
