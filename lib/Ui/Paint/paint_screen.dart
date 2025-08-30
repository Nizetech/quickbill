import 'dart:convert';
import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:jost_pay_wallet/Models/car_type_model.dart';
import 'package:jost_pay_wallet/Provider/service_provider.dart';
import 'package:jost_pay_wallet/Provider/theme_provider.dart';
import 'package:jost_pay_wallet/Ui/Paint/widget/option_summary.dart';
import 'package:jost_pay_wallet/Ui/Paint/widget/rent_option.dart';
import 'package:jost_pay_wallet/Values/Helper/helper.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:jost_pay_wallet/common/text_field.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';

class PaintScreen extends StatefulWidget {
  const PaintScreen({super.key});

  @override
  State<PaintScreen> createState() => _PaintScreenState();
}

class _PaintScreenState extends State<PaintScreen> {
  final carType = TextEditingController();
  final option = TextEditingController();
  final date = TextEditingController();
  final time = TextEditingController();
  Car? selectedCar;

  final now = DateTime.now();
  final nowTime = TimeOfDay.now();
 
  File? selectedFile;
  String total = '';
  String boothPrice = '';
  int rentType = -1;
  DateTime? selectedDate;
  String base64Image = '';
  Future<String> fileToBase64(File file) async {
    final bytes = await file.readAsBytes();
    return base64Encode(bytes);
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    final themedata = Theme.of(context).colorScheme;
    final isDark = themeProvider.isDarkMode();
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
                      'Paint',
                      style:
                          MyStyle.tx18Black.copyWith(color: themedata.tertiary),
                    ),
                  ),
                  const Spacer(), // Adds flexible space after the text
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
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
                          "Choose Your Rental Option",
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
                          showModalBottomSheet(
                              barrierColor: Colors.blueGrey.withOpacity(.5),
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20),
                              )),
                              context: context,
                              builder: (context) {
                                return Container(
                                  decoration: BoxDecoration(
                                      color: themeProvider.isDarkMode()
                                          ? MyColor.dark02Color
                                          : MyColor.mainWhiteColor,
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(20),
                                      )),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SizedBox(height: 16),
                                      Text(
                                        'Choose Rental Option',
                                        style: MyStyle.tx18Black.copyWith(
                                            color: themedata.tertiary),
                                      ),
                                      RentOption(
                                        title: 'Rent Spray Booth',
                                        amount:
                                        selectedCar != null
                                            ? "N ${formatNumber((num.parse(model.carTypeModel!.booth!)
                                                //  + num.parse(selectedCar!.price15!)
                                                + num.parse(selectedCar!.price!)))} /hr"
                                            :
                                            "N ${formatNumber(num.parse(model.carTypeModel!.booth!))} /hr",
                                        onTap: () {
                                          Navigator.pop(context);
                                          setState(() {
                                            if (selectedCar != null) {
                                              total = formatNumber(num.parse(
                                                      model.carTypeModel!
                                                          .booth!) +
                                                  // num.parse(
                                                  //     selectedCar!.price15!) +
                                                  num.parse(
                                                      selectedCar!.price!));
                                              option.text =
                                                  "Spray Booth ${formatNumber(
                                                num.parse(model
                                                        .carTypeModel!.booth!) +
                                                    // num.parse(
                                                    //     selectedCar!.price15!) +
                                                    num.parse(
                                                        selectedCar!.price!),
                                              )} /hr";
                                            } else {
                                            option.text =
                                                "Spray Booth ${formatNumber(num.parse(model.carTypeModel!.booth!))} /hr";

                                            total = formatNumber(num.parse(
                                                model.carTypeModel!.booth!));
                                            }
                                            rentType = 1;
                                          });
                                        },
                                      ),
                                      RentOption(
                                        title: 'Rent Air Compressor',
                                        amount:
                                            "N ${formatNumber(num.parse(model.carTypeModel!.compressor!))} /75CL",
                                        onTap: () {
                                          Navigator.pop(context);
                                          setState(() {
                                            option.text =
                                                "Air Compressor ${formatNumber(num.parse(model.carTypeModel!.compressor!))} /75CL";
                                            total = formatNumber(num.parse(model
                                                .carTypeModel!.compressor!));
                                            rentType = 2;
                                          });
                                        },
                                      ),
                                      RentOption(
                                        title:
                                            'Rent both Spray Booth & Compressor',
                                        amount: selectedCar != null
                                            ? "N ${formatNumber(
                                                num.parse(model
                                                        .carTypeModel!.booth!) +
                                                    // num.parse(
                                                    //     selectedCar!.price15!) +
                                                    num.parse(
                                                        selectedCar!.price!) +
                                                    num.parse(model
                                                        .carTypeModel!
                                                        .compressor!),
                                              )} /hr"
                                            :
                                            "N ${formatNumber(num.parse(model.carTypeModel!.booth!) + num.parse(model.carTypeModel!.compressor!))} /hr",
                                        onTap: () {
                                          Navigator.pop(context);
                                          setState(() {
                                            if (selectedCar != null) {
                                              total = formatNumber(num.parse(
                                                      model.carTypeModel!
                                                          .booth!) +
                                                  // num.parse(
                                                  //     selectedCar!.price15!) +
                                                  num.parse(
                                                      selectedCar!.price!) +
                                                  num.parse(model.carTypeModel!
                                                      .compressor!));
                                              option.text =
                                                  "Booth & Compressor ${formatNumber(
                                                num.parse(model
                                                        .carTypeModel!.booth!) +
                                                    // num.parse(
                                                    //     selectedCar!.price15!) +
                                                    num.parse(
                                                        selectedCar!.price!) +
                                                    num.parse(model
                                                        .carTypeModel!
                                                        .compressor!),
                                              )}";
                                            } else {
                                            option.text =
                                                "Booth & Compressor ${formatNumber(num.parse(model.carTypeModel!.booth!) + num.parse(model.carTypeModel!.compressor!))}";
                                            total = formatNumber(num.parse(model
                                                    .carTypeModel!.booth!) +
                                                num.parse(model.carTypeModel!
                                                    .compressor!));
                                            }
                                            rentType = 3;
                                          });
                                        },
                                      ),
                                      SizedBox(height: 16),
                                    ],
                                  ),
                                );
                              });
                        },
                        child: CustomTextField(
                          text: "Choose Option",
                          controller: option,
                          suffixIcon: Icons.expand_more,
                          enabled: false,
                        ),
                      ),
                      const SizedBox(
                        height: 31,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Select car type",
                            style: MyStyle.tx16Black.copyWith(
                              fontFamily: 'SF Pro Rounded',
                              color: const Color(0xff6B7280),
                              fontWeight: FontWeight.w400,
                            )),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                              barrierColor: Colors.blueGrey.withOpacity(.5),
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20),
                              )),
                              context: context,
                              builder: (context) {
                                return Container(
                                  decoration: BoxDecoration(
                                      color: themeProvider.isDarkMode()
                                          ? MyColor.dark02Color
                                          : MyColor.mainWhiteColor,
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(20),
                                      )),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SizedBox(height: 16),
                                      Text(
                                        'Select car type',
                                        style: MyStyle.tx18Black.copyWith(
                                            color: themedata.tertiary),
                                      ),
                                      Expanded(
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          itemCount:
                                              model.carTypeModel!.cars!.length,
                                          itemBuilder: (_, i) => ListTile(
                                            onTap: () {
                                              Navigator.pop(context);
                                              setState(() {
                                                selectedCar = model
                                                    .carTypeModel!.cars![i];
                                                carType.text =
                                                    selectedCar!.name!;
                                                if (rentType == 1) {
                                                  total = formatNumber(
                                                      num.parse(selectedCar!
                                                              .price!) +
                                                      // num.parse(selectedCar!
                                                      //     .price15!) +
                                                          num.parse(model
                                                              .carTypeModel!
                                                              .booth!));
                                                  option.text =
                                                      "Spray Booth ${formatNumber(
                                                    num.parse(selectedCar!
                                                            .price!) +
                                                        // num.parse(selectedCar!
                                                        //     .price15!) +
                                                        num.parse(model
                                                            .carTypeModel!
                                                            .booth!),
                                                  )}";
                                                } else if (rentType == 3) {
                                                  total = formatNumber(
                                                      num.parse(selectedCar!
                                                              .price!) +
                                                      // num.parse(selectedCar!
                                                      //     .price15!) +
                                                          num.parse(model
                                                              .carTypeModel!
                                                              .booth!) +
                                                          num.parse(model
                                                              .carTypeModel!
                                                              .compressor!));
                                                  option.text =
                                                      "Booth & Compressor ${formatNumber(
                                                    num.parse(model
                                                            .carTypeModel!
                                                            .booth!) +
                                                        // num.parse(selectedCar!
                                                        //     .price15!) +
                                                        num.parse(selectedCar!
                                                            .price!) +
                                                        num.parse(model
                                                            .carTypeModel!
                                                            .compressor!),
                                                  )}";
                                                }
                                              });
                                            },
                                            title: Text(
                                              model
                                                  .carTypeModel!.cars![i].name!,
                                              style: MyStyle.tx18Black.copyWith(
                                                  color: themedata.tertiary),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              });
                        },
                        child: CustomTextField(
                          text: "Select",
                          controller: carType,
                          suffixIcon: Icons.expand_more,
                          enabled: false,
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Select date",
                            style: MyStyle.tx16Black.copyWith(
                              fontFamily: 'SF Pro Rounded',
                              color: const Color(0xff6B7280),
                              fontWeight: FontWeight.w400,
                            )),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime(60000),
                              builder: (context, child) {
                                return Theme(
                                  data: Theme.of(context).copyWith(
                                    colorScheme: ColorScheme.light(
                                      primary: MyColor.progressBar,
                                    ),
                                    dialogBackgroundColor:
                                        MyColor.mainWhiteColor,
                                  ),
                                  child: child!,
                                );
                              }).then((value) {
                            if (value != null) {
                            setState(() {
                                date.text = dateFormat.format(value);
                                selectedDate = value;
                              });
                            }
                          });
                        },
                        child: CustomTextField(
                          controller: date,
                          text: "Select Date",
                          suffixIcon: Icons.expand_more,
                          enabled: false,
                        ),
                      ),
                      
                      const SizedBox(
                        height: 16,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Time",
                            style: MyStyle.tx16Black.copyWith(
                              fontFamily: 'SF Pro Rounded',
                              color: const Color(0xff6B7280),
                              fontWeight: FontWeight.w400,
                            )),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                              builder: (context, child) {
                                return Theme(
                                  data: Theme.of(context).copyWith(
                                    colorScheme: const ColorScheme.light(
                                      primary: MyColor.progressBar,
                                    ),
                                    dialogBackgroundColor:
                                        MyColor.mainWhiteColor,
                                  ),
                                  child: child!,
                                );
                              }).then((value) {
                            setState(() {
                              time.text = value!.format(context);
                            });
                          });
                        },
                        child: CustomTextField(
                          text: "Select Time",
                          controller: time,
                          suffixIcon: Icons.expand_more,
                          enabled: false,
                        ),
                      ),
                     
                      const SizedBox(
                        height: 16,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Upload Car Photo",
                            style: MyStyle.tx14Black.copyWith(
                              fontSize: 17,
                              color: themedata.tertiary,
                              fontWeight: FontWeight.w500,
                            )),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      DottedBorder(
                        borderType: BorderType.RRect,
                        radius: const Radius.circular(8),
                        color: isDark
                            ? const Color(0xff0B930B)
                            : MyColor.greenColor,
                        strokeWidth: 1,
                        dashPattern: const [6, 3],
                        child: selectedFile != null
                            ? Image.file(
                                selectedFile!,
                                height: 150,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              )
                            : Container(
                          height: 150,
                          width: double.infinity,
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(isDark
                                  ? "assets/images/svg/upload-dark.svg"
                                  : "assets/images/svg/upload.svg"),
                              const SizedBox(height: 10),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  foregroundColor: Colors.black87,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side: BorderSide(
                                        color: isDark
                                            ? const Color(0xff1B1B1B)
                                            : const Color(0xffE9EBF8)),
                                  ),
                                  elevation: 0,
                                ),
                                onPressed: () async {

                                        await FilePicker.platform.pickFiles(
                                          type: FileType.image,
                                       
                                        ).then((value) async {
                                          if (value != null) {
                                            // File file =
                                            //     File(value.files.single.path!);
                                            // Check the file size
                                            // bool enoughSpace =
                                            //     await checkUploadSize(
                                            //   file,
                                            // );
                                            // if (enoughSpace) {
                                            setState(() {
                                              selectedFile =
                                                  File(value.files.first.path!);
                                            });
                                            base64Image = await fileToBase64(
                                                selectedFile!);
                                            model.updateImage(base64Image);
                                            // }
                                          }
                                        });
                                },
                                child: Text(
                                  'Browse files',
                                  style: MyStyle.tx18Grey.copyWith(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 11,
                                    color: themedata.tertiary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                              color: isDark
                                  ? const Color(0xff1B1B1B)
                                  : const Color(0xffE9EBF8)),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    selectedFile == null
                                        ? "Only support jpg & png"
                                        : 'Uploaded',
                                    style: MyStyle.tx12Black.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: themedata.tertiary),
                                  ),
                            
                                  const SizedBox(height: 10),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(94),
                                    child: LinearProgressIndicator(
                                      value: selectedFile == null ? 0 : 1,
                                      backgroundColor: isDark
                                          ? const Color(0xff121212)
                                          : const Color(0xffFAFAFA),
                                      color: isDark
                                          ? MyColor.greenColor
                                          : const Color(0xff1849D6),
                                      minHeight: 9,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (selectedFile != null) ...[
                              const SizedBox(width: 10),
                            GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedFile = null;
                                  });
                                },
                              child: SvgPicture.asset(
                                isDark
                                    ? "assets/images/svg/close-dark.svg"
                                    : "assets/images/svg/close.svg",
                                height: 24,
                                width: 24,
                              ),
                              ),
                            ]
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 36,
                      ),
                      OptionSummary(
                        date: selectedDate,
                        time: time.text,
                        price15: selectedCar == null
                            ? 0
                            : num.parse(selectedCar!.price15!),
                        total: total,
                        image: model.base64Image,
                        rentType: rentType,
                        carType: carType.text,
                      ),
                      const SizedBox(
                        height: 60,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }
      ),
    );
  }
}

final dateFormat = DateFormat("EEE, MMMM d yyyy");
