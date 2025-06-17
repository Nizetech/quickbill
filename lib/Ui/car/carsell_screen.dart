import 'package:flutter/material.dart';
import 'package:jost_pay_wallet/Provider/service_provider.dart';
import 'package:jost_pay_wallet/Provider/theme_provider.dart';
import 'package:jost_pay_wallet/Ui/car/widget/car_tile.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:provider/provider.dart';

class CarsellScreen extends StatefulWidget {
  const CarsellScreen({super.key});

  @override
  State<CarsellScreen> createState() => _CarsellScreenState();
}

class _CarsellScreenState extends State<CarsellScreen> {
  @override
  void initState() {
    super.initState();
    final model = Provider.of<ServiceProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (model.carListingModel == null) {
        model.getCarListing();
      } else {
        model.getCarListing(isLoading: false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    final themedata = Theme.of(context).colorScheme;
    return Scaffold(
        backgroundColor: themeProvider.isDarkMode()
            ? MyColor.dark02Color
            : MyColor.mainWhiteColor,
        body: Consumer<ServiceProvider>(builder: (context, model, _) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20)
                  .copyWith(bottom: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
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
                  const SizedBox(
                    height: 20,
                  ),
                  if (model.carListingModel != null)
                    Expanded(
                      child: ListView.separated(
                        itemCount: model.carListingModel!.cars!.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 18),
                        itemBuilder: (context, index) {
                          // if (index == 2) {
                          //   return const SizedBox(
                          //     height: 100,
                          //   );
                          // }
                          final car = model.carListingModel!.cars![index];
                          return CarTile(car: car);
                        },
                      ),
                    ),
                ],
              ),
            ),
          );
        }));
  }

}
