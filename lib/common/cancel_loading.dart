import 'package:get/get.dart';
import 'package:jost_pay_wallet/Provider/Account_Provider.dart';
import 'package:jost_pay_wallet/Provider/Auth_provider.dart';
import 'package:jost_pay_wallet/utils/loader.dart';
import 'package:provider/provider.dart';

class CancelLoading {
  final accountProvider =
      Provider.of<AccountProvider>(Get.context!, listen: false);
  final auth = Provider.of<AuthProvider>(Get.context!, listen: false);

  cancelLoading() {
    hideLoader();
    accountProvider.setLoading(false);
    auth.setLoading(false);
  }
}
