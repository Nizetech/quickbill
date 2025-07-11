import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';

class StatusViewReceipt extends StatelessWidget {
  final String status;
  final VoidCallback onTap;
  final bool isServices;
  final bool isSocial;
  const StatusViewReceipt(
      {super.key,
      required this.status,
      required this.onTap,
      this.isSocial = false,
      this.isServices = false});

  @override
  Widget build(BuildContext context) {
    final themedata = Theme.of(context).colorScheme;
    bool isFailed(String status) {
      return status.contains('fail') ||
          status == '0' && !isServices ||
          isSocial && !status.toString().contains('success') ||
          isSocial && !status.toString().contains('processing') ||
          status.toString().contains('fail') ||
          status.toString().contains('cancel');
    }

    return Row(
      children: [
        CircleAvatar(
          radius: 7,
          backgroundColor:
              status.contains('pending') ||
                  isServices && status == '0' ||
                  status.contains('processing') ||
                  status.contains('waiting')
              ? MyColor.pending
              : isFailed(status)
                  ? Colors.red
                  : MyColor.dark01GreenColor,
          child: status.contains('pending') ||
                  isServices && status == '0' ||
                  status.contains('processing') ||
                  status.contains('waiting')
              ? SvgPicture.asset('assets/images/pending.svg')
              : Icon(
                  // status != '0' && !status.contains('pending') ||
                  //         status != '0' && !status.contains('fail') ||
                  //         status.toString().contains('cancel')
                  !isFailed(status)
                      ? Icons.done
                      : Icons.close,
                  size: 10,
                  color: Colors.white,
                ),
        ),
        const SizedBox(
          width: 8,
        ),
        GestureDetector(
          onTap: onTap,
          child: Container(
              width: 68,
              decoration: BoxDecoration(
                  color: themedata.secondary,
                  borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'View Receipt',
                      style: MyStyle.tx11Grey.copyWith(
                          color: MyColor.dark01GreenColor,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                  ],
                ),
              )),
        ),
      ],
    );
  }
}
