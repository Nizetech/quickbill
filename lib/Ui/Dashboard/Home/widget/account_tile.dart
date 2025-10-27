import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:quick_bills/Provider/account_provider.dart';
import 'package:quick_bills/Values/Helper/helper.dart';
import 'package:quick_bills/Values/MyColor.dart';
import 'package:quick_bills/Values/MyStyle.dart';
import 'package:quick_bills/constants/constants.dart';
import 'package:provider/provider.dart';

class DashboardTile extends StatefulWidget {
  const DashboardTile({super.key});

  @override
  State<DashboardTile> createState() => _DashboardTileState();
}

class _DashboardTileState extends State<DashboardTile> {
  bool isVisible = true;
  final box = Hive.box(kAppName);
  @override
  void initState() {
    super.initState();
    isVisible = box.get(kIsVisibleBalance, defaultValue: true);
  }

  @override
  Widget build(BuildContext context) {
    final account = context.read<AccountProvider>();
    return Container(
      height: 110,
      width: double.infinity,
      padding: const EdgeInsets.only(left: 24.0, right: 12.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(
              image: AssetImage('assets/images/amount_frame.png'),
              fit: BoxFit.cover)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            isVisible ? '₦ ${formatNumber(account.balance ?? 0)}' : '₦ ****',
            style: MyStyle.tx28Black
                .copyWith(fontSize: 26, color: MyColor.whiteColor),
          ),
          SizedBox(width: 10),
          InkWell(
            onTap: () {
              setState(() {
                isVisible = !isVisible;
              });
              box.put(kIsVisibleBalance, isVisible);
            },
            child: Icon(!isVisible ? Icons.visibility : Icons.visibility_off,
                color: MyColor.whiteColor),
          ),
        ],
      ),
    );
  }
}
