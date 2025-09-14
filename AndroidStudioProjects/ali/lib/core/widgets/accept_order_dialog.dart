import 'package:flutter/material.dart';
import '../styles/colors.dart';
import '../styles/dimens.dart';

Future<void> showAcceptOrderDialog(
    BuildContext context, {
      required int itemsCount,
      required int prepMinutes,
      required VoidCallback onGoToPreparation,
    }) async {
  AppDimens.init(context);

  return showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (ctx) {
      return Directionality(
        textDirection: TextDirection.rtl,
        child: Dialog(
          elevation: 0,
          insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimens.radiusLarge),
            side: const BorderSide(color: AppColors.grey, width: 1),
          ),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 380),
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                AppDimens.paddingMedium,
                AppDimens.paddingSmall,
                AppDimens.paddingMedium,
                AppDimens.paddingMedium,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      const Spacer(),
                      _CloseDot(onTap: () => Navigator.of(ctx).pop()),
                    ],
                  ),
                  SizedBox(height: AppDimens.spacingSmall),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.check_circle, color: AppColors.success, size: AppDimens.iconLarge),
                      SizedBox(width: AppDimens.spacingSmall),
                      Text(
                        'تم قبول الطلب',
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w600,
                          fontSize: 16 * AppDimens.scale,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: AppDimens.spacingLarge),
                  Text(
                    'عدد المنتجات $itemsCount',
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 15 * AppDimens.scale,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: AppDimens.spacingSmall),
                  Text(
                    'الوقت المقدر للتحضير هو $prepMinutes دقائق',
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 15 * AppDimens.scale,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: AppDimens.spacingLarge),
                  SizedBox(
                    width: double.infinity,
                    height: AppDimens.buttonHeight,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(ctx).pop();
                        onGoToPreparation();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: AppColors.onPrimary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppDimens.radiusMedium),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        'الذهاب لصفحة التحضير',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15 * AppDimens.scale,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}

class _CloseDot extends StatelessWidget {
  final VoidCallback onTap;
  const _CloseDot({required this.onTap});

  @override
  Widget build(BuildContext context) {
    final sz = 28.0 * AppDimens.scale;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: sz,
        height: sz,
        decoration: const BoxDecoration(
          color: AppColors.primary,
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: Icon(
          Icons.close,
          size: 18 * AppDimens.scale,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }
}
