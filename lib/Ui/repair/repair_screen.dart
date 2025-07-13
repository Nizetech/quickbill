import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jost_pay_wallet/Provider/service_provider.dart';
import 'package:jost_pay_wallet/Provider/theme_provider.dart';
import 'package:jost_pay_wallet/Ui/repair/Widget/notice_banner.dart';
import 'package:jost_pay_wallet/Ui/repair/Widget/repair_option_sheet.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:jost_pay_wallet/Values/utils.dart';
import 'package:jost_pay_wallet/common/text_field.dart';
import 'package:jost_pay_wallet/utils/toast.dart';
import 'package:provider/provider.dart';

class RepairScreen extends StatefulWidget {
  const RepairScreen({super.key});

  @override
  State<RepairScreen> createState() => _RepairScreenState();
}

class _RepairScreenState extends State<RepairScreen> {
  final now = DateTime.now();
  String? selectedDate;
  @override
  void initState() {
    super.initState();
    date.text = DateFormat('E, MM yyyy').format(now);
    selectedDate = DateFormat('yyyy-MM-dd').format(now);
  }

  final repairOption = TextEditingController();
  final status = TextEditingController();
  final make = TextEditingController();
  final carModel = TextEditingController();
  final year = TextEditingController();
  final info = TextEditingController();
  final date = TextEditingController();
  final agentContact = TextEditingController();
  final agentName = TextEditingController();
  int partProcureindex = -1;
  int partReplacedIndex = -1;
  int optionIndex = -1;
  List<Map> partProcure = [
    {
      "title": "Company-Handled Procurement",
      "subtitle": "We take care ofsourcing and purchasing the parts for you",
    },
    {
      "title": "Self Procurement",
      "subtitle":
          "You source and purchase the required parts and accessories yourself, paying only for our services",
    },
  ];
  List<Map> replacedPart = [
    {
      "title": "Discard ",
      "subtitle": "We will dispose of the replaced part",
    },
    {
      "title": "Provide",
      "subtitle": "We will return the replaced part to you",
    },
  ];

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    final isDark = themeProvider.isDarkMode();
    final themedata = Theme.of(context).colorScheme;
    return Scaffold(
        backgroundColor: themeProvider.isDarkMode()
            ? MyColor.dark02Color
            : MyColor.mainWhiteColor,
        body: Consumer<ServiceProvider>(builder: (context, model, _) {
          return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 68)
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
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 17,
                          ),
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
                            alignment: Alignment.center,
                            child: Text(
                              "Choose Your Repair Option",
                              style: MyStyle.tx20Grey.copyWith(
                                fontWeight: FontWeight.w400,
                                color: themedata.tertiary,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          GestureDetector(
                            onTap: () {
                              selectRepaireOption(
                                themeProvider: themeProvider,
                                onSelect: (value) {
                                  repairOption.text = value;
                                  optionIndex = value == "Vehicle Repair"
                                      ? 0
                                      : value == "General Serving"
                                          ? 1
                                          : 2;
                                  setState(() {});
                                },
                              );
                            },
                            child: CustomTextField(
                              controller: repairOption,
                              text: "Select Repair Options",
                              suffixIcon: Icons.expand_more,
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text("Appointment/Pickup date",
                                style: MyStyle.tx16Black.copyWith(
                                  fontFamily: 'SF Pro Rounded',
                                  color: const Color(0xff6B7280),
                                  fontWeight: FontWeight.w400,
                                )),
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          GestureDetector(
                            onTap: () async {
                              final selected = await showDatePicker(
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
                              if (selected != null) {
                                date.text =
                                    DateFormat('E, MM yyyy').format(selected);
                                selectedDate =
                                    DateFormat('yyyy-MM-dd').format(selected);
                                setState(() {});
                              }
                            },
                            child: CustomTextField(
                              text: "Date",
                              asset: "assets/images/svg/calendar.svg",
                              controller: date,
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text("Vehicle Status",
                                          style: MyStyle.tx16Black.copyWith(
                                            fontFamily: 'SF Pro Rounded',
                                            color: const Color(0xff6B7280),
                                            fontWeight: FontWeight.w400,
                                          )),
                                    ),
                                    const SizedBox(
                                      height: 7,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        statusSheet(
                                            themeProvider: themeProvider,
                                            onSelect: (value) {
                                              status.text = value;
                                              setState(() {});
                                            });
                                        log('${status.text}');
                                      },
                                      child: CustomTextField(
                                        text: "Select",
                                        suffixIcon: Icons.expand_more,
                                        controller: status,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text("Vehicle Make",
                                          style: MyStyle.tx16Black.copyWith(
                                            fontFamily: 'SF Pro Rounded',
                                            color: const Color(0xff6B7280),
                                            fontWeight: FontWeight.w400,
                                          )),
                                    ),
                                    const SizedBox(
                                      height: 7,
                                    ),
                                    CustomTextField(
                                      enabled: true,
                                      controller: make,
                                      text: "Toyota",
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          if (optionIndex == 2 && status.text.isNotEmpty)
                            NoticeBanner(
                                text: status.text
                                        .toLowerCase()
                                        .contains('drive')
                                    ? "A non-refundable N5,000 pick-up fee applies\nIf the vehicle has no petrol, fuel will be purchased and added to the invoice \nIf the vehicle is without a key or battery, we will provide a replacement brand new battery or create a new key as needed, and th invoice will be updated accordingly. \nIf the vehicle cannot move, a towing service will be arranged and the cost will be added to the invoice."
                                    : "A non-refundable N5,000 pick-up fee applies \nAn additional towing charge will be added to the invoice")
                          else
                            SizedBox(
                              height: 16,
                            ),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text("Vehicle Model",
                                          style: MyStyle.tx16Black.copyWith(
                                            fontFamily: 'SF Pro Rounded',
                                            color: const Color(0xff6B7280),
                                            fontWeight: FontWeight.w400,
                                          )),
                                    ),
                                    const SizedBox(
                                      height: 7,
                                    ),
                                    CustomTextField(
                                      text: "Camry",
                                      controller: carModel,
                                      enabled: true,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text("Vehicle Year",
                                          style: MyStyle.tx16Black.copyWith(
                                            fontFamily: 'SF Pro Rounded',
                                            color: const Color(0xff6B7280),
                                            fontWeight: FontWeight.w400,
                                          )),
                                    ),
                                    const SizedBox(
                                      height: 7,
                                    ),
                                    CustomTextField(
                                      text: "2022",
                                      controller: year,
                                      keyboardType: TextInputType.number,
                                      enabled: true,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          if (optionIndex == 2) ...[
                            Text(
                              'Clearing Agent',
                              style: MyStyle.tx16Black.copyWith(
                                color: themedata.tertiary,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text("Contact Number",
                                style: MyStyle.tx16Black.copyWith(
                                  fontFamily: 'SF Pro Rounded',
                                  color: const Color(0xff6B7280),
                                  fontWeight: FontWeight.w400,
                                )),
                            const SizedBox(height: 5),
                            CustomTextField(
                              text: "",
                              keyboardType: TextInputType.number,
                              controller: agentContact,
                              enabled: true,
                            ),
                            const SizedBox(height: 16),
                            Text("Name",
                                style: MyStyle.tx16Black.copyWith(
                                  fontFamily: 'SF Pro Rounded',
                                  color: const Color(0xff6B7280),
                                  fontWeight: FontWeight.w400,
                                )),
                            const SizedBox(height: 5),
                            CustomTextField(
                              text: "",
                              controller: agentName,
                              enabled: true,
                            ),
                            SizedBox(height: 16),
                          ],
                          Text(
                            'Part & Accessory Procurement',
                            style: MyStyle.tx16Black.copyWith(
                              color: themedata.tertiary,
                            ),
                          ),
                          const SizedBox(height: 16),
                          ...partProcure.map((e) {
                            final index = partProcure.indexOf(e);
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: Radio<int>(
                                    activeColor: MyColor.greenColor,
                                    fillColor: MaterialStateProperty.all(
                                        MyColor.greenColor),
                                    value: index,
                                    groupValue: partProcureindex,
                                    onChanged: (value) {
                                      setState(() {
                                        partProcureindex = value!;
                                      });
                                    },
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: Text.rich(
                                      TextSpan(
                                          text: e['title'],
                                          style: MyStyle.tx14Black.copyWith(
                                            fontFamily: 'SF Pro Rounded',
                                            color: MyColor.blackColor,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          children: [
                                            TextSpan(
                                              text: ' (${e['subtitle']})',
                                              style: MyStyle.tx14Black.copyWith(
                                                fontFamily: 'SF Pro Rounded',
                                                color: MyColor.grey,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ]),
                                      // textAlign: TextAlign.center,
                                    ),
                                  ),
                                )
                              ],
                            );
                          }),
                          if (partProcureindex == 1)
                            NoticeBanner(
                              text:
                                  '''When selecting Self Procurement, you are required to deliver the requested parts within 48 hours (2 days) from the time the part request is updated \n\nFailure to deliver the parts within this timeframe will result in a storage fee of 5,000 NGN per day for the delay and storage of your vehicle. \n\nThese charges will continue to accrue until the parts are received \nOnce the parts are delivered, the accumulated storage and delay charges will be applied to your account''',
                            ),
                          if (optionIndex != 2) ...[
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text("Additional Information",
                                  style: MyStyle.tx16Black.copyWith(
                                    fontFamily: 'SF Pro Rounded',
                                    color: const Color(0xff6B7280),
                                    fontWeight: FontWeight.w400,
                                  )),
                            ),
                            const SizedBox(height: 5),
                            CustomTextField(
                              text: "Additional Information",
                              minlines: 5,
                              controller: info,
                              enabled: true,
                            ),
                          ],
                          ...[
                            const SizedBox(
                              height: 16,
                            ),
                            Text(
                              'Replace Part Handling',
                              style: MyStyle.tx16Black.copyWith(
                                color: themedata.tertiary,
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            ...replacedPart.map((e) {
                              final index = replacedPart.indexOf(e);
                              return Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: Radio<int>(
                                      activeColor: MyColor.greenColor,
                                      fillColor: MaterialStateProperty.all(
                                          MyColor.greenColor),
                                      value: index,
                                      groupValue: partReplacedIndex,
                                      onChanged: (value) {
                                        setState(() {
                                          partReplacedIndex = value!;
                                        });
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 10),
                                      child: Text.rich(
                                        TextSpan(
                                            text: e['title'],
                                            style: MyStyle.tx14Black.copyWith(
                                              fontFamily: 'SF Pro Rounded',
                                              color: MyColor.blackColor,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            children: [
                                              TextSpan(
                                                text: ' (${e['subtitle']})',
                                                style:
                                                    MyStyle.tx14Black.copyWith(
                                                  fontFamily: 'SF Pro Rounded',
                                                  color: MyColor.grey,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ]),
                                        // textAlign: TextAlign.center,
                                      ),
                                    ),
                                  )
                                ],
                              );
                            }),
                          ],
                          if (optionIndex == 2)
                            Container(
                              margin: EdgeInsets.only(top: 20),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 15),
                              decoration: BoxDecoration(
                                border: Border(
                                  top: BorderSide(
                                      color: MyColor.grey, width: .2),
                                  bottom: BorderSide(
                                      color: MyColor.grey, width: .2),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Total',
                                      style: MyStyle.tx16Black.copyWith(
                                        color: themedata.tertiary,
                                        fontWeight: FontWeight.w600,
                                      )),
                                  Text('${Utils.naira}5,000',
                                      style: MyStyle.tx16Black.copyWith(
                                        color: themedata.tertiary,
                                        fontWeight: FontWeight.w600,
                                      ))
                                ],
                              ),
                            ),
                          const SizedBox(
                            height: 50,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: OutlinedButton(
                              onPressed: () {
                                if (optionIndex == 2 &&
                                        agentContact.text.isEmpty ||
                                    optionIndex == 2 &&
                                        agentName.text.isEmpty ||
                                    repairOption.text.isEmpty ||
                                    date.text.isEmpty ||
                                    status.text.isEmpty ||
                                    make.text.isEmpty ||
                                    carModel.text.isEmpty ||
                                    year.text.isEmpty ||
                                    partProcureindex == -1 ||
                                    partReplacedIndex == -1) {
                                  ErrorToast("Please fill all the fields");
                                }
                                {
                                  Map<String, dynamic> data = {
                                    "repair_type": repairOption.text,
                                    "appointment_pickup_date": selectedDate,
                                    "vehicle_status": status.text,
                                    "vehicle_make": make.text,
                                    "vehicle_model": carModel.text,
                                    "vehicle_year": year.text,
                                    "part_accessory_procurement":
                                        partProcure[partProcureindex]['title'],
                                    // if (optionIndex == 1)
                                    "additional_info": info.text,
                                    "replaced_part_handling":
                                        replacedPart[partReplacedIndex]
                                            ['title'],
                                    // if (optionIndex == 2) ...{
                                    "agent_contact_number": agentContact.text,
                                    "agent_contact_name": agentName.text,
                                    // }
                                  };
                                  log("data: $data");
                                  // return;
                                  model.buyRepaires(data, callback: () {
                                    repairOption.clear();
                                    date.clear();
                                    status.clear();
                                    make.clear();
                                    carModel.clear();
                                    year.clear();
                                    partProcureindex = -1;
                                    partReplacedIndex = -1;
                                    info.clear();
                                    agentContact.clear();
                                    agentName.clear();
                                  });
                                }
                              },
                              style: OutlinedButton.styleFrom(
                                side: BorderSide.none,
                                backgroundColor: themeProvider.isDarkMode()
                                    ? const Color(0xff0B930B)
                                    : MyColor.greenColor,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 24, vertical: 11),
                              ),
                              child: Text("Schedule Appointment/Pickup",
                                  style: MyStyle.tx16Black.copyWith(
                                    fontFamily: 'SF Pro Rounded',
                                    color: MyColor.mainWhiteColor,
                                    fontWeight: FontWeight.w500,
                                  )),
                            ),
                          ),
                          const SizedBox(
                            height: 60,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ));
        }));
  }
}
