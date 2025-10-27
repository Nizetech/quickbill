import 'package:get/get.dart';
import 'package:quick_bills/Provider/account_provider.dart';
import 'package:quick_bills/Provider/auth_provider.dart';
import 'package:quick_bills/utils/loader.dart';
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
