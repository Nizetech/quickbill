import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jost_pay_wallet/Provider/theme_provider.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:provider/provider.dart';

class CustomTextField extends StatefulWidget {
  final String text;
  final IconData? suffixIcon;
  final IconData? preffixIcon;
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
        prefixIcon: widget.preffixIcon != null
            ? Icon(widget.preffixIcon, size: 22, color: Colors.grey)
            : null,
        hintText: widget.text,
        filled: true,
        fillColor:
            widget.isAuth || !isDark ? Colors.white : MyColor.dark02Color,
        hintStyle: MyStyle.tx14Black.copyWith(
          color: Colors.grey,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        enabled: false,
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
                  isObscure ? Icons.visibility : Icons.visibility_off,
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
        fontSize: 14,
        fontWeight: FontWeight.w400,
        fontFamily: 'SF Pro Rounded',
      ),
    );
  }

  OutlineInputBorder _buildEnabledBorder(bool isDark, bool isAuth) {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          width: 1.2,
          color: isAuth || !isDark
              ? const Color(0xffE9EBF8)
              : const Color(0xff1B1B1B),
        ));
  }
}

class UnderlineTextfield extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  const UnderlineTextfield(
      {super.key, required this.controller, required this.hintText});

  @override
  Widget build(BuildContext context) {
    final themedata = Theme.of(context).colorScheme;
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      style: TextStyle(
        fontSize: 14,
        color: themedata.tertiary,
        fontFamily: 'SF Pro Rounded',
      ),
      decoration: InputDecoration(
        hintText: hintText,
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
