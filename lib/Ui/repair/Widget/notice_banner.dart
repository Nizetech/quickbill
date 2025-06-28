import 'package:flutter/material.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';

class NoticeBanner extends StatelessWidget {
  final String text;
  const NoticeBanner({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          color: MyColor.pending.withOpacity(.2),
          borderRadius: BorderRadius.circular(10)),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Container(
              width: 5,
              decoration: BoxDecoration(
                color: MyColor.redColor,
                borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(10),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Notice',
                      style: TextStyle(
                        fontSize: 16,
                        color: MyColor.redColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      text,
                      style: TextStyle(
                        fontSize: 12,
                        color: MyColor.grey,
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
