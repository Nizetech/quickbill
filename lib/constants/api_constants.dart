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
  static String getProfileImage = 'get-profile-image';
  static String updateProfileImage = 'update-image';
  static String getBalance = 'get-balance';
  static String getDataPlans = 'get-data-plans';
  static String getTransactions = 'get-purchases';
  static String getNotification = 'get-news';
  static String readNotification = 'read-news';
  static String getPromo = 'get-promos';
  static String getReferrals = 'get-referrals';
  static String getNetworkProviders = 'get-network-providers';

  // Services
  static String buyAirtime = 'buy-airtime';
  static String buyData = 'buy-data';
  static String getCountries = 'get-gift-countries';
  static String buySocialBoost = 'buy-social-boost';
  static String buyGiftCard = 'buy-gift-card';
  static String buyPay4Me = 'buy-pay4me';
  static String getPayRate = 'get-rates';
  static String serviceHistory = 'get-purchases';
  static String getSocialSections = 'get-social-sections';
  static String getGiftCard = 'get-gift-cards';
  static String getCard = 'get-gift-card';
  static String getSocialServices = 'get-social-services';
  static String getCarListing = 'marketplace/cars';
  static String getCarDetails = 'marketplace/get-car';
  static String bookInspection = 'marketplace/cars-inspection';
  static String getScriptDetails = 'marketplace/get-script';
  static String scriptTransactions = 'marketplace/scripts-landing';
  static String carsTransactions = 'marketplace/cars-landing';
  static String buyScript = 'marketplace/buy-script';
  static String getScript = 'marketplace/scripts';
  static String buyCar = 'marketplace/buy-car';
  static String getCarTypes = 'services/spray-land';
  static String getColorPaint = 'services/spray-main';
  static String getSprayHistory = 'services/spray-history';
  static String getSpraydetails = 'services/spray-history/details';
  static String sharePdf = 'services/spray-history/download';
  static String payPending = 'services/spray-history/pay';
  static String rentSpray = 'services/rent-spray';
  static String buyRepairs = 'services/auto-repair/buy';
  static String repairTransList = 'services/auto-repair/list';
  static String repairDetails = 'services/auto-repair/work-list';
  static String skipRepair = 'services/auto-repair/skip-work';
  static String shareRepairInvoice = 'services/auto-repair/share';
  static String payRepairVehicle = 'services/auto-repair/pay';
  static String domainList = 'services/domain-name/list';
}
