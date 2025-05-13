import 'package:flutter/material.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';

import '../Dashboard/DashboardScreen.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({super.key});

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
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
                const SizedBox(
                  width: 24,
                ),
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
                    'About Us',
                    style: MyStyle.tx18Black,
                  ),
                ),
                const Spacer(), // Adds flexible space after the text
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: Image.asset(
                      'assets/images/Frame 1618868322.png',
                      width: double.infinity,
                    ),
                  ),
                  const Text(
                    'Making Bill Payments More',
                    style: MyStyle.tx24Grey,
                  ),
                  const Text(
                    'Convenient & Accessible',
                    style: MyStyle.tx24Grey,
                  ),
                  const Text(
                    'for everyone.',
                    style: MyStyle.tx24Grey,
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 24,
                      ),
                      Image.asset('assets/images/About (1).png'),
                      const Spacer(),
                      Image.asset('assets/images/About (2).png'),
                      const Spacer(),
                      Image.asset(
                        'assets/images/About (3).png',
                        width: 74,
                      ),
                      const SizedBox(
                        width: 24,
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 37, horizontal: 24),
                    color: MyColor.lightGreenColor,
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 380,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(
                                10), // Adjust the radius value as needed
                          ),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        Text(
                          'Our Journey',
                          style: MyStyle.tx24Grey.copyWith(color: Colors.black),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        Text(
                          "We're helping everyone navigate the financial challenges of today. JostPay was born from the firsthand experiences of serial entrepreneur Azeez Maxwell, who first-handily experienced cash flow challenges. Our mission? To transform and empower businesses by enhancing their bill payment workflows, eliminating payment delays, and helping them spend their hard-earned money. Say goodbye to late bills  payments and waiting around on weekends. We've developed one of the best  tools and features on the platform, powered by JostPay. We deliver more than just convenient payments; we provide smarter workflows that save time, enhance your experience, and allow businesses to focus on what they do best.",
                          style: MyStyle.tx18Black.copyWith(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                              height: 1.8,
                              color: MyColor.grey02Color),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 36,
                  ),
                  Text(
                    'Meet our leader',
                    style: MyStyle.tx24Grey.copyWith(color: MyColor.blackColor),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Container(
                      width: double.infinity,
                      height: 358,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border:
                              Border.all(color: MyColor.greenColor, width: 1),
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Text(
                    'Mr Akiola Thomas',
                    style: MyStyle.tx24Grey.copyWith(color: MyColor.blackColor),
                  ),
                  const Text('CEO & Co-Founder', style: MyStyle.tx24Grey),
                  const SizedBox(
                    height: 36,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      'Thomas is a seasoned business analyst and strategist with a track record of guiding both established and startup ventures across Africa towards successful transformation. His leadership has resulted in the development of resilient organizations known for generating lasting value for their stakeholders. With over two decades of experience at Ernst & Young, including managing the West Africa business portfolio for Financial Accounting Advisory Services (FAAS) and Climate Change & Sustainability Services (CCaSS) units, Samuel has played a pivotal role in restructuring high-profile organizations in West Africa and the UK, fostering resilience and long-term value creation, He has also served as CEO of Pacific Metals Limited and Power Alluvia Ltd, overseeing operations and management in Ghana.Samuel is a chartered accountant with an MBA in Finance from the University of Hull Business School and a Bachelor of Commerce Degree from the University of Cape Coast. He holds membership in various professional bodies, including the Institute of Chartered Accountants (Ghana and Nigeria), Chartered Institute of Taxation (Ghana), and the National Association of Certified Valuators and Analysts. Notably, Samuel served as a Technical Advisor to the International Public Sector Accounting Standards Board (IPSASB) for two years. His career at Ernst & Young has seen him excel in diverse roles, from Strategy and Transaction to Business Consulting and Tax, culminating in his promotion to lead FAAS in West Africa in 2011.',
                      style: MyStyle.tx18Black
                          .copyWith(fontWeight: FontWeight.w400, height: 2),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 48,
                        ),
                        Text(
                          'Leading the way in modern business for everyone',
                          style: MyStyle.tx24Grey.copyWith(
                            color: MyColor.blackColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          'JostPay is trusted by',
                          style: MyStyle.tx18Black.copyWith(
                              color: MyColor.blackColor,
                              fontWeight: FontWeight.w400),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 60,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 24, horizontal: 10),
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: MyColor.borderColor,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(10)),
                          width: double.infinity,
                          child: Column(
                            children: [
                              Image.asset('assets/images/avatar-2.png'),
                              const SizedBox(
                                height: 12,
                              ),
                              Text(
                                'Agbola Williams',
                                style: MyStyle.tx18Black.copyWith(
                                    fontSize: 20, fontWeight: FontWeight.w400),
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              const Text(
                                'CEO, Valian company',
                                style: MyStyle.tx14Green,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                "Thank you so much - I can't believe how much we packed into a short conversation! The team is so friendly, and incredibly knowledgeable. It also helps that they are clearly incredibly passionate about their profession, and being on financial freedom!",
                                style: MyStyle.tx18Black
                                    .copyWith(fontWeight: FontWeight.w400),
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 24, horizontal: 10),
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: MyColor.borderColor,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(10)),
                          width: double.infinity,
                          child: Column(
                            children: [
                              Image.asset('assets/images/avatar-2.png'),
                              const SizedBox(
                                height: 12,
                              ),
                              Text(
                                'Agbola Williams',
                                style: MyStyle.tx18Black.copyWith(
                                    fontSize: 20, fontWeight: FontWeight.w400),
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              const Text(
                                'CEO, Valian company',
                                style: MyStyle.tx14Green,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                "Thank you so much - I can't believe how much we packed into a short conversation! The team is so friendly, and incredibly knowledgeable. It also helps that they are clearly incredibly passionate about their profession, and being on financial freedom!",
                                style: MyStyle.tx18Black
                                    .copyWith(fontWeight: FontWeight.w400),
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
