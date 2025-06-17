import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:jost_pay_wallet/common/button.dart';
import 'package:jost_pay_wallet/common/text_field.dart';
import 'package:provider/provider.dart';

import '../../Provider/account_provider.dart';

class ScheduleInspection extends StatefulWidget {
  final Map<String, dynamic> data;
  const ScheduleInspection({super.key, required this.data});

  @override
  State<ScheduleInspection> createState() => _ScheduleInspectionState();
}

class _ScheduleInspectionState extends State<ScheduleInspection> {
  final name = TextEditingController();
  final phone = TextEditingController();
  final date = TextEditingController();
  @override
  void initState() {
    super.initState();
    final auth = Provider.of<AccountProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      name.text =
          '${auth.userModel!.user!.firstName!} ${auth.userModel!.user!.lastName!}';
      phone.text = auth.userModel!.user!.phoneNumber!;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final themedata = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Schedule Inspection",
          style: TextStyle(color: themedata.tertiary),
        ),
        leading: BackBtn(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: widget.data['image'],
                height: 100,
                width: 150,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(),
                errorWidget: (context, url, error) => Container(),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Title",
                  style: MyStyle.tx16Black.copyWith(
                    color: themedata.tertiary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  widget.data['title'],
                  style: TextStyle(
                    color: themedata.tertiary,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              "Name",
              style: MyStyle.tx16Black.copyWith(
                color: themedata.tertiary,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 10),
            CustomTextField(
              controller: name,
              text: 'Enter your full name',
            ),
            const SizedBox(height: 20),
            Text(
              "Phone",
              style: MyStyle.tx16Black.copyWith(
                color: themedata.tertiary,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 10),
            CustomTextField(
              controller: phone,
              text: 'Enter your phone number',
            ),
            const SizedBox(height: 20),
            Text(
              "Date",
              style: MyStyle.tx16Black.copyWith(
                color: themedata.tertiary,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                var selectedDate = showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(50000),
                    builder: (context, child) {
                      return Theme(
                        data: ThemeData.dark(),
                        child: child!,
                      );
                    });
                selectedDate.then((value) {
                  date.text = "${value!.month}/${value.day}/${value.year}";
                  setState(() {});
                });
              },
              child: CustomTextField(
                controller: date,
                enabled: false,
                text: 'mm/dd/yyyy',
                suffixIcon: Icons.calendar_month_outlined,
              ),
            ),
            const SizedBox(height: 40),
            CustomButton(
              text: 'Submit',
              onTap: () {},
            )
          ],
        ),
      ),
    );
  }
}
