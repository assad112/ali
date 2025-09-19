import 'dart:ui';
import 'package:flutter/material.dart';

Future<void> showPiecesAlertDialog(
    BuildContext context, {
      required int pieces,
      double width = 350,
      double height = 270,
      String title = 'تنبيه',
      String note = '( اكثر من قطعه )',
      String actionText = 'تم',
      bool barrierDismissible = true,
    }) {
  const kBlue = Color(0xFF1E88E5);
  const kNumber = Color(0xFF2C1B0E);

  const numberStyle = TextStyle(
    color: kNumber,
    fontWeight: FontWeight.w800,
    fontSize: 58,
    height: 1.0,
  );
  const labelText = 'عدد القطع';
  const gap = 12.0;

  const labelStyle = TextStyle(
    color: Colors.black87,
    fontSize: 20,
    fontWeight: FontWeight.w600,
    decoration: TextDecoration.underline,
  );

  return showGeneralDialog(
    context: context,
    barrierColor: Colors.black.withOpacity(0.35),
    barrierDismissible: barrierDismissible,
    barrierLabel: 'dismiss',
    pageBuilder: (_, __, ___) => const SizedBox.shrink(),
    transitionDuration: const Duration(milliseconds: 200),
    transitionBuilder: (ctx, anim, _, __) {
      final curved = CurvedAnimation(parent: anim, curve: Curves.easeOutCubic);

      final numberPainter = TextPainter(
        text: TextSpan(text: '$pieces', style: numberStyle),
        textDirection: TextDirection.ltr,
        maxLines: 1,
      )..layout();
      final labelPainter = TextPainter(
        text: const TextSpan(text: labelText, style: labelStyle),
        textDirection: TextDirection.rtl,
        maxLines: 1,
      )..layout();

      final numW = numberPainter.width;
      final labelW = labelPainter.width;

      return Directionality(
        textDirection: TextDirection.rtl,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
          child: Opacity(
            opacity: curved.value,
            child: Center(
              child: Transform.scale(
                scale: Tween<double>(begin: .97, end: 1.0).transform(curved.value),
                child: Material(
                  color: Colors.transparent,
                  child: Container(
                    constraints: BoxConstraints.tightFor(width: width, height: height),
                    padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: kBlue, width: 2),
                      boxShadow: const [
                        BoxShadow(color: Color(0x332188F3), blurRadius: 24, offset: Offset(0, 6)),
                        BoxShadow(color: Color(0x1F000000), blurRadius: 24, offset: Offset(0, 10)),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const _RedDot(),
                              const SizedBox(width: 8),
                              RichText(
                                textDirection: TextDirection.rtl,
                                text: TextSpan(
                                  style: const TextStyle(
                                    color: Colors.black87,
                                    fontSize: 16,
                                    height: 1.2,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: title,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w800,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                    const TextSpan(text: ' '),
                                    TextSpan(
                                      text: note,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 13,
                                        color: Color(0x99000000),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 6),
                        Expanded(
                          child: Center(
                            child: SizedBox(
                              height: numberPainter.height + 10,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Text('$pieces', style: numberStyle),
                                  Transform.translate(
                                    offset: Offset(numW / 2 + gap + labelW / 2, 4),
                                    child: const Text(
                                      labelText,
                                      style: labelStyle,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 6),
                        SizedBox(
                          height: 52,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFF4B64E),
                              foregroundColor: kNumber,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () => Navigator.of(context).maybePop(),
                            child: Text(
                              actionText,
                              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
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
        ),
      );
    },
  );
}

class _RedDot extends StatelessWidget {
  const _RedDot();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 14,
      height: 14,
      decoration: const BoxDecoration(
        color: Color(0xFFE53935),
        shape: BoxShape.circle,
      ),
    );
  }
}
