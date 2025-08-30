class ApiRoute {
  static String baseUrl = 'https://project.jostpay.com/apis/';
  // static String baseUrl = 'https://jostpay.com/apis/';

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
  static String kycVerify = 'verification/verify';
  static String getVerificationDetails = 'verification';
  static String verifyImageUpload = 'verification/verify-image-upload';
  static String createVirtual = '/deposit/fidelity';

  // Dashboard
  static String userProfile = 'get-user-profile';
  static String updateProfile = 'update-profile';
  static String deactivateAccount = 'deactivate-account';
  static String getProfileImage = 'get-profile-image';
  static String updateProfileImage = 'update-image';
  static String getInvoice = 'get-invoice';
  static String getBalance = 'get-balance';
  static String getDataPlans = 'get-data-plans';
  static String getTransactions = 'get-purchases';
  static String getNotification = 'get-news';
  static String getBanks = 'get-banks';
  static String readNotification = 'read-news';
  static String getPromo = 'get-promos';
  static String deleteAccount = 'delete-account';
  static String getReferrals = 'get-referrals';
  static String getNetworkProviders = 'get-network-providers';
  static String creditDeposit = 'create-deposit';
  static String cardBankTransfer = 'deposits/create-payment';

  // Services
  static String buyAirtime = 'buy-airtime';
  static String buyData = 'buy-data';
  static String getCountries = 'get-gift-countries';
  static String buySocialBoost = 'buy-social-boost';
  static String buyGiftCard = 'buy-gift-card';
  static String buyPay4Me = 'buy-pay4me';
  static String getPayRate = 'get-rates';
  static String serviceHistory = 'get-purchases';
  static String recentDepositHistory = 'get-recent-purchases';
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
  static String receipt = 'marketplace/receipt';
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
  static String cableTransactions = 'services/cable-landing';
  static String electricityTransactions = 'services/electricity-landing';
  static String cableMerchant = 'services/cable/merchant';
  static String electricityMerchant = 'services/electricity/merchant';
  static String cableVariations = 'services/get-variationCodes';
  static String buyCable = 'services/buy-cable';
  static String buyElectricity = 'services/buy-electricity';
}
