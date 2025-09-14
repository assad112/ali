import 'package:flutter/material.dart';
import '../styles/dimens.dart';
import '../styles/colors.dart';

enum OrderStatusColor { success, warning, error, info }

class OrderCard extends StatelessWidget {
  final String orderNumber;
  final bool elevated;

  final int? prepMinutes;
  final VoidCallback? onAccept;
  final String acceptLabel;

  final String? timeText;
  final String? statusLabel;
  final OrderStatusColor statusColorName;
  final bool showDetailsButton;
  final VoidCallback? onDetails;

  const OrderCard({
    super.key,
    required this.orderNumber,
    this.elevated = true,
    this.prepMinutes,
    this.onAccept,
    this.acceptLabel = 'قبول الطلب',
    this.timeText,
    this.statusLabel,
    this.statusColorName = OrderStatusColor.info,
    this.showDetailsButton = false,
    this.onDetails,
  });

  bool get _isCurrent => onAccept != null && prepMinutes != null;

  Color get _statusColor {
    switch (statusColorName) {
      case OrderStatusColor.success:
        return AppColors.success;
      case OrderStatusColor.warning:
        return AppColors.warning;
      case OrderStatusColor.error:
        return AppColors.error;
      case OrderStatusColor.info:
      default:
        return AppColors.textSecondary;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: AppDimens.spacingXSmall),
      padding: EdgeInsets.all(AppDimens.paddingMedium),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppDimens.radiusLarge),
        border: Border.all(color: AppColors.grey.withOpacity(0.35), width: 1),
        boxShadow: elevated
            ? [BoxShadow(color: AppColors.shadowSoft, blurRadius: 14, offset: const Offset(0, 4))]
            : null,
      ),
      child: _isCurrent ? _buildCurrentRow(context) : _buildPreviousRow(context),
    );
  }

  Widget _buildCurrentRow(BuildContext context) {
    final h = 36.0, r = h / 2;
    return Row(
      children: [
        SizedBox(
          height: h,
          child: TextButton(
            onPressed: onAccept,
            style: TextButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: AppDimens.paddingMedium),
              backgroundColor: AppColors.success,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(r)),
              textStyle: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w700),
            ),
            child: Text(acceptLabel),
          ),
        ),
        SizedBox(width: AppDimens.spacingSmall),
        const Spacer(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'طلب رقم $orderNumber',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: AppDimens.spacingXSmall),
            Text(
              'مدة التحضير ${prepMinutes ?? 0} دقائق',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.warning,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPreviousRow(BuildContext context) {
    return Row(
      children: [
        if (showDetailsButton) _DetailsButton(onPressed: onDetails),
        if (showDetailsButton) SizedBox(width: AppDimens.spacingSmall),
        if (timeText != null) _TimeChip(text: timeText!),
        const Spacer(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'طلب رقم $orderNumber',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w700,
              ),
            ),
            if (statusLabel != null) ...[
              SizedBox(height: AppDimens.spacingXSmall),
              Text(
                statusLabel!,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: _statusColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }
}

class _TimeChip extends StatelessWidget {
  final String text;
  const _TimeChip({required this.text});

  @override
  Widget build(BuildContext context) {
    final h = 30.0, r = h / 2;
    return Container(
      height: h,
      padding: EdgeInsets.symmetric(horizontal: AppDimens.paddingMedium),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.success.withOpacity(0.15),
        borderRadius: BorderRadius.circular(r),
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
          color: AppColors.success,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

class _DetailsButton extends StatelessWidget {
  final VoidCallback? onPressed;
  const _DetailsButton({this.onPressed});

  @override
  Widget build(BuildContext context) {
    final h = 36.0, r = h / 2;
    return SizedBox(
      height: h,
      child: TextButton(
        onPressed: onPressed ?? () {},
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: AppDimens.paddingMedium),
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.onPrimary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(r)),
          textStyle: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w700),
        ),
        child: const Text('تفاصيل'),
      ),
    );
  }
}
