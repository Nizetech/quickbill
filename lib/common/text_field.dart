import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iconsax/iconsax.dart';
import 'package:jost_pay_wallet/Provider/theme_provider.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:jost_pay_wallet/Values/NewColor.dart';
import 'package:provider/provider.dart';

class CustomTextField extends StatefulWidget {
  final String text;
  final IconData? suffixIcon;
  final Widget? preffixIcon;
  final IconData? preffixIconData;
  final bool isAuth;
  final String? asset;
  final bool enabled;
  final bool isPassword;
  final FocusNode? focusNode;
  final VoidCallback? onTap;
  final TextInputType keyboardType;
  final int? minlines;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  const CustomTextField({
    super.key,
    required this.text,
    this.isAuth = false,
    this.onChanged,
    this.keyboardType = TextInputType.text,
    this.focusNode,
    this.minlines,
    this.enabled = true,
    this.isPassword = false,
    this.suffixIcon,
    this.preffixIcon,
    this.preffixIconData,
    this.asset,
    this.onTap,
    this.controller,
    this.validator,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isObscure = true;
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    final themedata = Theme.of(context).colorScheme;
    final isDark = themeProvider.isDarkMode();
    return TextFormField(
      focusNode: widget.focusNode,
      controller: widget.controller,
      minLines: widget.minlines,
      maxLines: widget.minlines != null ? widget.minlines! * 2 : 1,
      enabled: widget.enabled,
      keyboardType: widget.keyboardType,
      onTap: widget.onTap,
      onTapOutside: (_) => FocusScope.of(context).unfocus(),
      onChanged: widget.onChanged,
      validator: widget.validator,
      obscureText: widget.isPassword ? isObscure : false,
      decoration: InputDecoration(
        prefixIcon: widget.preffixIconData != null
            ? Icon(widget.preffixIconData, size: 22, color: Colors.grey)
            : widget.preffixIcon != null
                ? widget.preffixIcon
            : null,
        hintText: widget.text,
        filled: widget.isAuth ? false : true,
        fillColor: MyColor.grey01Color.withOpacity(0.4),
      
        hintStyle: TextStyle(
            fontSize: 12, // Font size
            color: NewColor.inputHintColor,
         
        ),
        focusColor: MyColor.primaryColor,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: MyColor.primaryColor,
            width: 1.2,
          ),
          borderRadius: BorderRadius.circular(
            widget.isAuth ? 30 : 10,
          ),
        ),
        enabledBorder: _buildEnabledBorder(isDark, widget.isAuth),
        border: _buildEnabledBorder(isDark, widget.isAuth),
        disabledBorder: _buildEnabledBorder(isDark, widget.isAuth),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        suffixIcon: widget.isPassword
            ? IconButton(
                onPressed: () {
                  setState(() {
                    isObscure = !isObscure;
                  });
                },
                icon: Icon(
                  isObscure ? Iconsax.eye_slash : Iconsax.eye,
                  size: 22,
                  color: Colors.grey,
                ),
              )
            : widget.suffixIcon != null
                ? Icon(widget.suffixIcon, size: 22, color: Colors.grey)
                : widget.asset != null
                    ? Padding(
                        padding: const EdgeInsets.all(15),
                        child: SvgPicture.asset(
                          widget.asset!,
                        ),
                      )
                    : null,
      ),
      style: MyStyle.tx14Black.copyWith(
        color: widget.isAuth ? MyColor.blackColor : themedata.tertiary,
        fontSize: 13,
        fontWeight: FontWeight.w400,
        fontFamily: 'SF Pro Rounded',
      ),
    );
  }

  OutlineInputBorder _buildEnabledBorder(
    bool isDark,
    bool isAuth,
  ) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(
        isAuth ? 30 : 10,
      ),
        borderSide: BorderSide(
          width: 1.2,
            color: const Color(0xffE9EBF8)),
    );
  }
}

class UnderlineTextfield extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool isEnabled;
  final FocusNode? focusNode;
  final Function(String)? onChanged;
  final Widget? suffixIcon;
  const UnderlineTextfield(
      {
    super.key,
    required this.controller,
    required this.hintText,
    this.isEnabled = true,
    this.focusNode,
    this.onChanged,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    final themedata = Theme.of(context).colorScheme;
    return TextFormField(
      enabled: isEnabled,
      controller: controller,
      onChanged: onChanged,
      keyboardType: TextInputType.number,
      onTapOutside: (_) => FocusScope.of(context).unfocus(),
      style: TextStyle(
        fontSize: 13,
        color: themedata.tertiary,
        fontFamily: 'SF Pro Rounded',
      ),
      focusNode: focusNode,
      
      decoration: InputDecoration(
        hintText: hintText,
        suffixIcon: suffixIcon,
        hintStyle: TextStyle(
          fontSize: 12,
          color: Color(0xFF999999),
          fontFamily: 'SF Pro Rounded',
        ),
        border: InputBorder.none, // No border for the TextFormField
        contentPadding: EdgeInsets.symmetric(vertical: 10), // Adjust as needed
      ),
    );
  }
}
