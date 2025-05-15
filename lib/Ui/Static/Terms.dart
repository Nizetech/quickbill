import 'package:flutter/material.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';

import '../../bottom_nav.dart';

class Terms extends StatefulWidget {
  const Terms({super.key});


  @override
  State<Terms> createState() => _TermsState();
}

class _TermsState extends State<Terms> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 68),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const SizedBox(width: 24,),
                InkWell(
                  onTap: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const BottomNav())),
                  child: Image.asset(
                    'assets/images/arrow_left.png',
                  ),
                ),
                const Spacer(),
                Transform.translate(
                  offset: const Offset(-20, 0),
                  child: const Text(
                    'Terms of Use',
                    style: MyStyle.tx18Black,
                  ),
                ),
                const Spacer(), // Adds flexible space after the text
              ],
            ),
            const SizedBox(height: 12,),
            Expanded(child:
            SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 36,),
                  Container(
                    color: MyColor.darkGreenColor,
                    alignment: Alignment.center,
                    child: const Center(
                      child: Padding(
                        padding: EdgeInsets.all(24),
                        child: Text(
                          'Where the present Terms of Service (“TOS”) refer to “Jostpay”, they may refer to other affiliates, and / or their respective shareholders, officers, directors, employees, agents, partners, principals, representatives, successors, and assigns (collectively “Representatives”), depending on the context being used. Any reference to “we”, “our”, or “us” in these TOS refers to Just pay.',
                          style: MyStyle.tx18Grey,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 24, left: 24, right: 24),
                      child: Text.rich(
                        TextSpan(
                            children: [
                              TextSpan(
                                text: '“Platform”',
                                style: MyStyle.tx14Black.copyWith(
                                    color: MyColor.grey02Color
                                ),
                              ),
                              TextSpan(
                                text: ' means that part of our website or any software application that sets out terms specific to the Platform that we provide you, including details of any Fees. “Platform” refers to the software services accessed through the Website that Jostpay has developed and / or licensed to allow user to pay bills  & other related services.',
                                style: MyStyle.tx14Black.copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: MyColor.grey02Color
                                ),
                              ),
                            ]
                        ),
                        textAlign: TextAlign.center,
                      )
                  ),
                  Padding(
                      padding: const EdgeInsets.all(24),
                      child: Text.rich(
                        TextSpan(
                            children: [
                              TextSpan(
                                text: '“Website”',
                                style: MyStyle.tx14Black.copyWith(
                                    color: MyColor.grey02Color
                                ),
                              ),
                              TextSpan(
                                text: ' is the website located at https://www.JostPay.com  which are owned and operated by JostPay, without limiting the generality of the foregoing and includes all subdomains and subpages, present and future. Without limiting the generality of the foregoing, or an app where the Platform services are accessed by a Logged-in User.',
                                style: MyStyle.tx14Black.copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: MyColor.grey02Color
                                ),
                              ),
                            ]
                        ),
                        textAlign: TextAlign.center,
                      )
                  ),
                  const SizedBox(height: 20,),
                  const Center(
                    child: Text('Tos Acceptance', style: MyStyle.tx36Grey,),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(24),
                    child: Text('By interacting with the Platform in any way, including but not limited to: (i) clicking or tapping the acceptance button when signing up for an account; or (ii) fund your wallet through the Platform, you hereby accept the TOS without any reservations, modifications, additions, or deletions. If you do not agree to all the provisions contained in the TOS, you are not authorized to use the Platform.\n\nThe TOS is a legal and binding agreement between you and us. By accepting this Agreement, you certify that you have all the necessary rights, permissions, and authority to do so, and  you have read and understand this Agreement. If you are going against the rules of the platform you must not accept this Agreement or access the Platform.\n\nJostPay reserves the right to modify or replace any of these TOS, at any time and without prior notice. Any changes to the TOS can be found on our Website. It is your responsibility to check the TOS periodically for changes. Unless JostPay is legally required to provide you with notice, your continued use of the Platform demonstrates your agreement to any changes. If you do not agree to the modifications, you should discontinue using the Platform.',
                      style: MyStyle.tx18Grey,
                      textAlign: TextAlign.center,
                    )
                  ),
                  const SizedBox(height: 20,),
                  const Center(
                    child: Text('Contact Us', style: MyStyle.tx36Grey,),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(24),
                      child: Text.rich(
                        TextSpan(
                            children: [
                              const TextSpan(
                                text: 'If you have any questions regarding the Platform, please contact us at ',
                                style: MyStyle.tx18Grey,
                              ),
                              TextSpan(
                                text: 'help@Jostpay.com',
                                style: MyStyle.tx18Grey.copyWith(
                                    decoration: TextDecoration.underline,
                                    decorationColor: MyColor.greenColor,
                                    color: MyColor.greenColor
                                ),
                              ),
                              const TextSpan(
                                text: ' or visit ',
                                style: MyStyle.tx18Grey,
                              ),
                              TextSpan(
                                text: 'https://support.Jostpay.com',
                                style: MyStyle.tx18Grey.copyWith(
                                  decoration: TextDecoration.underline,
                                  decorationColor: MyColor.greenColor,
                                  color: MyColor.greenColor
                                ),
                              ),
                              const TextSpan(
                                text: ' for more information.',
                                style: MyStyle.tx18Grey,
                              ),
                            ]
                        ),
                        textAlign: TextAlign.center,
                      )
                  ),
                  const SizedBox(height: 20,),
                  const Padding(padding: EdgeInsets.all(24), child: Text('General Code of Conduct for Use of the Platform', style: MyStyle.tx36Grey, textAlign: TextAlign.center,),),
                  const Padding(
                    padding: EdgeInsets.all(24),
                    child: Text('In addition to the more specific rules found elsewhere in these TOS, you agree that by interacting with the Website or Platform in any way, you will: \n\n▪ NOT use the Website or Platform in any manner that in any way violates these TOS or any other applicable policy posted on the Website or in the Platform by JostPay.\n\n▪ NOT use the Website or Platform in any manner that violates any intellectual property rights of JostPay or any third party; \n\n▪ NOT use the Website or Platform in any manner to propagate spam, including but not limited to, unsolicited advertising or bulk electronic mail or messages, including to link to a spam or phishing website; \n\n▪ NOT use the Website or Platform in any manner to propagate software viruses, Trojan horses, worms, or any other malicious or non-malicious computer code, files, or programs that are designed or intended to disrupt, damage, limit or interfere with the proper functioning of any software, hardware, or telecommunications equipment in any form whether belonging to JostPay or a third party, or to damage or obtain unauthorized access to any system, data, information (whether personal data or not) of JostPay, other Platform Users, or any other third party; \n\n▪ NOT: (1) take any action that imposes or may impose (as determined by JostPay in its sole discretion) an unreasonable or disproportionately large load on JostPay (or its third party providers’) infrastructures; (2) interfere or attempt to interfere with the proper functioning of the Website or Platform or any activities conducted on or via the Website or Platform; (3) bypass any measures JostPaymay use to prevent or restrict access to the Platform or any element thereof; (4) use manual or automated software, devices, or other processes to “crawl” or “spider” any page or portion of the Website or Platform; or (5) harvest or scrape any content from the Website or Platform in an unreasonable manner; \n\n▪ NOT take any action or use any process that removes, modifies, disables, blocks, obscures or otherwise impairs any advertising or other promotions in connection with the Website or Platform; \n\n▪ NOT use the Website or Platform in any way to collect information (whether personal information or not) of any third party or in violation of our Privacy Policy, except as permitted by the nature and function of the Website or Platform; \n\n▪ NOT use the Website or Platform to advertise or promote products or services that are not expressly approved in advance in writing by JostPay or as otherwise permitted by the nature of the Platform; \n\n▪ NOT interfere with any third party’s use or enjoyment of the Website or Platform; \n\n▪ NOT do anything or encourage conduct that would constitute a criminal offense or give rise to civil liability, or is any way unlawful, illegal, fraudulent or harmful to any third party; \n\n▪ NOT attempt to do any of the foregoing prohibitions; Use the Website and Platform in good faith, and in compliance with all the applicable local, state or provincial and national law.',
                      style: MyStyle.tx18Grey,
                      textAlign: TextAlign.center,
                    )
                  )
                ],
              ),
            )
            )
          ],
        ),
      ),
    );
  }
}
