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

  final insetH = AppDimens.vw(0.04); // 4% من عرض الشاشة
  final insetV = AppDimens.isLandscape ? 12.0 : 24.0;
  final maxDialogWidth = AppDimens.pick<double>(
    mobile: 380.0,
    tablet: 520.0,
    desktop: 640.0,
  );

  return showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (ctx) {
      AppDimens.init(ctx);

      return Directionality(
        textDirection: TextDirection.rtl,
        child: AnimatedPadding(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOut,
          padding: EdgeInsets.only(bottom: AppDimens.keyboardHeight),
          child: Dialog(
            elevation: 0,
            backgroundColor: const Color(0xFFFFFFFF), // خلفية بيضاء
            insetPadding: EdgeInsets.fromLTRB(insetH, insetV, insetH, insetV),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppDimens.radiusLarge),
              side: const BorderSide(color: AppColors.grey, width: 1),
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: maxDialogWidth),
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
                    // زر الإغلاق في الزاوية اليسرى (نفس الاتجاه بالصورة)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        _CloseDot(onTap: () => Navigator.of(ctx).pop()),
                      ],
                    ),
                    SizedBox(height: AppDimens.spacingSmall),

                    // عنوان: تم قبول الطلب + أيقونة تحقق بإطار أخضر (الأيقونة يسار النص كما في الصورة)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'تم قبول الطلب',
                          style: TextStyle(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w600,
                            fontSize: 16 * AppDimens.scale,
                          ),
                        ),
                        SizedBox(width: AppDimens.spacingSmall),
                        const _CheckBadge(),
                      ],
                    ),

                    SizedBox(height: AppDimens.spacingLarge),

                    // نصوص الوسط
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

                    // الزر بعرض كامل ولون أساسي ونص داكن (مثل الصورة)
                    SizedBox(
                      width: double.infinity,
                      height: AppDimens.buttonHeight,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(ctx).pop();
                          onGoToPreparation();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,       // البرتقالي/الأساسي
                          foregroundColor: AppColors.textPrimary,    // نص داكن كما في الصورة
                          shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(AppDimens.radiusMedium),
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
    final sz = 28.0 * AppDimens.scale; // دائرة صغيرة مثل الصورة
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: sz,
        height: sz,
        decoration: const BoxDecoration(
          color: AppColors.primary, // لون الدائرة
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: Icon(
          Icons.close,
          size: 18 * AppDimens.scale,
          color: AppColors.textPrimary, // X بلون داكن
        ),
      ),
    );
  }
}

/// شارة تحقق بإطار أخضر (مطابقة لتصميم الصورة)
class _CheckBadge extends StatelessWidget {
  const _CheckBadge();

  @override
  Widget build(BuildContext context) {
    final side = 24.0 * AppDimens.scale;
    return Container(
      width: side,
      height: side,
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(color: AppColors.success, width: 2),
        borderRadius: BorderRadius.circular(6),
      ),
      alignment: Alignment.center,
      child: Icon(
        Icons.check,
        size: 16 * AppDimens.scale,
        color: AppColors.success,
      ),
    );
  }
}
