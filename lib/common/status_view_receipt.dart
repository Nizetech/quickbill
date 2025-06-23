import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';

class StatusViewReceipt extends StatelessWidget {
  final String status;
  final VoidCallback onTap;
  const StatusViewReceipt(
      {super.key, required this.status, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final themedata = Theme.of(context).colorScheme;
    return Row(
      children: [
        
        CircleAvatar(
          radius: 7,
          backgroundColor:
          
         
            status.contains('pending')
              ? MyColor.pending
              : status.contains('fail') || status == '0' 
                  ? Colors.red
                  : MyColor.dark01GreenColor,
          child: status.contains('pending')
              ? SvgPicture.asset('assets/images/pending.svg')
              : Icon(
                                    
                  status != '0' && !status.contains('pending') ||
                          status != '0' && !status.contains('fail')
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
