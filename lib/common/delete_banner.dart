import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jost_pay_wallet/Ui/kyc/kyc_verification.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';

class DeleteBanner extends StatefulWidget {
  final String date;
  const DeleteBanner({super.key, required this.date});

  @override
  State<DeleteBanner> createState() => _DeleteBannerState();
}

class _DeleteBannerState extends State<DeleteBanner> {
  late DateTime targetDate;
  Duration timeLeft = Duration.zero;
  Timer? timer;
  bool isElapsed = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      DateTime baseDate = DateTime.parse(widget.date);
      targetDate = baseDate.add(const Duration(days: 14));
      _updateTimeLeft();
      _startTimer();
    });
  }

  void _startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        _updateTimeLeft();
      }
    });
  }

  void _updateTimeLeft() {
    final now = DateTime.now();
    final difference = targetDate.difference(now);

    setState(() {
      if (difference.isNegative) {
        // Target date has elapsed
        isElapsed = true;
        timeLeft = Duration.zero;
        timer?.cancel(); // stop timer
      } else {
        isElapsed = false;
        timeLeft = difference;
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final days = timeLeft.inDays;
    final hours = timeLeft.inHours % 24;
    final minutes = timeLeft.inMinutes % 60;
    final seconds = timeLeft.inSeconds % 60;
    log('isElapsed: $isElapsed');

    return Container(
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.symmetric(horizontal: 16),
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            'assets/images/timer_bg.png',
          ),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Text(
            'Important: You have the following time frame left to activate your bank wallet, or your account will be permanently deleted.',
            style: MyStyle.tx16Black.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: Color(0xff097B09),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildTimerItem('Days', days.toString()),
                      _buildVerticalDivider(),
                      _buildTimerItem('Hours', hours.toString()),
                      _buildVerticalDivider(),
                      _buildTimerItem('Minutes', minutes.toString()),
                      _buildVerticalDivider(),
                      _buildTimerItem('Seconds', seconds.toString()),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 5),
              GestureDetector(
                onTap: () {
                  Get.to(KycVerification());
                },
                child: Container(
                  height: 52,
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: Color(0xff097B09),
                    borderRadius: BorderRadius.circular(10),
                    border: Border(
                      right: BorderSide(
                        color: Colors.white,
                        width: 1,
                      ),
                    ),
                  ),
                  child: Text(
                    'Activate Now',
                    style: MyStyle.tx12Black.copyWith(
                      color: MyColor.mainWhiteColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildTimerItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Text(
            value,
            style: MyStyle.tx14Black.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            label,
            style: MyStyle.tx12Black.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  _buildVerticalDivider() {
    return Container(
      width: .5,
      height: 52,
      color: Colors.white,
    );
  }
}
