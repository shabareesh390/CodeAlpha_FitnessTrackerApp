import 'dart:math';
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// Custom painted animated water bottle widget.
class WaterBottle extends StatefulWidget {
  final double progress; // 0.0 to 1.0
  final double width;
  final double height;

  const WaterBottle({
    Key? key,
    required this.progress,
    this.width = 120,
    this.height = 220,
  }) : super(key: key);

  @override
  State<WaterBottle> createState() => _WaterBottleState();
}

class _WaterBottleState extends State<WaterBottle>
    with TickerProviderStateMixin {
  late AnimationController _waveController;
  late AnimationController _fillController;
  late Animation<double> _fillAnimation;

  @override
  void initState() {
    super.initState();
    _waveController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    _fillController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _fillAnimation = Tween<double>(begin: 0, end: widget.progress).animate(
      CurvedAnimation(parent: _fillController, curve: Curves.easeOutCubic),
    );

    _fillController.forward();
  }

  @override
  void didUpdateWidget(covariant WaterBottle oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.progress != widget.progress) {
      _fillAnimation = Tween<double>(
        begin: _fillAnimation.value,
        end: widget.progress,
      ).animate(
        CurvedAnimation(parent: _fillController, curve: Curves.easeOutCubic),
      );
      _fillController.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _waveController.dispose();
    _fillController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([_waveController, _fillAnimation]),
      builder: (context, child) {
        return CustomPaint(
          size: Size(widget.width, widget.height),
          painter: _WaterBottlePainter(
            fillLevel: _fillAnimation.value,
            wavePhase: _waveController.value * 2 * pi,
          ),
        );
      },
    );
  }
}

class _WaterBottlePainter extends CustomPainter {
  final double fillLevel;
  final double wavePhase;

  _WaterBottlePainter({
    required this.fillLevel,
    required this.wavePhase,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final bottleWidth = size.width * 0.6;
    final bottleHeight = size.height * 0.7;
    final neckWidth = size.width * 0.3;
    final neckHeight = size.height * 0.15;
    final capHeight = size.height * 0.08;

    final centerX = size.width / 2;
    final bottleTop = capHeight + neckHeight;
    final bottleBottom = size.height;
    final cornerRadius = bottleWidth * 0.2;

    // ─── Draw Bottle Outline ───
    final bottlePath = Path();

    // Cap
    final capRect = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: Offset(centerX, capHeight / 2),
        width: neckWidth + 10,
        height: capHeight,
      ),
      Radius.circular(capHeight / 3),
    );
    canvas.drawRRect(
      capRect,
      Paint()..color = AppColors.water.withValues(alpha: 0.3),
    );

    // Neck
    bottlePath.moveTo(centerX - neckWidth / 2, capHeight);
    bottlePath.lineTo(centerX - neckWidth / 2, bottleTop);

    // Left shoulder curve
    bottlePath.quadraticBezierTo(
      centerX - bottleWidth / 2,
      bottleTop,
      centerX - bottleWidth / 2,
      bottleTop + cornerRadius,
    );

    // Left side
    bottlePath.lineTo(centerX - bottleWidth / 2, bottleBottom - cornerRadius);

    // Bottom left curve
    bottlePath.quadraticBezierTo(
      centerX - bottleWidth / 2,
      bottleBottom,
      centerX - bottleWidth / 2 + cornerRadius,
      bottleBottom,
    );

    // Bottom
    bottlePath.lineTo(centerX + bottleWidth / 2 - cornerRadius, bottleBottom);

    // Bottom right curve
    bottlePath.quadraticBezierTo(
      centerX + bottleWidth / 2,
      bottleBottom,
      centerX + bottleWidth / 2,
      bottleBottom - cornerRadius,
    );

    // Right side
    bottlePath.lineTo(centerX + bottleWidth / 2, bottleTop + cornerRadius);

    // Right shoulder curve
    bottlePath.quadraticBezierTo(
      centerX + bottleWidth / 2,
      bottleTop,
      centerX + neckWidth / 2,
      bottleTop,
    );

    // Right neck
    bottlePath.lineTo(centerX + neckWidth / 2, capHeight);

    bottlePath.close();

    // Draw bottle border
    canvas.drawPath(
      bottlePath,
      Paint()
        ..color = AppColors.water.withValues(alpha: 0.25)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2,
    );

    // ─── Draw Water Fill ───
    if (fillLevel > 0) {
      canvas.save();
      canvas.clipPath(bottlePath);

      final waterBottom = bottleBottom;
      final waterMaxHeight = bottleBottom - bottleTop - 5;
      final waterTop = waterBottom - (waterMaxHeight * fillLevel);

      // Draw water with wave
      final waterPath = Path();
      waterPath.moveTo(0, waterBottom);
      waterPath.lineTo(0, waterTop);

      // Wave effect
      for (double x = 0; x <= size.width; x += 1) {
        final y = waterTop +
            sin((x / size.width * 2 * pi) + wavePhase) * 3 +
            cos((x / size.width * 3 * pi) + wavePhase * 0.7) * 2;
        waterPath.lineTo(x, y);
      }

      waterPath.lineTo(size.width, waterBottom);
      waterPath.close();

      // Water gradient
      final waterPaint = Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.water.withValues(alpha: 0.6),
            AppColors.water.withValues(alpha: 0.9),
          ],
        ).createShader(Rect.fromLTWH(0, waterTop, size.width, waterBottom - waterTop));

      canvas.drawPath(waterPath, waterPaint);

      // Surface highlight
      final highlightPaint = Paint()
        ..color = Colors.white.withValues(alpha: 0.2)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);

      final highlightPath = Path();
      highlightPath.moveTo(centerX - bottleWidth * 0.3, waterTop);
      for (double x = centerX - bottleWidth * 0.3;
          x <= centerX + bottleWidth * 0.3;
          x += 1) {
        final y = waterTop +
            sin((x / size.width * 2 * pi) + wavePhase) * 3;
        highlightPath.lineTo(x, y);
      }
      highlightPath.lineTo(centerX + bottleWidth * 0.3, waterTop + 5);
      highlightPath.lineTo(centerX - bottleWidth * 0.3, waterTop + 5);
      highlightPath.close();

      canvas.drawPath(highlightPath, highlightPaint);

      canvas.restore();
    }

    // ─── Graduation marks ───
    for (int i = 1; i <= 4; i++) {
      final markY = bottleBottom - (bottleHeight * i / 5);
      if (markY > bottleTop) {
        canvas.drawLine(
          Offset(centerX - bottleWidth / 2 + 5, markY),
          Offset(centerX - bottleWidth / 2 + 15, markY),
          Paint()
            ..color = AppColors.water.withValues(alpha: 0.2)
            ..strokeWidth = 1,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant _WaterBottlePainter oldDelegate) {
    return oldDelegate.fillLevel != fillLevel ||
        oldDelegate.wavePhase != wavePhase;
  }
}
