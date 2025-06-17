import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jost_pay_wallet/Provider/service_provider.dart';
import 'package:jost_pay_wallet/Provider/theme_provider.dart';
import 'package:jost_pay_wallet/Ui/car/buy_car_summary.dart';
import 'package:jost_pay_wallet/Ui/car/schedule_inspection.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:provider/provider.dart';

class CardetailScreen extends StatefulWidget {
  const CardetailScreen({super.key});

  @override
  State<CardetailScreen> createState() => _CardetailScreenState();
}

class _CardetailScreenState extends State<CardetailScreen> {
  String mainImg = 'assets/images/main-car.png';
  List images = [];
  int selectedIndex = -1;
  @override
  void initState() {
    super.initState();
    final model = Provider.of<ServiceProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        mainImg = model.carDetailsModel!.car!.carImage!;
        images = model.carDetailsModel!.car!.galleries!.split(',');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    final isDark = themeProvider.isDarkMode();
    final width = (MediaQuery.of(context).size.width -
            MediaQuery.of(context).padding.horizontal) -
        55;
    final themedata = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: themeProvider.isDarkMode()
          ? MyColor.dark02Color
          : MyColor.mainWhiteColor,
      body: Consumer<ServiceProvider>(builder: (context, model, _) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18)
                .copyWith(bottom: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                        'Autolot7 Motors',
                        style: MyStyle.tx18Black
                            .copyWith(color: themedata.tertiary),
                      ),
                    ),
                    const Spacer(), // Adds flexible space after the text
                  ],
                ),
                // Main Car Image
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          model.carDetailsModel!.car!.title!,
                          style: MyStyle.tx18Grey.copyWith(
                            fontWeight: FontWeight.w500,
                            color: themedata.tertiary,
                          ),
                        ),
                        const SizedBox(height: 15),

                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CachedNetworkImage(
                            imageUrl: mainImg,
                            height: 245,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Container(),
                            errorWidget: (context, url, error) => Container(),
                          ),
                        ),
                        const SizedBox(height: 2),
                        // Thumbnail Row
                        if (model.carDetailsModel!.car!.galleries!.isNotEmpty)
                          SizedBox(
                            height: 80,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: images.length, // Number of thumbnails
                              separatorBuilder: (_, __) =>
                                  const SizedBox(width: 2),
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedIndex = index;
                                      mainImg = images[index];
                                    });
                                  },
                                  child: Container(
                                    width: width / 3,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: selectedIndex == index
                                            ? isDark
                                                ? const Color(0xff0B930B)
                                                : MyColor.splashBtn
                                            : Colors.transparent,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(2.4),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: CachedNetworkImage(
                                        imageUrl: images[index],
                                        // height: 245,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) =>
                                            Container(),
                                        errorWidget: (context, url, error) =>
                                            Container(),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),

                        const SizedBox(height: 15),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10)),
                            border: Border(
                              top: BorderSide(
                                color: isDark
                                    ? const Color(0xff1B1B1B)
                                    : const Color(0xffE9EBF8),
                                width: 1.0,
                              ),
                              left: BorderSide(
                                color: isDark
                                    ? const Color(0xff1B1B1B)
                                    : const Color(0xffE9EBF8),
                                width: 1.0,
                              ),
                              right: BorderSide(
                                color: isDark
                                    ? const Color(0xff1B1B1B)
                                    : const Color(0xffE9EBF8),
                                width: 1.0,
                              ),
                              bottom: BorderSide(
                                color: isDark
                                    ? const Color(0xff1B1B1B)
                                    : const Color(0xffE9EBF8),
                                width: 1.0,
                              ),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 14, horizontal: 19),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: isDark
                                          ? const Color(0xff1B1B1B)
                                          : const Color(0xffE9EBF8),
                                      width: 2,
                                    ),
                                  ),
                                  color: isDark
                                      ? const Color(0xff101010)
                                      : const Color(0xffFCFCFC),
                                ),
                                child: Text(
                                  "Key Specs",
                                  style: MyStyle.tx18Grey.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: themedata.tertiary,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),

                              // Specs List
                              _buildSpecRow("Car Make",
                                  model.carDetailsModel!.car!.maker!),
                              _buildSpecRow(
                                  "Model", model.carDetailsModel!.car!.model!),
                              _buildSpecRow(
                                  "Year", model.carDetailsModel!.car!.year!),
                              _buildSpecRow("Exterior color",
                                  model.carDetailsModel!.car!.color!),
                              _buildSpecRow("Drive train",
                                  model.carDetailsModel!.car!.driverTrain!),
                              _buildSpecRow("Transmission",
                                  model.carDetailsModel!.car!.transmission!),
                              _buildSpecRow("Engine",
                                  model.carDetailsModel!.car!.engine!),
                              _buildSpecRow(
                                  "VIN", model.carDetailsModel!.car!.vin!),
                              _buildSpecRow("Mileage",
                                  model.carDetailsModel!.car!.mileage!),
                            ],
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Buttons
                        Row(
                          children: [
                            OutlinedButton(
                              onPressed: () => Get.to(() => ScheduleInspection(
                                    data: {
                                      "image":
                                          model.carDetailsModel!.car!.carImage!,
                                      "title":
                                          model.carDetailsModel!.car!.title,
                                    },
                                  )),
                              style: OutlinedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                backgroundColor: themeProvider.isDarkMode()
                                    ? const Color(0xff131313)
                                    : const Color(0xffF9F9F9),
                                side: BorderSide(
                                    color: themeProvider.isDarkMode()
                                        ? const Color(0xff1B1B1B)
                                        : const Color(0xffE9EBF8),
                                    width: 0.6),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 21, vertical: 12),
                              ),
                              child: Text("Schedule Inspection",
                                  style: MyStyle.tx14Black.copyWith(
                                    fontFamily: 'SF Pro Rounded',
                                    color: themeProvider.isDarkMode()
                                        ? MyColor.mainWhiteColor
                                        : MyColor.dark01Color,
                                    fontWeight: FontWeight.w600,
                                  )),
                            ),
                            const SizedBox(width: 23),
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () => Get.to(() => BuyCarSummary(
                                      data: {
                                        "id": model.carDetailsModel!.car!.id,
                                        "image": model
                                            .carDetailsModel!.car!.carImage!,
                                        "title":
                                            model.carDetailsModel!.car!.title!,
                                        "price":
                                            model.carDetailsModel!.car!.price,
                                      },
                                    )),
                                style: OutlinedButton.styleFrom(
                                  side: BorderSide.none,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  backgroundColor: themeProvider.isDarkMode()
                                      ? const Color(0xff0B930B)
                                      : MyColor.greenColor,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 38, vertical: 12),
                                ),
                                child: Text("Buy Now",
                                    style: MyStyle.tx14Black.copyWith(
                                      fontFamily: 'SF Pro Rounded',
                                      color: MyColor.mainWhiteColor,
                                      fontWeight: FontWeight.w600,
                                    )),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 100),
                      ],
                    ),
                  ),
                )
                // Key Specs Header
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildSpecRow(String title, String value) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);

    final isDark = themeProvider.isDarkMode();
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: isDark ? const Color(0xff1B1B1B) : const Color(0xffE9EBF8),
            width: 0.5,
          ),
        ),
      ),
      padding: const EdgeInsets.only(right: 3, left: 7, top: 18, bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: MyStyle.tx14Green.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color:
                    isDark ? const Color(0xffD8DDF0) : const Color(0xff0F1427)),
          ),
          const SizedBox(width: 10),
          Text(value,
              style: MyStyle.tx14Grey.copyWith(color: MyColor.grey02Color)),
        ],
      ),
    );
  }
}
