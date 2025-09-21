import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:jost_pay_wallet/Provider/account_provider.dart';
import 'package:jost_pay_wallet/Provider/service_provider.dart';
import 'package:jost_pay_wallet/Provider/theme_provider.dart';
import 'package:jost_pay_wallet/Ui/Dashboard/Wallet/bank_werbview.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:jost_pay_wallet/Values/NewColor.dart';
import 'package:jost_pay_wallet/Values/NewStyle.dart';
import 'package:jost_pay_wallet/Values/utils.dart';
import 'package:jost_pay_wallet/constants/api_constants.dart';
import 'package:jost_pay_wallet/constants/constants.dart';
import 'package:jost_pay_wallet/utils/toast.dart';
import 'package:provider/provider.dart';

class CardFundSummary extends StatefulWidget {
  final String amount;
  final bool isCard;
  const CardFundSummary({super.key, required this.amount, this.isCard = false});

  @override
  State<CardFundSummary> createState() => _CardFundSummaryState();
}

class _CardFundSummaryState extends State<CardFundSummary> {
  String bankCharge = '';
  String amount = '';
  final box = Hive.box(kAppName);
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        bankCharge = (num.parse(widget.amount) *
                (widget.isCard ? 1.2 / 100 : 0.54 / 100))
            .toString();
        amount = (num.parse(widget.amount) - num.parse(bankCharge)).toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final themedata = Theme.of(context).colorScheme;
    return Scaffold(
      body: Consumer2<AccountProvider, ServiceProvider>(
          builder: (context, model, service, _) {
        return Column(
          children: [
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(top: 10, left: 24, right: 24),
                child: Column(
                  children: [
                    Row(
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
                        const Spacer(),
                        Transform.translate(
                          offset: const Offset(-20, 0),
                          child: Text(
                            widget.isCard ? 'Card Transfer' : 'Bank Transfer',
                            style: MyStyle.tx18Black.copyWith(
                              color: themedata.tertiary,
                            ),
                          ),
                        ),
                        const Spacer(), // Adds flexible space after the text
                      ],
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          boxShadow: const [MyStyle.widgetShadow],
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(5)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Deposit Summary',
                            style: MyStyle.tx14Black.copyWith(
                                color: themedata.tertiary,
                                fontFamily: 'Roboto'),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          Row(
                            children: [
                              const Text(
                                'Method',
                                style: MyStyle.tx12Grey,
                              ),
                              const Spacer(),
                              Text(
                                widget.isCard
                                    ? 'Card Transfer'
                                    : 'Bank Transfer',
                                style: MyStyle.tx12Black.copyWith(
                                    color: themedata.tertiary,
                                    fontFamily: 'SF Pro Rounded'),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Row(
                            children: [
                              const Text(
                                'Amount',
                                style: MyStyle.tx12Grey,
                              ),
                              const Spacer(flex: 1),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  '${Utils.naira} ${widget.amount}',
                                  textAlign: TextAlign.end,
                                  style: MyStyle.tx12Black.copyWith(
                                      color: themedata.tertiary,
                                      fontFamily: 'SF Pro Rounded'),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Row(
                            children: [
                              const Text(
                                'Bank Charge',
                                style: MyStyle.tx12Grey,
                              ),
                              const Spacer(),
                              Text(
                                bankCharge,
                                style: MyStyle.tx12Black.copyWith(
                                    color: themedata.tertiary,
                                    fontFamily: 'SF Pro Rounded'),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          SizedBox(
                            width: double.infinity, // Full width of the screen
                            height: 4, // Adjust height as needed
                            child: Stack(
                              children: [
                                // Bottom border
                                Positioned(
                                  bottom: 0,
                                  left: 0,
                                  right: 0,
                                  child: DottedBorder(
                                    color: themeProvider.isDarkMode()
                                        ? MyColor.borderDarkColor
                                        : MyColor.borderColor,
                                    strokeWidth: 1,
                                    dashPattern: const [
                                      6,
                                      3
                                    ], // Dash pattern: 6 units line, 3 units space
                                    customPath: (size) => Path()
                                      ..moveTo(0, 0)
                                      ..lineTo(size.width, 0),
                                    child: Container(
                                      height:
                                          0, // The container for the border can have a height of 0
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Row(
                            children: [
                              const Text(
                                'Amount to credited',
                                style: MyStyle.tx12Grey,
                              ),
                              const Spacer(),
                              Text(
                                '${Utils.naira} $amount',
                                style: MyStyle.tx14Black.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: themedata.tertiary,
                                    fontFamily: 'SF Pro Rounded'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: MyColor.greenColor,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () async {
                          if (model.userModel?.user?.idVerified == false &&
                              num.parse(widget.amount) > 20000) {
                            ErrorToast(
                                'You need to verify your account to deposit more than 20,000');
                            return;
                          } else {
                            if (widget.isCard) {
                              model.cardBankTransfer(
                                  amount: widget.amount,
                                  onSuccess: (value) {
                                    print(value);
                                    // return;
                                    Get.to(
                                        BankWebview(url: value, isCard: true));
                                  });
                            } else {
                              String token = await box.get(kAccessToken);
                              String url =
                                  '${ApiRoute.baseUrlWeb}deposit-fidelity?token=$token&&amount=${widget.amount}';
                              print(url);
                              // return;
                              Get.to(BankWebview(url: url));
                            }
                          }
                        },
                        child: Text(
                          "Fund Wallet",
                          style: NewStyle.btnTx16SplashBlue
                              .copyWith(color: NewColor.mainWhiteColor),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
