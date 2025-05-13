import 'package:flutter/material.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';

import '../Dashboard/DashboardScreen.dart';

class Policy extends StatefulWidget {
  const Policy({super.key});


  @override
  State<Policy> createState() => _PolicyState();
}

class _PolicyState extends State<Policy> {

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
        child:
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const SizedBox(width: 24,),
                InkWell(
                  onTap: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const DashboardScreen())),
                  child: Image.asset(
                    'assets/images/arrow_left.png',
                  ),
                ),
                const Spacer(),
                Transform.translate(
                  offset: const Offset(-20, 0),
                  child: const Text(
                    'Privacy Policy',
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
                          'JostPay,  is serious about protecting the privacy of your personal information. Our privacy policy explains how we treat your personal data and protect your privacy when using our Services. We have put in place strict policies to ensure that the privacy of your personal information is protected while still allowing you to use the Website (the "Site") or the services provided by JostPay (the "Services"). Through using the Services or the Site, we use information gathered about you solely for the purposes set out in this policy. The terms of this policy are updated periodically, so please check our Website or this page regularly for updates. The JostPay Terms of Service and Registration Terms often incorporate the terms of this regulation.',
                          style: MyStyle.tx18Grey,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 50,),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Text('What information do we collect?', style: MyStyle.tx36Grey,),
                  ),
                  const Padding(
                      padding: EdgeInsets.all(24),
                      child: Text("When you register for our service, we obtain information from you. This information includes your name, e-mail address, phone number, and other information but is not limited to them. We can also gather information regarding our transactions and interactions with you, including your payment history. To enhance the customer experience and deliver our goods and services. We can also obtain information from third parties' websites or applications, as set out below in this policy. However, you can anonymously visit our Site.",
                        style: MyStyle.tx18Grey,
                        textAlign: TextAlign.center,
                      )
                  ),
                  const SizedBox(height: 20,),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Text('What do we do with information we collect?', style: MyStyle.tx36Grey,),
                  ),
                  const Padding(
                      padding: EdgeInsets.all(24),
                      child: Text("We may use any of the information we collect from you in one of the following manners:\n\n▪ To compile, save, use, and analyze your data in both a personally-identifiable form and an aggregated, non-personally identifiable form;\n▪ To operate, maintain, improve and provide to you our Services, conducting our business and processing transactions;\n▪ To verify your identity;\n▪ To register you as a user and identify you when you sign in to your account;\n▪ To personalize your experience and improve customer service (your information helps us to better respond to your individual needs, your service requests, to send marketing communications, and send account update notifications);\n▪ To develop and improve our Website (we continually strive to improve our website offerings based on the information and feedback we receive from you);\n\nWe will share your Personal Information with third parties only in the ways described in the policy.",
                        style: MyStyle.tx18Grey,
                      )
                  ),
                  const SizedBox(height: 20,),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Text('Do we protect your information collect?', style: MyStyle.tx36Grey,),
                  ),
                  const Padding(
                      padding: EdgeInsets.all(24),
                      child: Text("To ensure your data is secure, we take protection very seriously and have developed a robust set of practices, technologies, and policies. We make it a priority to take our users' security and privacy concerns seriously. We use some of the most sophisticated technology commercially available today for Internet security.\nWhen using the Website, entering, submitting, or viewing your personal details, we enforce several security measures to ensure your information is secure. We offer the use of a secure server. Our communications and processing occur through Secure Socket Layers (SSL) technology. We use SSL encryption to ensure the security of all information and then save it into our secure database, only to be accessible by those authorized with special access rights to our systems and must keep the information confidential.\nWe also put sufficient physical, electronic, and managerial processes in place to avoid unauthorized access, preserve data accuracy, and ensure the proper use of information to safeguard and protect the information we receive online. To process all bil payment transactions, we may also use the services of leading companies.\nWhile we strive to protect your personal information, JostPay cannot ensure or warrant the security of any data or content you transmit to us, and you do so at your own risk. We will notify you within a reasonable time frame in the event of a violation of your information's confidentiality or protection so that you can take appropriate preventive measures and inform you of the steps that JostPay is taking concerning such a breach.",
                        style: MyStyle.tx18Grey,
                        textAlign: TextAlign.center,
                      )
                  ),
                  const SizedBox(height: 20,),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Text('Do we use cookies?', style: MyStyle.tx36Grey,),
                  ),
                  const Padding(
                      padding: EdgeInsets.all(24),
                      child: Text("We use cookies, which allow us to make our Website more user-friendly, efficient, and safe. Cookies are tiny text files that your browser uses and are saved on your PC. Most of the cookies we use are session cookies that are automatically deleted at the end of your visit. Cookies do not hurt PC and do not contain any viruses. However, if you do not want to use cookies, you will not be stopped from accessing the Site in any way. You can customize your browser to allow the use of cookies with your permission or block cookies entirely.",
                        style: MyStyle.tx18Grey,
                        textAlign: TextAlign.center,
                      )
                  ),
                  const SizedBox(height: 20,),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Text('Do we disclose any information to outside Parties?', style: MyStyle.tx36Grey,),
                  ),
                  const Padding(
                      padding: EdgeInsets.all(24),
                      child: Text("We will provide your information to our trusted business partners who assist us in operating the Site, conducting our business, including partners referring you to us, or servicing you, so long as those parties agree to keep this information confidential.",
                        style: MyStyle.tx18Grey,
                        textAlign: TextAlign.center,
                      )
                  ),
                  const SizedBox(height: 20,),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Text('Data Retention and Third Parties Services', style: MyStyle.tx36Grey,),
                  ),
                  const Padding(
                      padding: EdgeInsets.all(24),
                      child: Text("We will retain your personal & business information for as long as you use the services or as necessary to fulfill the purpose(s) for which it was collected, provide our products and services, resolve disputes, establish legal defenses, conduct audits, pursue legitimate business purposes, enforce our agreements, and comply with applicable law. If we are required to maintain a record of any information, you may not be able to delete such information due to such requirements. Please be aware that your personal information may be stored on backup tapes and locations, third-party servers, and other repositories that may not be erasable and residual information may be retained. We are under no obligation to store such information indefinitely and disclaim any liability arising out of, or related to, the destruction of such information.\n\nPlease note that if such retention is sufficiently appropriate to follow this policy and our Terms of Service, we keep the details we collect from your profile on the Third Party Website when you are signed in to the Services and even after you have logged out of the Services, at our sole discretion.",
                        style: MyStyle.tx18Grey,
                        textAlign: TextAlign.center,
                      )
                  ),
                  const SizedBox(height: 20,),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Text('Governing Law', style: MyStyle.tx36Grey,),
                  ),
                  const Padding(
                      padding: EdgeInsets.all(24),
                      child: Text("You agree that this policy is governed by Nigeria laws, excluding the choice of law provisions thereof.",
                        style: MyStyle.tx18Grey,
                        textAlign: TextAlign.center,
                      )
                  ),
                  const SizedBox(height: 20,),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Text('Your Consent', style: MyStyle.tx36Grey,),
                  ),
                  const Padding(
                      padding: EdgeInsets.all(24),
                      child: Text("By using the Site, you consent to our Website's policy.",
                        style: MyStyle.tx18Grey,
                        textAlign: TextAlign.center,
                      )
                  ),
                  const SizedBox(height: 20,),
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: Text('Changes to our\nPrivacy & Policy', style: MyStyle.tx36Grey, textAlign: TextAlign.center,),
                    ),
                  ),
                  const Padding(
                      padding: EdgeInsets.all(24),
                      child: Text("If we intend to amend our policies, we will post these updates to this page, and your continuing use of the Site will constitute your approval of this revised policy in such a situation. This Privacy Policy is effective as of june 24th, 2024.",
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
                  const SizedBox(height: 20,)
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
