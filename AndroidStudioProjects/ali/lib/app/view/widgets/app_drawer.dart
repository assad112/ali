import 'package:flutter/material.dart';
import '../../../core/styles/colors.dart';
import '../../../core/styles/dimens.dart';

class AppDrawerContent extends StatelessWidget {
  const AppDrawerContent({super.key});

  @override
  Widget build(BuildContext context) {
    AppDimens.init(context);

    final c = AppColors.primary;
    final t = TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 15 * AppDimens.scale,
      color: AppColors.textPrimary,
    );

    return Material(
      color: const Color(0xFFFFFFFF),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(
                AppDimens.paddingMedium,
                AppDimens.paddingMedium,
                AppDimens.paddingMedium,
                AppDimens.spacingSmall,
              ),
              child: SizedBox(
                height: 72 * AppDimens.scale,
                child: Image.asset(
                  'assets/logo.png',
                  fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) => FlutterLogo(size: 56 * AppDimens.scale),
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: AppDimens.paddingSmall),
                child: Column(
                  children: [
                    _Section(
                      headerLabel: 'ادارة المخزون',
                      headerIcon: Icons.inventory_2_outlined,
                      textStyle: t,
                      children: const [
                        _SubItem(label: 'الجرد', icon: Icons.inventory_2_outlined),
                        _SubItem(label: 'طلبات السوق', icon: Icons.inventory_2_outlined),
                        _SubItem(label: 'منتج نافذ', icon: Icons.inventory_2_outlined),
                      ],
                    ),
                    SizedBox(height: 6 * AppDimens.scale),
                    _MainItem(label: 'المحفظة', icon: Icons.person_outline, textStyle: t),
                    _MainItem(label: 'المكافآت', icon: Icons.person_outline, textStyle: t),
                    _MainItem(label: 'إبلاغ عن مشكلة', icon: Icons.person_outline, textStyle: t),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                AppDimens.paddingMedium,
                AppDimens.spacingSmall,
                AppDimens.paddingMedium,
                AppDimens.paddingMedium + AppDimens.safeBottom,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.logout_rounded, color: c, size: AppDimens.iconMedium),
                      SizedBox(width: AppDimens.spacingSmall),
                      Text('تسجيل خروج', style: t),
                    ],
                  ),
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: Icon(Icons.chevron_left, color: c, size: AppDimens.iconMedium),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Section extends StatefulWidget {
  final String headerLabel;
  final IconData headerIcon;
  final List<Widget> children;
  final TextStyle textStyle;

  const _Section({
    required this.headerLabel,
    required this.headerIcon,
    required this.children,
    required this.textStyle,
  });

  @override
  State<_Section> createState() => _SectionState();
}

class _SectionState extends State<_Section> {
  bool open = true;

  @override
  Widget build(BuildContext context) {
    AppDimens.init(context);
    final c = AppColors.primary;

    return Column(
      children: [
        InkWell(
          onTap: () => setState(() => open = !open),
          borderRadius: BorderRadius.circular(AppDimens.radiusSmall),
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: AppDimens.spacingSmall,
              horizontal: 6 * AppDimens.scale,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(widget.headerIcon, color: c, size: AppDimens.iconMedium),
                    SizedBox(width: AppDimens.spacingSmall),
                    Text(widget.headerLabel, style: widget.textStyle),
                  ],
                ),
                Icon(
                  open ? Icons.expand_less : Icons.expand_more,
                  color: c,
                  size: AppDimens.iconMedium,
                ),
              ],
            ),
          ),
        ),
        if (open) ...widget.children,
      ],
    );
  }
}

class _MainItem extends StatelessWidget {
  final String label;
  final IconData icon;
  final TextStyle? textStyle;

  const _MainItem({
    required this.label,
    required this.icon,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    AppDimens.init(context);
    final c = AppColors.primary;
    final t = textStyle ??
        TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 15 * AppDimens.scale,
          color: AppColors.textPrimary,
        );

    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(AppDimens.radiusSmall),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: AppDimens.spacingSmall + 2 * AppDimens.scale,
          horizontal: 6 * AppDimens.scale,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, color: c, size: AppDimens.iconMedium),
                SizedBox(width: AppDimens.spacingSmall),
                Text(label, style: t),
              ],
            ),
            Directionality(
              textDirection: TextDirection.ltr,
              child: Icon(Icons.chevron_left, color: c, size: AppDimens.iconMedium),
            ),
          ],
        ),
      ),
    );
  }
}

class _SubItem extends StatelessWidget {
  final String label;
  final IconData icon;

  const _SubItem({required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    AppDimens.init(context);
    final c = AppColors.primary;

    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(AppDimens.radiusSmall),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: AppDimens.spacingSmall,
          horizontal: 6 * AppDimens.scale,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(icon, size: AppDimens.iconSmall, color: c),
            SizedBox(width: AppDimens.spacingSmall),
            Text(
              label,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 14 * AppDimens.scale,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
