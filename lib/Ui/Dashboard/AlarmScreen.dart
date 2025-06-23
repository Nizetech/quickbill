import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:jost_pay_wallet/Models/notification_model.dart';
import 'package:jost_pay_wallet/Provider/account_provider.dart';
import 'package:jost_pay_wallet/Provider/theme_provider.dart';
import 'package:jost_pay_wallet/Values/Helper/helper.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
// import 'package:jost_pay_wallet/Values/NewColor.dart' as color;
import 'package:jost_pay_wallet/Values/NewStyle.dart';
import 'package:jost_pay_wallet/common/button.dart';
import 'package:provider/provider.dart';

class AlarmScreen extends StatefulWidget {
  const AlarmScreen({super.key});

  @override
  State<AlarmScreen> createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen> {
  String selectedAccountName = "";
  String type = "all";
  TextEditingController searchController = TextEditingController();

  List<Notifications> notifications = [];
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final account = Provider.of<AccountProvider>(context, listen: false);
      if (account.notificationModel == null) {
        await account.getNotification();
      }
      setState(() {
        notifications = account.notificationModel!.notifications!;
      });
    });
  }

// @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     final account = Provider.of<AccountProvider>(context, listen: false);
//     account.readNotification();
//   }
  FutureOr readNotification() async {
    final account = Provider.of<AccountProvider>(context, listen: false);
    await account.readNotification();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);

    return WillPopScope(
      onWillPop: () async {
        await readNotification();
        Get.back();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          leading: BackBtn(
            onTap: () async {
              await readNotification();
              Get.back();
            },
          ),
          title: Text(
            "Recent Notifications",
            style: NewStyle.tx28White.copyWith(
              fontSize: 20,
              color: MyColor.dark02Color,
            ),
          ),
        ),
        body: Consumer<AccountProvider>(builder: (context, model, _) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: model.notificationModel == null ||
                    model.notificationModel != null &&
                        model.notificationModel!.notifications!.isEmpty
                ? const Center(
                    child:
                        Text("No Notification Found", style: MyStyle.tx28Black),
                  )
                : ListView.builder(
                    itemCount: notifications.length,
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    itemBuilder: (context, index) {
                      // Sort notifications by most recent (descending order)
                      var sortedNotifications = notifications
                        ..sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
                      var item = sortedNotifications[index];
                      return ListTile(
                        minVerticalPadding: 0,
                        contentPadding: EdgeInsets.zero,
                        leading: Container(
                          height: 41.r,
                          width: 41.r,
                          padding: EdgeInsets.all(6.r),
                          decoration: BoxDecoration(
                              color: themeProvider.isDarkMode()
                                  ? const Color(0XFF171717)
                                  : const Color(0XFFF4F5F6),
                              shape: BoxShape.circle),
                          child:
                              SvgPicture.asset('assets/images/svg/money.svg'),
                        ),
                        title: Text(
                          item.type!.capitalizeFirst!,
                          style: MyStyle.tx14Grey.copyWith(
                              fontWeight: FontWeight.w400,
                              fontSize: 12.sp,
                              color: themeProvider.isDarkMode()
                                  ? const Color(0XFFCBD2EB)
                                  : const Color(0xff30333A)),
                        ),
                        trailing: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '₦${formatNumber(num.parse(item.amount!))}',
                              style: MyStyle.tx14Grey.copyWith(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12.sp,
                                  color: themeProvider.isDarkMode()
                                      ? const Color(0XFFCBD2EB)
                                      : const Color(0xff30333A)),
                            ),
                            Text(
                              item.status == 'success' || item.status == '1'
                                  ? 'Successful'
                                  : item.status == 'pending'
                                      ? 'Pending'
                                      : 'Failed',
                              style: MyStyle.tx14Grey.copyWith(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 11.sp,
                                  color: item.status == 'success' ||
                                          item.status == '1'
                                      ? const Color(0XFF027A48)
                                      : const Color(0XFFEA4D2D)),
                            ),
                          ],
                        ),
                        subtitle: Text(
                          formatDateTime(item.updatedAt!),
                          style: MyStyle.tx14Grey.copyWith(
                              fontWeight: FontWeight.w400,
                              fontSize: 12.sp,
                              color: themeProvider.isDarkMode()
                                  ? const Color(0XFFCBD2EB)
                                  : const Color(0xff30333A)),
                        ),
                      );
                    },
                  ),
          );
        }),
      ),
    );
  }
}
