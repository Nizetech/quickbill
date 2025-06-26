import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jost_pay_wallet/Provider/theme_provider.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:provider/provider.dart';

class YearDropdown extends StatefulWidget {
  const YearDropdown({super.key});

  @override
  State<YearDropdown> createState() => _YearDropdownState();
}

class _YearDropdownState extends State<YearDropdown> {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  String? selectedYear;
  bool isDropdownOpen = false;

  final List<String> years =
      List.generate(40, (index) => (2025 + index).toString());

  void toggleDropdown(BuildContext ctx) {
    if (isDropdownOpen) {
      _closeDropdown();
    } else {
      _openDropdown(ctx);
    }
  }

  void _openDropdown(BuildContext ctx) {
    final overlay = Overlay.of(context);
    _overlayEntry = _createOverlay(ctx);
    overlay.insert(_overlayEntry!);
    setState(() => isDropdownOpen = true);
  }

  void _closeDropdown() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    setState(() => isDropdownOpen = false);
  }

  OverlayEntry _createOverlay(BuildContext ctx) {
    final themeProvider = Provider.of<ThemeProvider>(ctx, listen: false);
    final isDark = themeProvider.isDarkMode();

    RenderBox renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);

    return OverlayEntry(
      builder: (context) => Stack(
        children: [
          // This catches taps outside to close the dropdown
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: _closeDropdown,
            child: Container(
              color: Colors.transparent,
            ),
          ),
          Positioned(
            left: offset.dx,
            top: offset.dy + size.height + 5,
            width: size.width,
            child: CompositedTransformFollower(
              link: _layerLink,
              showWhenUnlinked: false,
              child: Material(
                elevation: 4,
                color: isDark ? MyColor.dark01Color : Colors.white,
                borderRadius: BorderRadius.circular(16),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                      maxHeight: 250), // make it scrollable
                  child: ListView(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    children: years.map((year) {
                      return ListTile(
                        title: Text(year,
                            style: MyStyle.tx14Grey.copyWith(
                              color: isDark
                                  ? MyColor.whiteColor
                                  : const Color(0xff6E6D7A),
                            )),
                        onTap: () {
                          setState(() {
                            selectedYear = year;
                            isDropdownOpen = false;
                          });
                          _overlayEntry?.remove();
                        },
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _closeDropdown();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    final isDark = themeProvider.isDarkMode();
    final themedata = Theme.of(context).colorScheme;
    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        onTap: () {
          toggleDropdown(context);
        },
        child: Container(
          height: 48,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: isDark ? MyColor.dark02Color : MyColor.mainWhiteColor,
            border: Border.all(
                color: isDark
                    ? MyColor.outlineDasheColor.withOpacity(0.25)
                    : const Color(
                        0xffE9EBF8) // Change this to your desired color

                ),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            children: [
              Expanded(
                child: Center(
                  child: Text(selectedYear ?? 'Add Years',
                      style: MyStyle.tx14White.copyWith(
                        color: themedata.tertiary,
                      )),
                ),
              ),
              Container(
                height: 100,
                width: 1,
                color: isDark
                    ? MyColor.outlineDasheColor.withOpacity(0.25)
                    : const Color(0xffE9EBF8),
              ),
              const SizedBox(width: 8),
              Padding(
                padding: const EdgeInsets.all(5).copyWith(left: 10),
                child: SvgPicture.asset(
                    width: 18,
                    height: 10,
                    color: const Color(0xff6E6D7A),
                    'assets/images/svg/down.svg'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
