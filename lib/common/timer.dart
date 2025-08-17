import 'package:flutter/material.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';

class DeleteBanner extends StatefulWidget {
  const DeleteBanner({super.key});

  @override
  State<DeleteBanner> createState() => _DeleteBannerState();
}

class _DeleteBannerState extends State<DeleteBanner> {
  @override
  Widget build(BuildContext context) {
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
          Container(
            decoration: BoxDecoration(
              color: Color(0xff097B09),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: 5),
                _buildTimerItem('Days', '8'),
                _buildVerticalDivider(),
                _buildTimerItem('Hours', '10'),
                _buildVerticalDivider(),
                _buildTimerItem('Minutes', '00'),
                _buildVerticalDivider(),
                _buildTimerItem('Seconds', '00'),
                SizedBox(width: 5),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    'Activate Now',
                    style: MyStyle.tx12Black.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
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
      width: 1,
      height: 40,
      color: Colors.white,
    );
  }
}
