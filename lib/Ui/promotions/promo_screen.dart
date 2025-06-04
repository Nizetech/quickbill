import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:jost_pay_wallet/Models/promotion_model.dart';
import 'package:jost_pay_wallet/Provider/account_provider.dart';
import 'package:jost_pay_wallet/Provider/theme_provider.dart';
import 'package:jost_pay_wallet/Values/Helper/helper.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:provider/provider.dart';

class PromoScreen extends StatefulWidget {
  const PromoScreen({super.key});

  @override
  State<PromoScreen> createState() => _PromoScreenState();
}

class _PromoScreenState extends State<PromoScreen> {
  int currentPage = 1;
  int rowsPerPage = 2;

  // final List<Map<String, String>> data = 
  // List.generate(
  //     6,
  //     (index) => {
  //           "date": "March 1, 2025",
  //           "service": "Airtime",
  //           "code": "Xcq8790",
  //         });
  List<UserPromo>? userPromos = [];
  @override
  void initState() {
    super.initState();
    final account = Provider.of<AccountProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (account.promoModel == null) {
        await account.getPromotion();
        userPromos = account.promoModel!.userPromos;
      } else {
        await account.getPromotion(isLoading: false);
        userPromos = account.promoModel!.userPromos;
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final totalPages = (userPromos!.length / rowsPerPage).ceil();
    log("totalPages: $totalPages");
    // List<UserPromo> currentData = userPromos!
    //     .skip((currentPage - 1) * rowsPerPage)
    //     .take(rowsPerPage)
    //     .toList();
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    final isDark = themeProvider.isDarkMode();
    final themedata = Theme.of(context).colorScheme;
    return Scaffold(
      body: Consumer<AccountProvider>(builder: (context, account, _) {
        return SafeArea(
          child: RefreshIndicator(
            onRefresh: () => account.getPromotion(),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(isDark
                      ? 'assets/images/prom.png'
                      : 'assets/images/promoBanner.png'),
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Follow the follow to win Big!',
                          style: MyStyle.tx18Black.copyWith(
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).colorScheme.tertiary),
                        ),
                        const SizedBox(
                          height: 27,
                        ),
                        Text(
                          'For every airtime and data purchase, you qualify for a promo! If you have a promo code, tap submit to enter for a chance to win amazing gifts.',
                          style: MyStyle.tx18Black.copyWith(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: const Color(0xff6B7280)),
                        ),
                        const SizedBox(
                          height: 37,
                        ),
                        Center(
                          child: Container(
                            width: 400,
                            decoration: BoxDecoration(
                              color: isDark
                                  ? MyColor.dark02Color
                                  : MyColor.mainWhiteColor,
                              border: Border.all(
                                  color: isDark
                                      ? const Color(0xff1B1B1B)
                                      : const Color(0xffE9EBF8),
                                  width: 0.9),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 14, vertical: 12),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text("Latest Promo Codes",
                                        style: MyStyle.tx16Black.copyWith(
                                            color: themedata.tertiary,
                                            fontWeight: FontWeight.w600)),
                                  ),
                                ),

                                // Table header
                                Container(
                                  height: 35,
                                  decoration: BoxDecoration(
                                    color: isDark
                                        ? const Color(0xff131313)
                                        : const Color(0xFFF9F9F9),
                                    border: Border(
                                      top: BorderSide(
                                          width: 0.9,
                                          color: isDark
                                              ? const Color(0xff1B1B1B)
                                              : const Color(0xffE9EBF8)),
                                      bottom: BorderSide(
                                          width: 0.9,
                                          color: isDark
                                              ? const Color(0xff1B1B1B)
                                              : const Color(0xffE9EBF8)),
                                    ),
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                          flex: 2,
                                          child: Container(
                                            height: 35,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              border: Border(
                                                right: BorderSide(
                                                    width: 0.9,
                                                    color: isDark
                                                        ? const Color(
                                                            0xff1B1B1B)
                                                        : const Color(
                                                            0xffE9EBF8)),
                                              ),
                                            ),
                                            child: Text("Date",
                                                style: MyStyle.tx12Grey
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: const Color(
                                                            0xff505660))),
                                          )),
                                      Expanded(
                                          flex: 2,
                                          child: Container(
                                            height: 35,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              border: Border(
                                                right: BorderSide(
                                                    width: 0.9,
                                                    color: isDark
                                                        ? const Color(
                                                            0xff1B1B1B)
                                                        : const Color(
                                                            0xffE9EBF8)),
                                              ),
                                            ),
                                            child: Text("Services",
                                                style: MyStyle.tx12Grey
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: const Color(
                                                            0xff505660))),
                                          )),
                                      Expanded(
                                          flex: 2,
                                          child: Container(
                                            alignment: Alignment.center,
                                            height: 35,
                                            decoration: BoxDecoration(),
                                            child: Text("Promo Code",
                                                style: MyStyle.tx12Grey
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: const Color(
                                                            0xff505660))),
                                          )),
                                    ],
                                  ),
                                ),
                                // if(currentData.isEmpty)
                                //   Container(
                                //     height: 50,
                                //     alignment: Alignment.center,
                                //     child: Text(
                                //       "No promo codes available",
                                //       style: MyStyle.tx12Black.copyWith(
                                //           fontWeight: FontWeight.w500,
                                //           color: isDark
                                //               ? MyColor.mainWhiteColor
                                //               : const Color(0xff6B7280)),
                                //     ),
                                //   )

                                // Data rows
                                if (account.promoModel != null &&
                                    account.promoModel!.userPromos!.isNotEmpty)
                                  ...account.promoModel!.userPromos!
                                      .map((item) => Container(
                                            decoration: BoxDecoration(
                                              border: Border(
                                                bottom: BorderSide(
                                                    color: isDark
                                                        ? const Color(
                                                            0xff1B1B1B)
                                                        : const Color(
                                                            0xffE9EBF8)),
                                              ),
                                            ),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                    flex: 2,
                                                    child: Container(
                                                      height: 35,
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 5),
                                                      alignment:
                                                          Alignment.center,
                                                      decoration: BoxDecoration(
                                                        border: Border(
                                                          right: BorderSide(
                                                              width: 0.9,
                                                              color: isDark
                                                                  ? const Color(
                                                                      0xff1B1B1B)
                                                                  : const Color(
                                                                      0xffE9EBF8)),
                                                        ),
                                                      ),
                                                      child: Text(
                                                        formatDateYear(
                                                            item.createdAt!),
                                                        maxLines: 1,
                                                        style: MyStyle.tx12Black.copyWith(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            color: isDark
                                                                ? MyColor
                                                                    .mainWhiteColor
                                                                : const Color(
                                                                    0xff6B7280)),
                                                      ),
                                                    )),
                                                Expanded(
                                                  flex: 2,
                                                  child: Container(
                                                    height: 35,
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 5),
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                      border: Border(
                                                        right: BorderSide(
                                                            width: 0.9,
                                                            color: isDark
                                                                ? const Color(
                                                                    0xff1B1B1B)
                                                                : const Color(
                                                                    0xffE9EBF8)),
                                                      ),
                                                    ),
                                                    child: Text(
                                                      item.service
                                                              ?.capitalizeFirst ??
                                                          "",
                                                      maxLines: 1,
                                                      style: MyStyle.tx12Black
                                                          .copyWith(
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: isDark
                                                            ? MyColor
                                                                .mainWhiteColor
                                                            : const Color(
                                                                0xff6B7280),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Container(
                                                    height: 35,
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 5),
                                                    alignment: Alignment.center,
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Expanded(
                                                          child: Text(
                                                            item.promoCode ??
                                                                "",
                                                            maxLines: 1,
                                                            style: MyStyle.tx12Black.copyWith(
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: isDark
                                                                    ? MyColor
                                                                        .mainWhiteColor
                                                                    : const Color(
                                                                        0xff6B7280)),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 14,
                                                        ),
                                                        GestureDetector(
                                                            onTap: () {
                                                              Clipboard.setData(
                                                                  ClipboardData(
                                                                      text: item
                                                                              .promoCode ??
                                                                          ''));
                                                            },
                                                            child: Container(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(6),
                                                              decoration: BoxDecoration(
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  color: isDark
                                                                      ? const Color(
                                                                          0xff1D361D)
                                                                      : const Color(
                                                                          0xffDAEBDA)),
                                                              child: SvgPicture.asset(
                                                                  width: 13,
                                                                  height: 13,
                                                                  color: isDark
                                                                      ? MyColor
                                                                          .greenColor
                                                                      : const Color(
                                                                          0xff0B930B),
                                                                  "assets/images/svg/promo.svg"),
                                                            )),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )),

                                // ?Pagination
                                // Padding(
                                //   padding: const EdgeInsets.symmetric(
                                //       horizontal: 15, vertical: 12),
                                //   child: Row(
                                //     mainAxisAlignment:
                                //         MainAxisAlignment.spaceBetween,
                                //     children: [
                                //       // Rows per page dropdown
                                //       DropdownButtonHideUnderline(
                                //         child: Container(
                                //           height: 28,
                                //           padding: const EdgeInsets.symmetric(
                                //               horizontal: 8),
                                //           decoration: BoxDecoration(
                                //             color: isDark
                                //                 ? const Color(0xff101010)
                                //                 : const Color(0xffFCFCFC),
                                //             border: Border.all(
                                //               color: isDark
                                //                   ? const Color(0xff1B1B1B)
                                //                   : const Color(
                                //                       0xffE9EBF8), // stroke color
                                //               width: 0.8,
                                //             ),
                                //             borderRadius: BorderRadius.circular(6),
                                //           ),
                                //           child: DropdownButton<int>(
                                //             value: rowsPerPage,
                                //             icon: Padding(
                                //               padding:
                                //                   const EdgeInsets.only(left: 15),
                                //               child: Icon(
                                //                 Icons.expand_more,
                                //                 color: themedata.tertiary,
                                //               ),
                                //             ),
                                //             dropdownColor: isDark
                                //                 ? const Color(0xff181818)
                                //                 : const Color(0xffFCFCFC),
                                //             style: MyStyle.tx11Grey.copyWith(
                                //               color: const Color(0xff656D76),
                                //               fontSize: 12,
                                //               fontWeight: FontWeight.w600,
                                //             ),
                                //             items: [2, 3, 4].map((e) {
                                //               return DropdownMenuItem<int>(
                                //                 value: e,
                                //                 child: Text('$e'),
                                //               );
                                //             }).toList(),
                                //             onChanged: (val) {
                                //               setState(() {
                                //                 rowsPerPage = val!;
                                //                 currentPage = 1;
                                //               });
                                //             },
                                //           ),
                                //         ),
                                //       ),
                                //       //? Pagination buttons
                                //       // Row(
                                //       //   mainAxisSize: MainAxisSize.min,
                                //       //   children: [
                                //       //     GestureDetector(
                                //       //       onTap: () {
                                //       //         currentPage > 1
                                //       //             ? () =>
                                //       //                 setState(() => currentPage--)
                                //       //             : {};
                                //       //       },
                                //       //       child: SvgPicture.asset(
                                //       //           "assets/images/svg/back.svg"),
                                //       //     ),
                                //       //     ...List.generate(3, (index) {
                                //       //       int page = index + 1;

                                //       //       return GestureDetector(
                                //       //         onTap: () => setState(
                                //       //             () => currentPage = page),
                                //       //         child: Container(
                                //       //           margin: const EdgeInsets.symmetric(
                                //       //               horizontal: 4), // tight spacing
                                //       //           padding: const EdgeInsets.symmetric(
                                //       //               horizontal: 9, vertical: 3),
                                //       //           decoration: BoxDecoration(
                                //       //             color: isDark
                                //       //                 ? const Color(0xff181818)
                                //       //                 : const Color(0xffF4F4F4),
                                //       //             borderRadius:
                                //       //                 BorderRadius.circular(3),
                                //       //           ),
                                //       //           child: Text(
                                //       //             '$page',
                                //       //             style: MyStyle.tx11Grey.copyWith(
                                //       //               fontWeight: FontWeight.w500,
                                //       //               color: const Color(0xff656D76),
                                //       //               fontSize: 10,
                                //       //             ),
                                //       //           ),
                                //       //         ),
                                //       //       );
                                //       //     }),
                                //       //     GestureDetector(
                                //       //       onTap: () {
                                //       //         currentPage < totalPages
                                //       //             ? () =>
                                //       //                 setState(() => currentPage++)
                                //       //             : {};
                                //       //       },
                                //       //       child: SvgPicture.asset(
                                //       //         "assets/images/svg/next.svg",
                                //       //         color: isDark
                                //       //             ? MyColor.mainWhiteColor
                                //       //             : Colors.black,
                                //       //       ),
                                //       //     ),
                                //       //   ],
                                //       // )

                                //     ],
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        ),
                        // Text(
                        //   'Got a promo code? Tab submit to enter',
                        //   style: MyStyle.tx18Black.copyWith(
                        //       fontWeight: FontWeight.w400,
                        //       fontSize: 18,
                        //       color: const Color(0xff6B7280)),
                        // ),
                        // const SizedBox(
                        //   height: 28,
                        // ),
                        // SizedBox(
                        //   width: double.infinity,
                        //   child: TextButton(
                        //     onPressed: () {
                        //       showModalBottomSheet(
                        //         context: context,
                        //         isScrollControlled: true,
                        //         backgroundColor: Colors.transparent,
                        //         builder: (context) {
                        //           return Theme(
                        //             data: Theme.of(context),
                        //             child: Builder(builder: (context) {
                        //               return Material(
                        //                 type: MaterialType.transparency,
                        //                 child: Container(
                        //                   alignment: Alignment.topLeft,
                        //                   height: 593,
                        //                   padding: EdgeInsets.fromLTRB(
                        //                     0,
                        //                     20,
                        //                     0,
                        //                     MediaQuery.viewInsetsOf(context).bottom,
                        //                   ),
                        //                   decoration: const BoxDecoration(
                        //                     color: MyColor.lightGreenColor,
                        //                     borderRadius: BorderRadius.vertical(
                        //                         top: Radius.circular(16)),
                        //                   ),
                        //                   child: Stack(
                        //                     alignment: Alignment.topCenter,
                        //                     children: [
                        //                       Positioned(
                        //                           top: -70,
                        //                           right: 0,
                        //                           left: 0,
                        //                           child: Image.asset(
                        //                               'assets/images/box.png')),
                        //                       Align(
                        //                         alignment: Alignment.bottomCenter,
                        //                         child: Container(
                        //                           width: double.infinity,
                        //                           padding: const EdgeInsets.all(30),
                        //                           height: 345,
                        //                           decoration: BoxDecoration(
                        //                               borderRadius:
                        //                                   const BorderRadius.only(
                        //                                       topLeft:
                        //                                           Radius.circular(
                        //                                               10),
                        //                                       topRight:
                        //                                           Radius.circular(
                        //                                               10)),
                        //                               color:
                        //                                   themeProvider.isDarkMode()
                        //                                       ? Colors.black
                        //                                       : MyColor.splashBtn),
                        //                           child: Column(
                        //                             children: [
                        //                               Text(
                        //                                 'Claim a prize worth of 1million naira',
                        //                                 style: MyStyle.tx20Grey
                        //                                     .copyWith(
                        //                                         color: MyColor
                        //                                             .mainWhiteColor),
                        //                               ),
                        //                               const SizedBox(
                        //                                 height: 15,
                        //                               ),
                        //                               Text(
                        //                                 'Earn a limited- time reward by just making transaction with us!',
                        //                                 style: MyStyle.tx20Grey
                        //                                     .copyWith(
                        //                                         fontSize: 14,
                        //                                         fontWeight:
                        //                                             FontWeight.w400,
                        //                                         color: MyColor
                        //                                             .mainWhiteColor),
                        //                                 textAlign: TextAlign.center,
                        //                               ),
                        //                               const SizedBox(
                        //                                 height: 25,
                        //                               ),
                        //                               TextFormField(
                        //                                 // controller: _emailController,
                        //                                 decoration: NewStyle
                        //                                     .authInputDecoration
                        //                                     .copyWith(
                        //                                         fillColor: Colors
                        //                                             .transparent,
                        //                                         // fillColor: themeProvider
                        //                                         //         .isDarkMode()
                        //                                         //     ? Color(
                        //                                         //         0XFF33353C)
                        //                                         //     : MyColor
                        //                                         //         .textFieldFillColor,
                        //                                         hintText:
                        //                                             'Enter code'),
                        //                               ),
                        //                               const SizedBox(
                        //                                 height: 35,
                        //                               ),
                        //                               SizedBox(
                        //                                 width: double.infinity,
                        //                                 child: TextButton(
                        //                                   onPressed: () {
                        //                                     Navigator.push(
                        //                                         context,
                        //                                         MaterialPageRoute(
                        //                                           builder: (context) =>
                        //                                               const SocialsScreen(),
                        //                                         ));
                        //                                   },
                        //                                   style:
                        //                                       TextButton.styleFrom(
                        //                                     backgroundColor:
                        //                                         MyColor.splashBtn,
                        //                                     padding: const EdgeInsets
                        //                                         .symmetric(
                        //                                         vertical:
                        //                                             16), // Padding
                        //                                     shape:
                        //                                         RoundedRectangleBorder(
                        //                                       side:
                        //                                           const BorderSide(
                        //                                         color: MyColor
                        //                                             .mainWhiteColor,
                        //                                       ),
                        //                                       borderRadius:
                        //                                           BorderRadius
                        //                                               .circular(6),
                        //                                     ),
                        //                                   ),
                        //                                   child: Text(
                        //                                     "Submit",
                        //                                     style: MyStyle.tx16Green
                        //                                         .copyWith(
                        //                                             color: MyColor
                        //                                                 .mainWhiteColor,
                        //                                             fontWeight:
                        //                                                 FontWeight
                        //                                                     .w700),
                        //                                   ),
                        //                                 ),
                        //                               ),
                        //                             ],
                        //                           ),
                        //                         ),
                        //                       )
                        //                     ],
                        //                   ),
                        //                 ),
                        //               );
                        //             }),
                        //           );
                        //         },
                        //       );
                        //     },
                        //     style: TextButton.styleFrom(
                        //       backgroundColor: MyColor.greenColor,
                        //       padding: const EdgeInsets.symmetric(
                        //           vertical: 16), // Padding
                        //       shape: RoundedRectangleBorder(
                        //         borderRadius: BorderRadius.circular(6),
                        //       ),
                        //     ),
                        //     child: const Text(
                        //       "Enter Code",
                        //       style: MyStyle.tx16White,
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      }
      ),
    );
  }
}
