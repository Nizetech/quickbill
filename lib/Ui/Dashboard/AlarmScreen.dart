import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:jost_pay_wallet/Provider/Account_Provider.dart';
import 'package:jost_pay_wallet/Provider/theme_provider.dart';
import 'package:jost_pay_wallet/Values/Helper/helper.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:jost_pay_wallet/Values/NewColor.dart';
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


  @override
  void initState() {
    super.initState();
WidgetsBinding.instance.addPostFrameCallback((_) async {
      final account = Provider.of<AccountProvider>(context, listen: false);
      if (account.notificationModel == null) {
        await account.getNotification();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: BackBtn(),
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
                  itemCount: model.notificationModel!.notifications!.length,
                  shrinkWrap: true,
              padding: const EdgeInsets.all(0),
              itemBuilder: (context, index) {
                    var item = model.notificationModel!.notifications![index];
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
                        child: SvgPicture.asset('assets/images/svg/money.svg'),
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
                        formatDateTime(item.createdAt!),
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
      }
      ),
    );
  }
}
