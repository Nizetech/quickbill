import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:jost_pay_wallet/Provider/account_provider.dart';
import 'package:jost_pay_wallet/Provider/theme_provider.dart';
import 'package:jost_pay_wallet/Ui/Dashboard/Deposit.dart';
import 'package:jost_pay_wallet/Ui/Dashboard/Wallet/kyc_web.dart';
import 'package:jost_pay_wallet/Ui/Dashboard/Wallet/receipt_script.dart';
import 'package:jost_pay_wallet/Ui/Dashboard/Wallet/widget/activate_virtual_account.dart';
import 'package:jost_pay_wallet/Ui/Dashboard/Wallet/widget/balance_card.dart';
import 'package:jost_pay_wallet/Ui/Dashboard/Wallet/widget/virtual_number.dart';
import 'package:jost_pay_wallet/Values/Helper/helper.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/utils.dart';
import 'package:jost_pay_wallet/common/status_view_receipt.dart';
import 'package:jost_pay_wallet/utils/toast.dart';
import 'package:provider/provider.dart';

class AddFunds extends StatefulWidget {
  const AddFunds({super.key});

  @override
  State<AddFunds> createState() => _AddFundsState();
}

class _AddFundsState extends State<AddFunds> {

  @override
  void initState() {
    super.initState();
    final model = Provider.of<AccountProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (model.depositHistoryModel == null) {
        model.getDepositHistory();
      } else {
        model.getDepositHistory(isLoading: false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    final themedata = Theme.of(context).colorScheme;
    return Scaffold(
      body: Consumer<AccountProvider>(builder: (context, account, _) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 10,
              left: 24,
              right: 24,
            ), 
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: themeProvider.isDarkMode()
                            ? MyColor.borderDarkColor
                            : MyColor
                                .borderColor, // Set the color of the border
                        width: 0.5, // Set the width of the border
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () => Get.back(),
                          child: Image.asset(
                            'assets/images/arrow_left.png',
                            color: themeProvider.isDarkMode()
                                ? MyColor.mainWhiteColor
                                : MyColor.dark01Color,
                          ),
                        ),
                        const Spacer(), // Adds flexible space between the image and the text
                        Transform.translate(
                          offset: const Offset(-26, 0),
                          child: Text(
                            'Add Funds',
                            // 'Wallet Activation',
                            style: MyStyle.tx18Black
                                .copyWith(color: themedata.tertiary),
                          ),
                        ),
                        const Spacer(), // Adds flexible space after the text
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      await account.getDepositHistory();
                    },
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: BalanceCard(
                                  hasAddFund: true,
                                ),
                              ),
                              SizedBox(width: 5),
                              Expanded(
                                child: GestureDetector(
                                    onTap: () {
                                      if (account.userModel?.user?.createdAt !=
                                              null &&
                                          // account.userModel?.user?.isActive ==
                                          //     false &&
                                          account.userModel?.user
                                                  ?.basicVerified ==
                                              false &&
                                          account.userModel?.user?.idVerified ==
                                              false) {
                                        Get.to(() => const KycWebview());
                                      } else {
                                        Get.to(
                                          Deposit(),
                                        );
                                      }
                                    },
                                    child:
                                  Container(
                                      height: 125,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: themeProvider.isDarkMode()
                                            ? Color(0XFF1D361D)
                                            : Color(0xffDAEBDA),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              SizedBox(width: 10),
                                              CircleAvatar(
                                                radius: 20,
                                                backgroundColor: Colors.white
                                                    .withValues(alpha: .08),
                                                child: SvgPicture.asset(
                                                  'assets/images/trend_up.svg',
                                                  color: Colors.white,
                                                ),
                                              ),
                                              Spacer(),
                                              Image.asset(
                                                'assets/images/vector.png',
                                                height: 60,
                                              ),
                                            ],
                                          ),
                                          Spacer(),
                                          Text(
                                            'Explore other options',
                                            style: MyStyle.tx16Black.copyWith(
                                                decoration:
                                                    TextDecoration.underline,
                                                decorationColor:
                                                    MyColor.greenColor,
                                                color: MyColor.greenColor),
                                          ),
                                          SizedBox(height: 5),
                                        ],
                                      ),
                                    )),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          account.userModel?.user?.virtualAccount != false
                              ? VirtualNumber()
                              : ActivateVirtualAccount(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Deposit History',
                                style: MyStyle.tx14Black
                                    .copyWith(color: themedata.tertiary),
                              ),
                              // Text(
                              //   'View all',
                              //   style: MyStyle.tx14Black
                              //       .copyWith(color: themedata.tertiary),
                              // ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                                      
                          if (account.depositHistoryModel != null)
                            ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount:
                                    account.depositHistoryModel!.data!.length,
                                padding: EdgeInsets.zero,
                                itemBuilder: (context, index) {
                                  var item =
                                      account.depositHistoryModel!.data![index];
                                  return Container(
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                      width: 0.4,
                                      color: themeProvider.isDarkMode()
                                          ? MyColor.borderDarkColor
                                          : MyColor.borderColor,
                                    ))),
                                    child: Column(
                                      children: [
                                        const SizedBox(
                                          height: 16,
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              height: 41,
                                              width: 41,
                                              padding: EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                  color: themedata.secondary,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12.3)),
                                              child: SvgPicture.asset(
                                                  'assets/images/svg/deposit.svg'),
                                            ),
                                            const SizedBox( 
                                              width: 6,
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Deposit - ${item.type!}",
                                                    maxLines: 1,
                                                    // "${item.phone!} - ${item.networkName!}",
                                                    style: MyStyle.tx12Black
                                                        .copyWith(
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            color: themedata
                                                                .tertiary),
                                                  ),
                                                  const SizedBox(
                                                    height: 4,
                                                  ),
                                                  Text(
                                                    item.reference!,
                                                    maxLines: 1,
                                                    style: MyStyle.tx12Black
                                                        .copyWith(
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            color: themedata
                                                                .tertiary),
                                                  ),
                                                  const SizedBox(
                                                    height: 4,
                                                  ),
                                                  Text(
                                                    formatDateTime(
                                                      item.updatedAt!,
                                                    ),
                                                    //  dateFormat.format(item.createdAt!),
                                                    style: MyStyle.tx12Black
                                                        .copyWith(
                                                      color: themeProvider
                                                              .isDarkMode()
                                                          ? const Color(
                                                              0XFFCBD2EB)
                                                          : const Color(
                                                              0xff30333A),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            SizedBox(width: 25),
                                            Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        Utils.naira +
                                                            formatNumber(
                                                                num.parse(item
                                                                    .amount!)),
                                                        style: MyStyle.tx12Black
                                                            .copyWith(
                                                                color: themedata
                                                                    .tertiary),
                                                      ),
                                                      SizedBox(width: 5),
                                                      GestureDetector(
                                                        onTap: () {},
                                                        child: SvgPicture.asset(
                                                            'assets/images/refresh.svg'),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 8.h,
                                                  ),
                                                  StatusViewReceipt(
                                                    status: item.status!,
                                                    isRefunded: false,
                                                    onTap: () {
                                                      if (item.status!
                                                              .toLowerCase()
                                                              .contains(
                                                                  'pending') ||
                                                          item.status!
                                                              .toLowerCase()
                                                              .contains(
                                                                  'cancel') ||
                                                          item.status!
                                                              .toLowerCase()
                                                              .contains(
                                                                  'fail')) {
                                                        ErrorToast(
                                                            'No receipt available yet. Your order has not been completed.');
                                                      } else {
                                                        Get.to(ReceiptScreen(
                                                          status: item.status!,
                                                          isDeposit: true,
                                                          serviceDetails:
                                                              'Data',
                                                          description:
                                                              'Deposit - ${item.type!}',
                                                          referenceNo:
                                                              item.reference!,
                                                          amount: item.amount!,
                                                          date: item.updatedAt!
                                                              .toString(),
                                                        ));
                                                      }
                                                    },
                                                  ),
                                                ])
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 16,
                                        )
                                      ],
                                    ),
                                  );
                                })
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
