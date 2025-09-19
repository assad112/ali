import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:ali/core/widgets/app_dialog_shell.dart';

Future<void> showOrderSizeDialog(
    BuildContext context, {
      // ثوابت القياس (يمكن تغييرها وقت الاستدعاء)
      double width = 350,
      double height = 560,
      // القيم الابتدائية
      int bags = 22,
      int gallons = 0,
      int cartons = 44,
      String title = 'حجم الطلب',
      String actionText = 'متابعة',
      bool barrierDismissible = true,
      void Function({required int bags, required int gallons, required int cartons})?
      onSubmit,
    }) {
  return showGeneralDialog(
    context: context,
    barrierColor: Colors.black.withOpacity(0.35),
    barrierDismissible: barrierDismissible,
    barrierLabel: 'dismiss',
    pageBuilder: (_, __, ___) => const SizedBox.shrink(),
    transitionDuration: const Duration(milliseconds: 200),
    transitionBuilder: (ctx, anim, _, __) {
      final curved = CurvedAnimation(parent: anim, curve: Curves.easeOutCubic);

      // محليات
      final bagsCtrl    = TextEditingController(text: '$bags');
      final gallonsCtrl = TextEditingController(text: '$gallons');
      final cartonsCtrl = TextEditingController(text: '$cartons');

      InputDecoration _decoration() => InputDecoration(
        isDense: true,
        filled: true,
        fillColor: Colors.white,
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFDFE2E6), width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF1E88E5), width: 1.5),
        ),
      );

      Widget _label(String text) => Padding(
        padding: const EdgeInsetsDirectional.only(top: 10, bottom: 6),
        child: Align(
          alignment: AlignmentDirectional.centerEnd,
          child: Text(
            text,
            textDirection: TextDirection.rtl,
            style: const TextStyle(
              color: Color(0xFF131A2B),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      );

      return Directionality(
        textDirection: TextDirection.rtl,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
          child: Opacity(
            opacity: curved.value,
            child: Center(
              child: Transform.scale(
                scale: Tween<double>(begin: .97, end: 1.0).transform(curved.value),
                child: AppDialogShell(
                  width: width,
                  height: height,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // الهيدر: زر إغلاق دائري يسار + العنوان في الوسط
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: _CloseCircle(onTap: () {
                              Navigator.of(context).maybePop();
                            }),
                          ),
                          Text(
                            title,
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                              color: Color(0xFF131A2B),
                            ),
                          ),
                        ],
                      ),

                      // الحقول
                      Expanded(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.only(top: 4),
                          child: Column(
                            children: [
                              _label('عدد الأكياس'),
                              TextField(
                                controller: bagsCtrl,
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                decoration: _decoration(),
                              ),
                              _label('عدد الجالون'),
                              TextField(
                                controller: gallonsCtrl,
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                decoration: _decoration(),
                              ),
                              _label('عدد كرتون'),
                              TextField(
                                controller: cartonsCtrl,
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                decoration: _decoration(),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 8),

                      // زر متابعة
                      SizedBox(
                        height: 52,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFF4B64E),
                            foregroundColor: const Color(0xFF2C1B0E),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {
                            final b = int.tryParse(bagsCtrl.text.trim()) ?? 0;
                            final g = int.tryParse(gallonsCtrl.text.trim()) ?? 0;
                            final c = int.tryParse(cartonsCtrl.text.trim()) ?? 0;
                            Navigator.of(context).maybePop();
                            onSubmit?.call(bags: b, gallons: g, cartons: c);
                          },
                          child: Text(
                            actionText,
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
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
        ),
      );
    },
  );
}

class _CloseCircle extends StatelessWidget {
  const _CloseCircle({this.onTap});
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFFF4B64E),
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: const SizedBox(
          width: 32,
          height: 32,
          child: Icon(Icons.close, size: 18, color: Color(0xFF2C1B0E)),
        ),
      ),
    );
  }
}
