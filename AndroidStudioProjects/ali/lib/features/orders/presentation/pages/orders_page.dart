import 'package:flutter/material.dart';
import '../../../../core/styles/dimens.dart';
import '../../../../core/styles/colors.dart';
import '../../../../core/widgets/pill_button.dart';
import '../../../../core/widgets/order_card.dart';
import '../../../../core/widgets/accept_order_dialog.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  int _tabIndex = 0;

  final TextEditingController _searchCtrl = TextEditingController();
  String _timeFilter = 'الكل';

  final List<_OrderData> _previousOrders = [
    _OrderData(number: '1234', status: 'جاري توصيله', color: OrderStatusColor.warning, date: DateTime.now().subtract(const Duration(hours: 1))),
    _OrderData(number: '1234', status: 'تم الاستلام', color: OrderStatusColor.success, date: DateTime.now().subtract(const Duration(days: 1, hours: 2))),
    _OrderData(number: '1234', status: 'مرفوض', color: OrderStatusColor.error, date: DateTime.now().subtract(const Duration(days: 3, hours: 5))),
  ];

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppDimens.init(context);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: ListView(
        padding: EdgeInsets.fromLTRB(
          AppDimens.paddingMedium,
          AppDimens.paddingMedium,
          AppDimens.paddingMedium,
          AppDimens.paddingLarge,
        ),
        children: [
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Row(
                children: [
                  Expanded(
                    child: PillButton(
                      label: 'الحالية',
                      selected: _tabIndex == 0,
                      onTap: () => setState(() => _tabIndex = 0),
                      height: 40,
                      outlineWhenUnselected: true,
                    ),
                  ),
                  SizedBox(width: AppDimens.spacingSmall),
                  Expanded(
                    child: PillButton(
                      label: 'السابقة',
                      selected: _tabIndex == 1,
                      onTap: () => setState(() => _tabIndex = 1),
                      height: 40,
                      outlineWhenUnselected: true,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: AppDimens.spacingMedium),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 220),
            child: _tabIndex == 0
                ? Column(key: const ValueKey('current'), children: _buildCurrentTab())
                : Column(key: const ValueKey('previous'), children: _buildPreviousTab()),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildCurrentTab() {
    return [
      OrderCard(
        orderNumber: '1234',
        prepMinutes: 10,
        onAccept: () {
          showAcceptOrderDialog(
            context,
            itemsCount: 22,
            prepMinutes: 10,
            onGoToPreparation: () {},
          );
        },
        elevated: true,
      ),
      SizedBox(height: AppDimens.spacingSmall),
      OrderCard(
        orderNumber: '1235',
        prepMinutes: 8,
        onAccept: () {
          showAcceptOrderDialog(
            context,
            itemsCount: 15,
            prepMinutes: 8,
            onGoToPreparation: () {},
          );
        },
        elevated: true,
      ),
    ];
  }

  List<Widget> _buildPreviousTab() {
    final now = DateTime.now();
    bool matchesTime(DateTime d) {
      switch (_timeFilter) {
        case 'اليوم':
          return _isSameDate(d, now);
        case 'أمس':
          return _isSameDate(d, now.subtract(const Duration(days: 1)));
        case 'آخر 7 أيام':
          return d.isAfter(now.subtract(const Duration(days: 7)));
        default:
          return true;
      }
    }

    final q = _searchCtrl.text.trim();
    final visible = _previousOrders.where((o) {
      final bySearch = q.isEmpty || o.number.contains(q) || o.status.contains(q);
      final byTime = matchesTime(o.date);
      return bySearch && byTime;
    }).toList();

    return [
      Container(
        padding: EdgeInsets.all(AppDimens.paddingMedium),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppDimens.radiusLarge),
          boxShadow: [
            BoxShadow(color: AppColors.shadowSoft, blurRadius: 16, offset: const Offset(0, 6)),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                _TimeFilterMenu(
                  value: _timeFilter,
                  onChanged: (v) => setState(() => _timeFilter = v),
                ),
                SizedBox(width: AppDimens.spacingSmall),
                Expanded(
                  child: _SearchCapsule(
                    controller: _searchCtrl,
                    hint: 'إبحث عن…',
                    onChanged: (_) => setState(() {}),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      SizedBox(height: AppDimens.spacingMedium),
      if (visible.isEmpty)
        Padding(
          padding: EdgeInsets.all(AppDimens.paddingLarge),
          child: Center(
            child: Text('لا توجد طلبات مطابقة.', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary)),
          ),
        )
      else
        ...visible.map((o) => Padding(
          padding: EdgeInsets.only(bottom: AppDimens.spacingSmall),
          child: OrderCard(
            orderNumber: o.number,
            timeText: _formatTime(o.date),
            statusLabel: o.status,
            statusColorName: o.color,
            showDetailsButton: true,
            elevated: true,
          ),
        )),
    ];
  }

  String _formatTime(DateTime dt) {
    int hour = dt.hour;
    final minute = dt.minute.toString().padLeft(2, '0');
    final isPM = hour >= 12;
    hour = hour % 12;
    if (hour == 0) hour = 12;
    return '$hour:$minute ${isPM ? 'PM' : 'AM'}';
  }

  bool _isSameDate(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;
}

class _OrderData {
  final String number;
  final String status;
  final OrderStatusColor color;
  final DateTime date;
  _OrderData({required this.number, required this.status, required this.color, required this.date});
}

class _SearchCapsule extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final ValueChanged<String>? onChanged;
  const _SearchCapsule({required this.controller, required this.hint, this.onChanged});

  @override
  Widget build(BuildContext context) {
    final h = 44.0, r = h / 2;
    return Container(
      height: h,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(r),
        border: Border.all(color: AppColors.grey.withOpacity(0.55), width: 1),
        boxShadow: [BoxShadow(color: AppColors.shadowSoft, blurRadius: 12, offset: const Offset(0, 4))],
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        textAlign: TextAlign.right,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: AppColors.textSecondary.withOpacity(0.6)),
          border: InputBorder.none,
          prefixIcon: const Icon(Icons.search_rounded),
          suffixIcon: (controller.text.isNotEmpty)
              ? IconButton(
            onPressed: () {
              controller.clear();
              onChanged?.call('');
            },
            icon: const Icon(Icons.close_rounded),
            tooltip: 'مسح',
          )
              : null,
          contentPadding: const EdgeInsets.symmetric(horizontal: 8),
        ),
      ),
    );
  }
}

class _TimeFilterMenu extends StatelessWidget {
  final String value;
  final ValueChanged<String> onChanged;
  const _TimeFilterMenu({required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    const items = <String>['الكل', 'اليوم', 'أمس', 'آخر 7 أيام'];
    final h = 40.0, r = h / 2;

    return Container(
      height: h,
      padding: const EdgeInsetsDirectional.only(start: 12, end: 10),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(r),
        border: Border.all(color: AppColors.grey.withOpacity(0.55)),
        boxShadow: [BoxShadow(color: AppColors.shadowSoft, blurRadius: 12, offset: const Offset(0, 4))],
      ),
      child: PopupMenuButton<String>(
        initialValue: value,
        onSelected: onChanged,
        position: PopupMenuPosition.under,
        itemBuilder: (ctx) => items
            .map((t) => PopupMenuItem(
          value: t,
          child: Text(t, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.textPrimary, fontWeight: FontWeight.w600)),
        ))
            .toList(),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.keyboard_arrow_down_rounded),
            const SizedBox(width: 4),
            Text('وقت الاستلام', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.textPrimary, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}
