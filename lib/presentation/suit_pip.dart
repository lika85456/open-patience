import 'package:flutter/material.dart';

import '../core/card.dart';

/// A filled suit silhouette centred at ([cx], [cy]) with overall size [s].
///
/// Suits are drawn as vector paths instead of Unicode text glyphs. Some
/// platforms render ♠ ♥ ♦ ♣ as colour emoji, which ignores the requested ink
/// colour and looks out of place on a playing card.
///
/// [index]: 0 = spades, 1 = hearts, 2 = diamonds, 3 = clubs.
Path suitPath(int index, double cx, double cy, double s) {
  switch (index % 4) {
    case 1:
      return _heart(cx, cy, s);
    case 2:
      return _diamond(cx, cy, s);
    case 3:
      return _club(cx, cy, s);
    default:
      return _spade(cx, cy, s);
  }
}

/// The path index of a [Suit] in [suitPath].
int suitIndex(Suit suit) => switch (suit) {
  Suit.spades => 0,
  Suit.hearts => 1,
  Suit.diamonds => 2,
  Suit.clubs => 3,
};

Path _heart(double cx, double cy, double s) => Path()
  ..moveTo(cx, cy + s * 0.34)
  ..cubicTo(
    cx - s * 0.52,
    cy - s * 0.02,
    cx - s * 0.5,
    cy - s * 0.46,
    cx,
    cy - s * 0.16,
  )
  ..cubicTo(
    cx + s * 0.5,
    cy - s * 0.46,
    cx + s * 0.52,
    cy - s * 0.02,
    cx,
    cy + s * 0.34,
  )
  ..close();

Path _diamond(double cx, double cy, double s) => Path()
  ..moveTo(cx, cy - s * 0.44)
  ..lineTo(cx + s * 0.32, cy)
  ..lineTo(cx, cy + s * 0.44)
  ..lineTo(cx - s * 0.32, cy)
  ..close();

Path _spade(double cx, double cy, double s) {
  final Path p = Path()
    ..moveTo(cx, cy - s * 0.42)
    ..cubicTo(
      cx + s * 0.5,
      cy - s * 0.02,
      cx + s * 0.5,
      cy + s * 0.3,
      cx,
      cy + s * 0.12,
    )
    ..cubicTo(
      cx - s * 0.5,
      cy + s * 0.3,
      cx - s * 0.5,
      cy - s * 0.02,
      cx,
      cy - s * 0.42,
    )
    ..close();
  p
    ..moveTo(cx - s * 0.14, cy + s * 0.4)
    ..lineTo(cx + s * 0.14, cy + s * 0.4)
    ..lineTo(cx + s * 0.05, cy + s * 0.1)
    ..lineTo(cx - s * 0.05, cy + s * 0.1)
    ..close();
  return p;
}

Path _club(double cx, double cy, double s) {
  final double r = s * 0.19;
  final Path p = Path()
    ..addOval(Rect.fromCircle(center: Offset(cx, cy - s * 0.2), radius: r))
    ..addOval(
      Rect.fromCircle(center: Offset(cx - s * 0.23, cy + s * 0.06), radius: r),
    )
    ..addOval(
      Rect.fromCircle(center: Offset(cx + s * 0.23, cy + s * 0.06), radius: r),
    );
  p
    ..moveTo(cx - s * 0.13, cy + s * 0.42)
    ..lineTo(cx + s * 0.13, cy + s * 0.42)
    ..lineTo(cx + s * 0.05, cy + s * 0.05)
    ..lineTo(cx - s * 0.05, cy + s * 0.05)
    ..close();
  return p;
}

class _SuitPainter extends CustomPainter {
  const _SuitPainter({required this.index, required this.color});

  final int index;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawPath(
      suitPath(index, size.width / 2, size.height / 2, size.shortestSide),
      Paint()..color = color,
    );
  }

  @override
  bool shouldRepaint(_SuitPainter old) =>
      old.index != index || old.color != color;
}

/// A vector suit pip. [size] is the width and height of the square draw area.
class SuitPip extends StatelessWidget {
  const SuitPip({
    required this.suit,
    required this.color,
    required this.size,
    super.key,
  }) : index = null;

  /// A suit by path index, for decorative rows that are not tied to a card.
  const SuitPip.index({
    required this.index,
    required this.color,
    required this.size,
    super.key,
  }) : suit = null;

  final Suit? suit;
  final int? index;
  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) => SizedBox(
    width: size,
    height: size,
    child: CustomPaint(
      painter: _SuitPainter(
        index: suit == null ? index! : suitIndex(suit!),
        color: color,
      ),
    ),
  );
}
