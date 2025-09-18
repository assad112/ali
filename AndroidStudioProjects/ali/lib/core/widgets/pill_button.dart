import 'package:flutter/material.dart';
import '../styles/dimens.dart';
import '../styles/colors.dart';

class PillButton extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback? onTap;
  final bool enabled;
  final Color? selectedBgColor;
  final Color? selectedTextColor;
  final Color? unselectedBgColor;
  final Color? unselectedTextColor;
  final bool showShadow;
  final bool outlineWhenUnselected;
  final double? height;
  final EdgeInsetsGeometry? padding;

  const PillButton({
    super.key,
    required this.label,
    this.selected = false,
    this.onTap,
    this.enabled = true,
    this.selectedBgColor,
    this.selectedTextColor,
    this.unselectedBgColor,
    this.unselectedTextColor,
    this.showShadow = true,
    this.outlineWhenUnselected = true,
    this.height,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    AppDimens.init(context);

    final bool isEnabled = enabled && onTap != null;

    final Color selBg = selectedBgColor ?? AppColors.pillSelectedBg;
    final Color selFg = selectedTextColor ?? AppColors.pillSelectedFg;
    final Color unsBg = unselectedBgColor ?? AppColors.pillUnselectedBg;
    final Color unsFg = unselectedTextColor ?? AppColors.pillUnselectedFg;

    final Color bg = selected ? selBg : unsBg;
    final Color fg = selected ? selFg : unsFg;

    final double defaultH = AppDimens.buttonHeight <= 0 ? 52 : AppDimens.buttonHeight;
    final double h = height ?? defaultH;
    final double radius = (h / 2).clamp(16.0, 24.0) as double;
    final EdgeInsetsGeometry pad = padding ?? EdgeInsets.symmetric(horizontal: AppDimens.paddingMedium);

    final BorderSide side = !selected && outlineWhenUnselected
        ? BorderSide(color: AppColors.grey.withOpacity(0.5), width: 1)
        : BorderSide.none;

    final double elevation = showShadow ? 2 : 0;

    return Material(
      color: isEnabled ? bg : bg.withOpacity(0.6),
      elevation: elevation,
      shadowColor: AppColors.shadowSoft,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius), side: side),
      child: InkWell(
        onTap: isEnabled ? onTap : null,
        borderRadius: BorderRadius.circular(radius),
        child: SizedBox(
          height: h,
          child: Center(
            child: Text(
              label,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: isEnabled ? fg : fg.withOpacity(0.6),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
