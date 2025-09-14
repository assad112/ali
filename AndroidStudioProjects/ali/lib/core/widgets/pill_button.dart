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
    final bool isEnabled = enabled && onTap != null;

    final Color selBg  = selectedBgColor     ?? AppColors.pillSelectedBg;
    final Color selFg  = selectedTextColor   ?? AppColors.pillSelectedFg;
    final Color unsBg  = unselectedBgColor   ?? AppColors.pillUnselectedBg;
    final Color unsFg  = unselectedTextColor ?? AppColors.pillUnselectedFg;

    final Color bg = selected ? selBg : unsBg;
    final Color fg = selected ? selFg : unsFg;

    final double h = height ?? AppDimens.buttonHeight;
    final double radius = (h / 2).clamp(16, 24);
    final EdgeInsetsGeometry pad =
        padding ?? EdgeInsets.symmetric(horizontal: AppDimens.paddingMedium);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: isEnabled ? onTap : null,
        borderRadius: BorderRadius.circular(radius),
        child: Container(
          height: h,
          alignment: Alignment.center,
          padding: pad,
          decoration: BoxDecoration(
            color: isEnabled ? bg : bg.withOpacity(0.6),
            borderRadius: BorderRadius.circular(radius),
            border: !selected && outlineWhenUnselected
                ? Border.all(color: AppColors.grey.withOpacity(0.5), width: 1)
                : null,
            boxShadow: showShadow
                ? [
              BoxShadow(
                color: selected
                    ? AppColors.shadowStrong
                    : AppColors.shadowSoft,
                blurRadius: 14,
                offset: const Offset(0, 4),
              ),
            ]
                : null,
          ),
          child: Text(
            label,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: isEnabled ? fg : fg.withOpacity(0.6),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
