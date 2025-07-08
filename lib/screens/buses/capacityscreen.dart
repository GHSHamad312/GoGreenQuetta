import 'package:flutter/material.dart';
import 'package:greenbus_frontend/Providers/busprovider.dart';
import 'package:provider/provider.dart';
import 'dart:math';

class CapacityPage extends StatelessWidget {
  const CapacityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<BusProvider>(
      builder: (context, provider, _) {
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: provider.buses.length,
          separatorBuilder: (_, __) => const SizedBox(height: 20),
          itemBuilder: (context, index) {
            final bus = provider.buses[index];
            final busNumber = bus['busnumber'] ?? 'Unknown';
            final current = bus['currentCapacity'] ?? 0;
            final total = bus['capacity'] ?? 0;
            final percent = total > 0 ? (current / total) : 0.0;

            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              elevation: 6,
              shadowColor: const Color.fromARGB(255, 76, 175, 79),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 24,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _CircularCapacityIndicator(percent: percent),
                    const SizedBox(width: 24),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "$busNumber",
                          style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2E7D32),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Capacity: $current / $total",
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.black54,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color:
                                percent >= 0.75
                                    ? const Color.fromARGB(52, 255, 82, 82)
                                    : (percent >= 0.5
                                        ? const Color.fromARGB(51, 255, 153, 0)
                                        : const Color.fromARGB(
                                          47,
                                          76,
                                          175,
                                          79,
                                        )),
                          ),
                          child: Text(
                            percent >= 0.75
                                ? "Almost Full"
                                : (percent >= 0.5
                                    ? "Moderate"
                                    : "Plenty of Seats"),
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 13.5,
                              color:
                                  percent >= 0.75
                                      ? Colors.redAccent
                                      : (percent >= 0.5
                                          ? Colors.orange
                                          : Colors.green),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class _CircularCapacityIndicator extends StatelessWidget {
  final double percent;

  const _CircularCapacityIndicator({required this.percent});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _CapacityPainter(percent),
      child: SizedBox(
        width: 80,
        height: 80,
        child: Center(
          child: Text(
            "${(percent * 100).round()}%",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: Colors.black87,
            ),
          ),
        ),
      ),
    );
  }
}

class _CapacityPainter extends CustomPainter {
  final double percent;

  _CapacityPainter(this.percent);

  @override
  void paint(Canvas canvas, Size size) {
    final stroke = 6.0;
    final radius = min(size.width, size.height) / 2 - stroke;
    final center = Offset(size.width / 2, size.height / 2);

    final backgroundPaint =
        Paint()
          ..strokeWidth = stroke
          ..color = Colors.grey.shade300
          ..style = PaintingStyle.stroke;

    final progressPaint =
        Paint()
          ..strokeWidth = stroke
          ..color =
              percent >= 0.75
                  ? Colors.redAccent
                  : (percent >= 0.5 ? Colors.orange : Colors.green)
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, backgroundPaint);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      2 * pi * percent,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
