import 'dart:math';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../../../../core/styles/colors.dart';
import '../../../../core/styles/dimens.dart';

class BarcodeScanPage extends StatefulWidget {
  const BarcodeScanPage({super.key});

  @override
  State<BarcodeScanPage> createState() => _BarcodeScanPageState();
}

class _BarcodeScanPageState extends State<BarcodeScanPage>
    with SingleTickerProviderStateMixin {
  final MobileScannerController _controller = MobileScannerController(
    detectionTimeoutMs: 600,
    formats: [
      BarcodeFormat.qrCode,
      BarcodeFormat.code128,
      BarcodeFormat.code39,
      BarcodeFormat.ean13,
      BarcodeFormat.ean8,
      BarcodeFormat.upcA,
      BarcodeFormat.upcE
    ],
  );

  late final AnimationController _scanAnim;
  bool _handled = false;
  bool _torchOn = false;

  @override
  void initState() {
    super.initState();
    _scanAnim = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _scanAnim.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _onDetect(BarcodeCapture cap) {
    if (_handled) return;
    final code = cap.barcodes.isNotEmpty ? cap.barcodes.first.rawValue : null;
    if (code == null || code.isEmpty) return;
    _handled = true;
    Navigator.of(context).pop(code);
  }

  @override
  Widget build(BuildContext context) {
    AppDimens.init(context);
    final cs = Theme.of(context).colorScheme;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Stack(
            children: [
              Positioned.fill(
                child: MobileScanner(
                  controller: _controller,
                  onDetect: _onDetect,
                ),
              ),
              Positioned.fill(
                child: AnimatedBuilder(
                  animation: _scanAnim,
                  builder: (context, _) {
                    return _ScannerOverlay(
                      progress: _scanAnim.value,
                      color: AppColors.primary,
                    );
                  },
                ),
              ),
              Positioned(
                top: 8,
                left: 8,
                right: 8,
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.of(context).maybePop(),
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () async {
                        _torchOn = !_torchOn;
                        await _controller.toggleTorch();
                        setState(() {});
                      },
                      icon: Icon(
                        _torchOn ? Icons.flash_on : Icons.flash_off,
                        color: Colors.white,
                      ),
                    ),
                    IconButton(
                      onPressed: () => _controller.switchCamera(),
                      icon: const Icon(Icons.cameraswitch, color: Colors.white),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 180 + AppDimens.safeBottom,
                child: Center(
                  child: Text(
                    'قم بمحاداة رمز الاستجابة السريعة داخل الإطار للالتقاط',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 12 * AppDimens.scale,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  padding: EdgeInsets.fromLTRB(
                      20, 20, 20, 20 + AppDimens.safeBottom),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'قراءة الكود',
                        style: TextStyle(
                          fontSize: 18 * AppDimens.scale,
                          fontWeight: FontWeight.w700,
                          color: cs.onSurface,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'قم بوضع الكاميرا على الكود الموجود أمامك',
                        style: TextStyle(
                          color: cs.onSurfaceVariant,
                          fontSize: 13 * AppDimens.scale,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ScannerOverlay extends StatelessWidget {
  final double progress;
  final Color color;
  const _ScannerOverlay({required this.progress, required this.color});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, c) {
      final size = c.biggest;
      final box = min(size.width, size.height) * 0.58;
      final rect = Rect.fromCenter(
        center: size.center(Offset.zero),
        width: box,
        height: box,
      );
      return CustomPaint(
        painter: _ScannerPainter(
          rect: rect,
          color: color,
          progress: progress,
        ),
        size: size,
      );
    });
  }
}

class _ScannerPainter extends CustomPainter {
  final Rect rect;
  final Color color;
  final double progress;

  _ScannerPainter({
    required this.rect,
    required this.color,
    required this.progress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final bg = Paint()..color = const Color(0x99000000);
    final hole = RRect.fromRectAndRadius(rect, const Radius.circular(14));
    final path = Path()
      ..addRect(Offset.zero & size)
      ..addRRect(hole)
      ..fillType = PathFillType.evenOdd;
    canvas.drawPath(path, bg);

    final p = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;
    const double len = 26;
    const r = 14.0;

    canvas.drawPath(_corner(rect.topRight, len, Corner.topRight, r), p);
    canvas.drawPath(_corner(rect.topLeft, len, Corner.topLeft, r), p);
    canvas.drawPath(_corner(rect.bottomRight, len, Corner.bottomRight, r), p);
    canvas.drawPath(_corner(rect.bottomLeft, len, Corner.bottomLeft, r), p);

    final y = rect.top + (rect.height - 8) * progress;
    final lp = Paint()
      ..color = color
      ..strokeWidth = 2.5;
    canvas.drawLine(Offset(rect.left + 8, y), Offset(rect.right - 8, y), lp);
  }

  @override
  bool shouldRepaint(covariant _ScannerPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.color != color ||
        oldDelegate.rect != rect;
  }

  Path _corner(Offset anchor, double len, Corner c, double radius) {
    final path = Path();
    switch (c) {
      case Corner.topRight:
        path.moveTo(anchor.dx - len, anchor.dy);
        path.lineTo(anchor.dx - radius, anchor.dy);
        path.arcToPoint(
          Offset(anchor.dx, anchor.dy + radius),
          radius: Radius.circular(radius),
          clockwise: true,
        );
        path.lineTo(anchor.dx, anchor.dy + len);
        break;
      case Corner.topLeft:
        path.moveTo(anchor.dx + len, anchor.dy);
        path.lineTo(anchor.dx + radius, anchor.dy);
        path.arcToPoint(
          Offset(anchor.dx, anchor.dy + radius),
          radius: Radius.circular(radius),
          clockwise: false,
        );
        path.lineTo(anchor.dx, anchor.dy + len);
        break;
      case Corner.bottomRight:
        path.moveTo(anchor.dx - len, anchor.dy);
        path.lineTo(anchor.dx - radius, anchor.dy);
        path.arcToPoint(
          Offset(anchor.dx, anchor.dy - radius),
          radius: Radius.circular(radius),
          clockwise: false,
        );
        path.lineTo(anchor.dx, anchor.dy - len);
        break;
      case Corner.bottomLeft:
        path.moveTo(anchor.dx + len, anchor.dy);
        path.lineTo(anchor.dx + radius, anchor.dy);
        path.arcToPoint(
          Offset(anchor.dx, anchor.dy - radius),
          radius: Radius.circular(radius),
          clockwise: true,
        );
        path.lineTo(anchor.dx, anchor.dy - len);
        break;
    }
    return path;
  }
}

enum Corner { topRight, topLeft, bottomRight, bottomLeft }
