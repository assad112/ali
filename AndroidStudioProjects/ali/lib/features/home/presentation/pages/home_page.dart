import 'package:flutter/material.dart';
import 'package:ali/core/widgets/home_action_tile.dart';
import 'package:ali/core/widgets/pieces_alert_dialog.dart';

// 👇 استيراد نسبي للملف الموجود فعليًا باسم order_size_dialog.dar.dart
import '../../../../core/widgets/order_size_dialog.dar.dart' as order_dialog;

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    const hPad = 16.0, gap = 12.0;
    final tileW = (size.width - (hPad * 2) - (gap * 2)) / 3;
    const labels = ['زر 1','زر 2','زر 3','زر 4','زر 5','زر 6'];

    return Directionality(
      textDirection: TextDirection.rtl,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(hPad),
        child: Wrap(
          spacing: gap,
          runSpacing: gap,
          children: [
            for (int i = 0; i < labels.length; i++)
              HomeActionTile(
                width: tileW,
                icon: Icons.widgets_outlined,
                label: labels[i],
                onTap: () {
                  if (i == 1) {
                    // زر 2 → حوار حجم الطلب
                    order_dialog.showOrderSizeDialog(
                      context,
                      width: 350,
                      height: 560,
                      bags: 22,
                      gallons: 0,
                      cartons: 44,
                    );
                  } else {
                    // بقية الأزرار → حوار التنبيه
                    showPiecesAlertDialog(
                      context,
                      pieces: 22,
                      title: 'تنبيه',
                      note: '( اكثر من قطعه )',
                      actionText: 'تم',
                    );
                  }
                },
              ),
          ],
        ),
      ),
    );
  }
}
