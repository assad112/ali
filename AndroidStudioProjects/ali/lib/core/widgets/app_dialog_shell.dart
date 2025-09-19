import 'dart:ui';
import 'package:flutter/material.dart';

class AppDialogShell extends StatelessWidget {
  final double width;
  final double height;
  final Widget child;
  final Color borderColor;
  final Color backgroundColor;
  final double borderWidth;
  final double radius;
  final EdgeInsets padding;
  final List<BoxShadow>? shadows;

  const AppDialogShell({
    super.key,
    required this.child,
    this.width = 350,
    this.height = 270,
    this.borderColor = const Color(0xFF1E88E5),
    this.backgroundColor = Colors.white,
    this.borderWidth = 2,
    this.radius = 12,
    this.padding = const EdgeInsets.fromLTRB(20, 18, 20, 20),
    this.shadows = const [
      BoxShadow(color: Color(0x332188F3), blurRadius: 24, offset: Offset(0, 6)),
      BoxShadow(color: Color(0x1F000000), blurRadius: 24, offset: Offset(0, 10)),
    ],
  });

  @override
  Widget build(BuildContext context) {
    return Material( // <-- الأهم: يوفّر Material ancestor للـ TextField
      type: MaterialType.transparency,
      child: Container(
        constraints: BoxConstraints.tightFor(width: width, height: height),
        padding: padding,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(radius),
          border: Border.all(color: borderColor, width: borderWidth),
          boxShadow: shadows,
        ),
        child: child,
      ),
    );
  }
}

/// (اختياري) دالة مساعدة لإظهار الغلاف كحوار عام
Future<T?> showAppDialogShell<T>(
    BuildContext context, {
      required Widget child,
      double width = 350,
      double height = 270,
      Color borderColor = const Color(0xFF1E88E5),
      double radius = 12,
      EdgeInsets padding = const EdgeInsets.fromLTRB(20, 18, 20, 20),
      bool barrierDismissible = true,
      Color barrierColor = const Color.fromRGBO(0, 0, 0, 0.35),
      Duration transitionDuration = const Duration(milliseconds: 200),
      double blurSigma = 6,
    }) {
  return showGeneralDialog<T>(
    context: context,
    barrierDismissible: barrierDismissible,
    barrierLabel: 'dismiss',
    barrierColor: barrierColor,
    pageBuilder: (_, __, ___) => const SizedBox.shrink(),
    transitionDuration: transitionDuration,
    transitionBuilder: (ctx, anim, _, __) {
      final curved = CurvedAnimation(parent: anim, curve: Curves.easeOutCubic);
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
        child: Opacity(
          opacity: curved.value,
          child: Center(
            child: Transform.scale(
              scale: Tween<double>(begin: .97, end: 1).transform(curved.value),
              child: AppDialogShell(
                width: width,
                height: height,
                borderColor: borderColor,
                radius: radius,
                padding: padding,
                child: child,
              ),
            ),
          ),
        ),
      );
    },
  );
}
