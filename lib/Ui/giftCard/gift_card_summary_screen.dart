
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jost_pay_wallet/Models/card_model.dart';
import 'package:jost_pay_wallet/Provider/account_provider.dart';
import 'package:jost_pay_wallet/Provider/service_provider.dart';
import 'package:jost_pay_wallet/Provider/theme_provider.dart';
import 'package:jost_pay_wallet/Values/Helper/helper.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:jost_pay_wallet/Values/NewColor.dart';
import 'package:jost_pay_wallet/Values/NewStyle.dart';
import 'package:jost_pay_wallet/Values/utils.dart';
import 'package:jost_pay_wallet/utils/toast.dart';
import 'package:provider/provider.dart';

class GiftCardSummaryScreen extends StatefulWidget {
  final CardModel cardModel;
  final String phoneNumber;
  final String amount;
  final String countryCode;
  final String qty;
  const GiftCardSummaryScreen({
    super.key,
    required this.countryCode,
    required this.phoneNumber,
    required this.amount,
    required this.qty,
    required this.cardModel,
  });

  @override
  State<GiftCardSummaryScreen> createState() => _GiftCardSummaryScreenState();
}

class _GiftCardSummaryScreenState extends State<GiftCardSummaryScreen> {
  String total = '';
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        var giftCardPrice =
            (num.parse(widget.amount) + widget.cardModel.product!.senderFee!) *
                num.parse(widget.qty) *
                num.parse(widget.cardModel.ngnPrice!);
        var fee = giftCardPrice * widget.cardModel.giftFeePercent!;
        total = fee.toString();
        // (giftCardPrice + fee).toString();
        // log("giftCardPrice $giftCardPrice fee $fee total $total, Percent ${widget.cardModel.giftFeePercent}, SenderFee ${widget.cardModel.product!.senderFee}, NGNPrice ${widget.cardModel.ngnPrice}");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    final themedata = Theme.of(context).colorScheme;
    return Scaffold(
      body: Consumer<ServiceProvider>(builder: (context, model, _) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 15, left: 24, right: 24),
            child: Column(
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: () => Navigator.pop(context),
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
                        'Trade summary',
                        style: MyStyle.tx18Black.copyWith(
                          color: themedata.tertiary,
                        ),
                      ),
                    ),
                    const Spacer(), // Adds flexible space after the text
                  ],
                ),
                SizedBox(
                  height: 78.h,
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
                      Align(
                        alignment: Alignment.centerLeft,
                        child: CachedNetworkImage(
                            imageUrl: widget.cardModel.product!.logoUrls!.first,
                            height: 85.r,
                            width: 85.r,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Container(),
                            errorWidget: (context, url, error) => Container()),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        'Card Trade Summary',
                        style: MyStyle.tx14Black.copyWith(
                            fontFamily: 'Roboto', color: themedata.tertiary),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Row(
                        children: [
                          const Text(
                            'Card Amount',
                            style: MyStyle.tx12Grey,
                          ),
                          const Spacer(),
                          Text(
                            '\$${widget.amount}',
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
                            'Quantity',
                            style: MyStyle.tx12Grey,
                          ),
                          const Spacer(),
                          Text(
                            '${widget.qty} Card',
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
                            'Your Number',
                            style: MyStyle.tx12Grey,
                          ),
                          const Spacer(),
                          Text(
                            widget.phoneNumber,
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
                            'Payment method',
                            style: MyStyle.tx12Grey,
                          ),
                          const Spacer(),
                          Text(
                            'wallet',
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
                            'You pay',
                            style: MyStyle.tx12Grey,
                          ),
                          const Spacer(),
                          if (total.isNotEmpty)
                            Text(
                              '${Utils.naira} ${formatNumber(num.parse(total))}',
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
                SizedBox(
                  height: 47.h
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
                    onPressed: () {
                      if (num.parse(total.toString()) >
                          context.read<AccountProvider>().balance!) {
                        ErrorToast('Insufficient balance');
                      } else {
                        model.buyGiftCard({
                          "country_code": widget.countryCode,
                          "gift_id": widget.cardModel.product!.productId,
                          "usd_amount": widget.amount,
                          "qty": widget.qty,
                          "phone": widget.countryCode == "NG" &&
                                  !widget.phoneNumber.startsWith("0")
                              ? "0${widget.phoneNumber}"
                              : widget.phoneNumber,
                        });
                        // Navigator.pushReplacement(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => const SocialSuccessScreen()));
                      }
                    },
                    child: Text(
                      "Confirm",
                      style: NewStyle.btnTx16SplashBlue
                          .copyWith(color: NewColor.mainWhiteColor),
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
