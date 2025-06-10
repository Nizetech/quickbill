import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/utils/toast.dart';
import 'package:url_launcher/url_launcher.dart';

class Helper {
  static final Helper dialogCall = Helper._();

  Helper._();

  showToast(context,String messages){
    Fluttertoast.showToast(
        msg: messages,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: MyColor.darkGrey01Color,
        textColor: MyColor.whiteColor,
        fontSize: 15.0
    );
  }


  showLoader(){
    return const Center(
        child: CircularProgressIndicator(
          color: MyColor.greenColor,
        )
    );
  }

  showAlertDialog(BuildContext context){
    AlertDialog alert =  AlertDialog(
      backgroundColor:MyColor.boarderColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      content: const Row(
        children: [
          CircularProgressIndicator(
            backgroundColor: Colors.white,
            valueColor: AlwaysStoppedAnimation<Color>(MyColor.greenColor),
          ),

          SizedBox(width: 20),
          Text("Loading...",
            style: TextStyle(
              fontSize: 18,
              color: MyColor.whiteColor,
            ),
          ),
        ],
      ),
    );
    showDialog(barrierDismissible: false,
      context:context,
      builder:(BuildContext context){
        return alert;
      },
    );
  }



}

String truncateEmail(String email) {
  // truncate the email before the '@' symbol and replace with ***** e.g '****@gmail.com'
  final List<String> parts = email.split('@');
  if (parts.length == 2) {
    return '${parts[0].substring(0, 3)}****@${parts[1]}';
  }
  return email;
}

void launchWeb(String url) async {
  await launchUrl(
    Uri.parse(url),
      mode: LaunchMode.inAppWebView,
      webViewConfiguration: WebViewConfiguration());
}

// open whatsapp
void openWhatsApp(String phoneNumber) async {
  String url = 'https://wa.me/$phoneNumber';
  await launchUrl(
    Uri.parse(url),
    mode: LaunchMode.externalApplication,
  );
}

// open email
void openEmail(String email) async {
  String url = 'mailto:$email';
  await launchUrl(
    Uri.parse(url),
    mode: LaunchMode.externalApplication,
  );
}

String formatNumber(
  num number,
) {
  final formatter = NumberFormat('#,##0.00');
  return formatter.format(number);
}

String formatNumberWithOutDecimal(String amount) {
  num number = num.parse(amount);
  final formatter = NumberFormat('#,##0');
  return formatter.format(number);
}

String formatDateTime(DateTime dateTime) {
  return DateFormat('MMMM d, h:mm a').format(dateTime);
}

String formatDate(DateTime dateTime) {
  return DateFormat('MMMM dd').format(dateTime);
}

String formatDateYear(DateTime dateTime) {
  return DateFormat('MMMM dd yyyy').format(dateTime);
}

// is today date
String isToday(DateTime date) {
  var diff = DateTime.now().difference(date);
  if (diff.inDays == 0) {
    return 'Today, ${formatDate(date)}';
  } else if (diff.inDays == 1) {
    return 'Yesterday, ${formatDate(date)}';
  } else {
    return formatDate(date);
  }
}


Future<bool> checkUploadSize(File selectedFile) async {
  int fileSizeInBytes = await selectedFile.length();
  // Check if file size is greater than 100KB
  if (fileSizeInBytes > 102400) {
    ErrorToast(
      'The file size exceeds 100KB. Please select a smaller file.',
    );
    return false;
  }
  return true;
}
