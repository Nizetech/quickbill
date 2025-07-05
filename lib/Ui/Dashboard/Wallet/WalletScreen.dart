import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:jost_pay_wallet/Provider/account_provider.dart';
import 'package:jost_pay_wallet/Provider/DashboardProvider.dart';
import 'package:jost_pay_wallet/Provider/theme_provider.dart';
import 'package:jost_pay_wallet/Ui/Dashboard/AddFunds.dart';
import 'package:jost_pay_wallet/Ui/Dashboard/AlarmScreen.dart';
import 'package:jost_pay_wallet/Ui/Dashboard/Buy/BuyAirtime.dart';
import 'package:jost_pay_wallet/Ui/Dashboard/Buy/data_history.dart';
import 'package:jost_pay_wallet/Ui/Dashboard/Wallet/widget/banner.dart';
import 'package:jost_pay_wallet/Ui/Dashboard/Wallet/widget/history_card.dart';
import 'package:jost_pay_wallet/Ui/Dashboard/Wallet/widget/profile_image.dart';
import 'package:jost_pay_wallet/Ui/Domain/domain_screen.dart';
import 'package:jost_pay_wallet/Ui/Paint/paint_history.dart';
import 'package:jost_pay_wallet/Ui/repair/repairdetail_screen.dart';
import 'package:jost_pay_wallet/Ui/pay4me/pay4me_history.dart';
import 'package:jost_pay_wallet/Ui/promotions/social_boost_history.dart';
import 'package:jost_pay_wallet/Values/Helper/helper.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:provider/provider.dart';
import 'dart:core';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  late AccountProvider accountProvider;
  List<Map<String, dynamic>> data = [];
  List<Map<String, dynamic>> recentData = [];
  double totalBalance = 0.0;
  Map<String, dynamic> profile = {};

  late String deviceId;
  String selectedAccountId = "",
      selectedAccountName = "",
      selectedAccountAddress = "",
      selectedAccountPrivateAddress = "";

  bool isCalculating = false;
  bool isLoaded = false;

  @override
  void initState() {
    accountProvider = Provider.of<AccountProvider>(context, listen: false);
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await accountProvider.getUserBalance();
      await accountProvider.getNotification();
      await accountProvider.getProfileImage(isLoading: false);
      if (accountProvider.transactionModel == null) {
        await accountProvider.getTrasactions();
      } else {
        await accountProvider.getTrasactions(isLoading: false);
      }
      if (accountProvider.userModel == null) {
        await accountProvider.getUserProfile();
      } else {
        await accountProvider.getUserProfile(isLoading: false);
      }
    });
  }

  FutureOr refresh() async {
    await accountProvider.getTrasactions();
    await accountProvider.getUserBalance();
  }

  FutureOr refreshAll() async {
    await accountProvider.getTrasactions();
    await accountProvider.getUserBalance();
    await accountProvider.getNotification();
    await accountProvider.getUserProfile();
  }

  double showTotalValue = 0.0;
  var trxPrivateKey = "";

  @override
  Widget build(BuildContext context) {
    accountProvider = Provider.of<AccountProvider>(context, listen: true);
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    final dashProvider = Provider.of<DashboardProvider>(context, listen: true);
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Consumer<AccountProvider>(builder: (context, model, _) {
        return RefreshIndicator(
          onRefresh: () async {
            await refreshAll();
          },
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding:
                      const EdgeInsets.only(left: 24.0, right: 24.0, top: 10),
                  decoration: BoxDecoration(
                    // color: Colors.white,
                    border: Border(
                      bottom: BorderSide(

                        color: themeProvider.isDarkMode()
                            ? MyColor.borderDarkColor
                            : MyColor.borderColor,
                          width: 0.9),
                    ),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              dashProvider.changeBottomIndex(4);
                            },
                            child: Container(
                              padding: const EdgeInsets.only(
                                right: 12.0,
                              ),
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(20)),
                                  border: Border.all(
                                      color: themeProvider.isDarkMode()
                                          ? MyColor.borderDarkColor
                                          : MyColor.borderColor,
                                      width: 0.5)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const ProfileImage(size: 40),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    model.userModel?.user?.firstName
                                            ?.capitalizeFirst ??
                                        '',
                                    style: MyStyle.tx12Black.copyWith(
                                      color: themeProvider.isDarkMode()
                                          ? MyColor.mainWhiteColor
                                          : MyColor.dark01Color,
                                    ),
                                  ),
                                  Image.asset(
                                    'assets/images/arrow-right.png',
                                    color: themeProvider.isDarkMode()
                                        ? MyColor.mainWhiteColor
                                        : MyColor.dark01Color,
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 105.w,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (context) =>
                                    //             const SupportScreen()));
                                    dashProvider.changeBottomIndex(9);
                                  },
                                  child: SvgPicture.asset(
                                    'assets/images/svg/customerservice.svg',
                                    colorFilter: ColorFilter.mode(
                                        themeProvider.isDarkMode()
                                            ? MyColor.mainWhiteColor
                                            : MyColor.dark01Color,
                                        BlendMode.srcIn),
                                  ),
                                ),
                                //!Theme switcbing
                                GestureDetector(
                                    onTap: () {
                                      themeProvider.toggleTheme(
                                          themeProvider.isDarkMode()
                                              ? false
                                              : true);
                                    },
                                    child: SvgPicture.asset(
                                      'assets/images/svg/theme.svg',
                                      colorFilter: ColorFilter.mode(
                                          themeProvider.isDarkMode()
                                              ? MyColor.mainWhiteColor
                                              : MyColor.dark01Color,
                                          BlendMode.srcIn),
                                    )),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const AlarmScreen()));
                                  },
                                  child: Stack(
                                    children: [
                                      Icon(
                                        Iconsax.notification,
                                        color: themeProvider.isDarkMode()
                                            ? MyColor.mainWhiteColor
                                            : MyColor.dark01Color,
                                      ),
                                      if (accountProvider.notificationModel !=
                                              null &&
                                          accountProvider.notificationModel!
                                              .notifications!.isNotEmpty)
                                        Positioned(
                                          right: 0,
                                          top: 0,
                                          child: Container(
                                            width: 13,
                                            height: 13,
                                            decoration: BoxDecoration(
                                              color: MyColor.redColor,
                                              shape: BoxShape.circle,
                                            ),
                                            child: Center(
                                              child: Text(
                                                '${accountProvider.notificationModel!.notifications?.length}',
                                                style: MyStyle.tx12Black
                                                    .copyWith(
                                                        color: MyColor
                                                            .mainWhiteColor,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 11),
                                              ),
                                            ),
                                          ),
                                        )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.only(left: 24.0, right: 12.0),
                        decoration: BoxDecoration(
                            // color: MyColor.lightGreenColor,
                            color: Theme.of(context).colorScheme.secondary,
                            border: Border.all(
                                color: themeProvider.isDarkMode()
                                    ? MyColor.borderDarkColor
                                    : MyColor.borderColor,
                                width: 0.9),
                            borderRadius: BorderRadius.circular(10.r)),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 120,
                                  child: Row(
                                    children: [
                                    
                                      SvgPicture.asset(
                                          'assets/images/flag.svg'),
                                      const SizedBox(width: 8),
                                      Text('Balance',
                                          style: MyStyle.tx16Gray.copyWith(
                                              fontSize: 12,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .tertiary))
                                    ],
                                  ),
                                ),
                                InkWell(
                                  onTap: () async {
                                    await refresh();
                                  },
                                  child: Container(
                                    height: 41,
                                    width: 41,
                                    // padding: const EdgeInsets.all(13),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                        shape: BoxShape.circle),
                                      child: SvgPicture.asset(
                                          height: 24,
                                          'assets/images/refresh.svg')
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                accountProvider.isLoading
                                    ? const SizedBox.square(
                                        dimension: 26,
                                        child: CircularProgressIndicator())
                                    : Text(
                                        '₦ ${formatNumber(accountProvider.balance ?? 0)}',
                                        style: MyStyle.tx28Black.copyWith(
                                            fontSize: 26.sp,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .tertiary),
                                      ),
                                SvgPicture.asset(
                                    'assets/images/svg/moneybag.svg'),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const AddFunds()));
                                    },
                                    borderRadius: BorderRadius.circular(
                                        12.3), // Optional: to match the container's border radius
                                    child: Container(
                                      width: 54,
                                      height: 50,
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: MyColor.greenColor,
                                          width: 0.9,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(12.3),
                                      ),
                                      child: SvgPicture.asset(
                                        'assets/images/svg/deposit.svg',
                                        
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text('Add funds',
                                  style: MyStyle.tx12Black.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .tertiary))
                            ],
                          ),
                          Container(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const BuyAirtime(),
                                          ),
                                        );
                                      },
                                      borderRadius: BorderRadius.circular(12.3),
                                      child: Container(
                                        width: 54,
                                        height: 50,
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: MyColor.greenColor,
                                            width: 0.9,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12.3),
                                        ),
                                        child: SvgPicture.asset(
                                          "assets/images/phone.svg",
                                          width: 23,
                                          height: 23,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    Text('Buy Airtime',
                                        style: MyStyle.tx12Black.copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .tertiary))
                                  ],
                                )
                              ],
                            ),
                          ),
                          Container(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    GestureDetector(
                                        onTap: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                 
                                                    const PayForMeHistory())),
                                        child: Container(
                                          width: 54,
                                          height: 50,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: MyColor.greenColor,
                                              width: 0.9,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(12.3),
                                          ),
                                          child: Image.asset(
                                            'assets/images/dashboard/bitcoin-03.png',
                                            width: 23,
                                            height: 23,
                                          ),
                                        ))
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    Text('Pay4me',
                                        style: MyStyle.tx12Black.copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .tertiary))
                                  ],
                                )
                              ],
                            ),
                          ),
                          Container(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () =>
                                          dashProvider.changeBottomIndex(1),
                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (context) =>
                                      //             const Services())),
                                      child: Container(
                                        width: 54,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: MyColor.greenColor,
                                            width: 0.9,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12.3),
                                        ),
                                        child: Image.asset(
                                          'assets/images/dashboard/more-vertical-circle-01.png',
                                          width: 23,
                                          height: 23,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    Text('More',
                                        style: MyStyle.tx12Black.copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .tertiary))
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),

                Visibility(
                    visible: dashProvider.promotionBanner,
                    child: BannerAds(
                      dashProvider: dashProvider,
                    )),
                //?
                //! Here is the services section
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 24, horizontal: 24),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text('Services',
                                style: MyStyle.tx28Black.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.tertiary,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600)),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        GestureDetector(
                                            onTap: () =>
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const BuyAirtime())),
                                            child: Container(
                                              width: 61,
                                              height: 56.5,
                                              decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .scaffoldBackgroundColor,
                                                borderRadius:
                                                    BorderRadius.circular(14),
                                                boxShadow: const [
                                                  MyStyle.widgetShadow,
                                                ],
                                              ),
                                              child: Image.asset(
                                                'assets/images/dashboard/smartphone-wifi.png',
                                                height: 33.r,
                                                width: 33.r,
                                              ),
                                            ))
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 24,
                                    ),
                                    Row(
                                      children: [
                                        Text('Buy Airtime',
                                            style: MyStyle.tx12Black.copyWith(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .tertiary))
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        InkWell(
                                          onTap: () => Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const DataHistory())),
                                          child: Container(
                                            width: 61,
                                            height: 56.5,
                                            decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .scaffoldBackgroundColor,
                                              borderRadius:
                                                  BorderRadius.circular(14),
                                              boxShadow: const [
                                                MyStyle.widgetShadow,
                                              ],
                                            ),
                                            child: Image.asset(
                                              'assets/images/dashboard/smart-phone-01.png',
                                              height: 33.r,
                                              width: 33.r,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 24,
                                    ),
                                    Row(
                                      children: [
                                        Text('Buy Data',
                                            style: MyStyle.tx12Black.copyWith(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .tertiary))
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const SocialBoostHistory())),
                                child: Container(
                                  child: Column(
                                    children: [
                                      Container(
                                        width: 61,
                                        height: 56.5,
                                        padding: EdgeInsets.all(16.r),
                                        decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .scaffoldBackgroundColor,
                                          borderRadius:
                                              BorderRadius.circular(14),
                                          boxShadow: const [
                                            MyStyle.widgetShadow,
                                          ],
                                        ),
                                        child: SvgPicture.asset(
                                          'assets/images/svg/socialBoost.svg',
                                          height: 33.r,
                                          width: 33.r,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 24,
                                      ),
                                      Row(
                                        children: [
                                          Text('Social Boost',
                                              style: MyStyle.tx12Black.copyWith(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .tertiary))
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () => Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const PayForMeHistory())),
                                          child: Container(
                                            width: 61,
                                            height: 56.5,
                                            padding: EdgeInsets.all(16.r),
                                            decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .scaffoldBackgroundColor,
                                              borderRadius:
                                                  BorderRadius.circular(14),
                                              boxShadow: const [
                                                MyStyle.widgetShadow,
                                              ],
                                            ),
                                            child: SvgPicture.asset(
                                              'assets/images/svg/payment.svg',
                                              height: 33.r,
                                              width: 33.r,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 24,
                                    ),
                                    Row(
                                      children: [
                                        Text('Pay4me',
                                            style: MyStyle.tx12Black.copyWith(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .tertiary))
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 22),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          GestureDetector(
                                              onTap: () => Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const RepairdetailScreen())),
                                              child: Container(
                                                width: 61,
                                                height: 56.5,
                                                decoration: BoxDecoration(
                                                  color: Theme.of(context)
                                                      .scaffoldBackgroundColor,
                                                  borderRadius:
                                                      BorderRadius.circular(14),
                                                  boxShadow: const [
                                                    MyStyle.widgetShadow,
                                                  ],
                                                ),
                                                child: Image.asset(
                                                  'assets/images/dashboard/repair.png',
                                                  scale: 1.4,
                                                ),
                                              ))
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 24,
                                      ),
                                      Row(
                                        children: [
                                          Text('Repairs',
                                              style: MyStyle.tx12Black.copyWith(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .tertiary))
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          InkWell(
                                            onTap: () => Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const DomainScreen())),
                                            child: Container(
                                              width: 61,
                                              height: 56.5,
                                              decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .scaffoldBackgroundColor,
                                                borderRadius:
                                                    BorderRadius.circular(14),
                                                boxShadow: const [
                                                  MyStyle.widgetShadow,
                                                ],
                                              ),
                                              child: Image.asset(
                                                'assets/images/dashboard/web-security.png',
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 24,
                                      ),
                                      Row(
                                        children: [
                                          Text('Hosting & Domain',
                                              style: MyStyle.tx12Black.copyWith(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .tertiary))
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => Get.to(PaintHistory()),
                                  child: Container(
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              width: 61,
                                              height: 56.5,
                                              padding: EdgeInsets.all(16.r),
                                              decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .scaffoldBackgroundColor,
                                                borderRadius:
                                                    BorderRadius.circular(14),
                                                boxShadow: const [
                                                  MyStyle.widgetShadow,
                                                ],
                                              ),
                                              child: Image.asset(
                                                'assets/images/dashboard/spray.png',
                                              ),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 24,
                                        ),
                                        Row(
                                          children: [
                                            Text('Spray',
                                                style: MyStyle.tx12Black
                                                    .copyWith(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .tertiary))
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () => dashProvider
                                                .changeBottomIndex(1),
                                            child: Container(
                                              width: 61,
                                              height: 56.5,
                                              padding: EdgeInsets.all(16.r),
                                              decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .scaffoldBackgroundColor,
                                                borderRadius:
                                                    BorderRadius.circular(14),
                                                boxShadow: const [
                                                  MyStyle.widgetShadow,
                                                ],
                                              ),
                                              child: SvgPicture.asset(
                                                'assets/images/svg/viewAll.svg',
                                                height: 33.r,
                                                width: 33.r,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 24,
                                      ),
                                      Row(
                                        children: [
                                          Text('View all',
                                              style: MyStyle.tx12Black.copyWith(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .tertiary))
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ]),

                          const SizedBox(height: 30),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              'History',
                              style: MyStyle.tx14Grey.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color:
                                      Theme.of(context).colorScheme.tertiary),
                            ),
                          ),
                          // const SizedBox(height: 10),
                          if (accountProvider.dashBoardHistory != null &&
                              accountProvider
                                  .dashBoardHistory!.data!.isNotEmpty)
                            ListView.separated(
                              separatorBuilder: (_, i) => SizedBox(
                                height: 12,
                              ),
                              padding: EdgeInsets.only(bottom: 50),
                              physics: const NeverScrollableScrollPhysics(),
                              // reverse: true,
                              itemBuilder: (context, index) {
                                var item =
                                    accountProvider
                                    .dashBoardHistory!.data![index];
                                return HistoryCard(
                                  transaction: item,
                                );
                              },
                              shrinkWrap: true,
                              itemCount:
                                  accountProvider
                                          .dashBoardHistory!.data!.length >
                                      5
                                      ? 5
                                      : accountProvider
                                      .dashBoardHistory!.data!.length,
                            )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
