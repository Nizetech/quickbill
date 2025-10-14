import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jost_pay_wallet/Provider/account_provider.dart';
import 'package:provider/provider.dart';

class ProfileImage extends StatelessWidget {
  final double size;
  const ProfileImage({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    final account = context.watch<AccountProvider>();
    return ClipRRect(
      borderRadius: BorderRadius.circular(size),
      child: CachedNetworkImage(
        imageUrl: account.profileImage,
        height: size,
        width: size,
        fit: BoxFit.cover,
        placeholder: (context, url) => ClipRRect(
          borderRadius: BorderRadius.circular(size),
          child: Image.asset(
            'assets/images/avatar.png',
            height: size,
            width: size,
          ),
        ),
        errorWidget: (context, url, error) => ClipRRect(
          borderRadius: BorderRadius.circular(size),
          child: Image.asset(
            'assets/images/avatar.png',
            height: size,
            width: size,
          ),
        ),
      ),
    );
  }
}
