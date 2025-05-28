import 'package:get/get.dart';
import 'package:jost_pay_wallet/Provider/account_provider.dart';
import 'package:jost_pay_wallet/Provider/auth_provider.dart';
import 'package:jost_pay_wallet/utils/loader.dart';
import 'package:provider/provider.dart';

class CancelLoading {
  final accountProvider =
      Provider.of<AccountProvider>(Get.context!, listen: false);
  final auth = Provider.of<AuthProvider>(Get.context!, listen: false);

  cancelLoading() {
    if (Get.isDialogOpen!) {
    hideLoader();
    }
    accountProvider.setLoading(false);
    auth.setLoading(false);
  }
}
