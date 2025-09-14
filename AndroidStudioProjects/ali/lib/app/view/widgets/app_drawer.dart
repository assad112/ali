import 'package:flutter/material.dart';
import '../../../core/styles/colors.dart';

class AppDrawerContent extends StatelessWidget {
  const AppDrawerContent({super.key});

  @override
  Widget build(BuildContext context) {
    final c = AppColors.primary;
    const t = TextStyle(fontWeight: FontWeight.w600, fontSize: 15);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: SizedBox(
              height: 72,
              child: Image.asset(
                'assets/logo.png',
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) => const FlutterLogo(size: 56),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                children: const [
                  _Section(
                    headerLabel: 'ادارة المخزون',
                    headerIcon: Icons.inventory_2_outlined,
                    children: [
                      _SubItem(label: 'الجرد',         icon: Icons.inventory_2_outlined),
                      _SubItem(label: 'طلبات السوق',   icon: Icons.inventory_2_outlined),
                      _SubItem(label: 'منتج نافذ',     icon: Icons.inventory_2_outlined),
                    ],
                  ),
                  SizedBox(height: 6),
                  _MainItem(label: 'المحفظة',        icon: Icons.person_outline),
                  _MainItem(label: 'المكافآت',       icon: Icons.person_outline),
                  _MainItem(label: 'إبلاغ عن مشكلة', icon: Icons.person_outline),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.logout_rounded, color: c),
                    const SizedBox(width: 8),
                    const Text('تسجيل خروج', style: t),
                  ],
                ),
                Icon(Icons.chevron_left, color: c),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Section extends StatefulWidget {
  final String headerLabel;
  final IconData headerIcon;
  final List<Widget> children;

  const _Section({
    required this.headerLabel,
    required this.headerIcon,
    required this.children,
  });

  @override
  State<_Section> createState() => _SectionState();
}

class _SectionState extends State<_Section> {
  bool open = true;

  @override
  Widget build(BuildContext context) {
    final c = AppColors.primary;
    const t = TextStyle(fontWeight: FontWeight.w600, fontSize: 15);

    return Column(
      children: [
        InkWell(
          onTap: () => setState(() => open = !open),
          borderRadius: BorderRadius.circular(10),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(widget.headerIcon, color: c),
                    const SizedBox(width: 8),
                    Text(widget.headerLabel, style: t),
                  ],
                ),
                Icon(open ? Icons.expand_less : Icons.expand_more, color: c),
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

  const _MainItem({required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    final c = AppColors.primary;
    const t = TextStyle(fontWeight: FontWeight.w600, fontSize: 15);

    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, color: c),
                const SizedBox(width: 8),
                Text(label, style: t),
              ],
            ),
            Icon(Icons.chevron_left, color: c),
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
    final c = AppColors.primary;

    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
        child: Row(
          // في RTL: start يعني اليمين
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(icon, size: 18, color: c),   // الأيقونة ملاصقة لليمين
            const SizedBox(width: 8),
            Text(label, textAlign: TextAlign.right),
          ],
        ),
      ),
    );
  }
}
