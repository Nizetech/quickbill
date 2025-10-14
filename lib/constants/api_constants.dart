class ApiRoute {
  // static String projectUrl = 'https://project.jostpay.com/';
  // static String liveUrl = projectUrl;
  // static String liveUrl = 'https://jostpay.com/';
  static String liveUrl = 'https://jostpay.masterscript.org/';
  static String baseUrlWeb = liveUrl;
  static String baseUrl = '${liveUrl}apis/';

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
  static String updatePin = 'pin-update';
  static String pinLogin = 'pin-login';
  static String updatePinLogin = 'pin-update';
  static String googleLogin = 'google-login'; 
  static String kycVerify = 'verification/verify';
  static String getVerificationDetails = 'verification';
  static String verifyImageUpload = 'verification/verify-image-upload';
  static String createVirtual = '/deposit/fidelity';
  static String deactivateAccount = 'deactivate-account';
  // Dashboard
  static String userProfile = 'get-user-profile';
  static String updateProfile = 'update-profile';
  static String getProfileImage = 'get-profile-image';
  static String updateProfileImage = 'update-image';
  static String getInvoice = 'deposits/get-invoice';
  static String getBalance = 'get-balance';
  static String getDataPlans = 'get-data-plans';
  static String getTransactions = 'transactions';
  // static String getTransactions = 'get-purchases';
  static String getNotification = 'get-news';
  // static String getBanks = 'get-banks';
  static String getBanks = 'deposits';
  static String readNotification = 'read-news';

  static String getNetworkProviders = 'get-network-providers';


  // Services
  static String buyAirtime = 'buy-airtime';
  static String buyData = 'buy-data';

  // static String serviceHistory = 'get-purchases';
  // static String recentDepositHistory = 'get-recent-purchases';
  static String receipt = 'marketplace/receipt';
  static String creditDeposit = 'deposits/add-fund-manual';
  // static String creditDeposit = 'create-deposit';
  static String cardBankTransfer = 'deposits/create-payment';

  static String sharePdf = 'services/spray-history/download';

  static String cableTransactions = 'services/cable-landing';
  static String electricityTransactions = 'services/electricity-landing';
  static String cableMerchant = 'services/cable/merchant';
  static String electricityMerchant = 'services/electricity/merchant';
  static String cableVariations = 'services/get-variationCodes';
  static String buyCable = 'services/buy-cable';
  static String buyElectricity = 'services/buy-electricity';
  static String getHistory = 'services/get-history';
  static String squardCallback = 'squard_callback';
}
