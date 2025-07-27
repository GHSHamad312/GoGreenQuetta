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
              shadowColor: Theme.of(context).colorScheme.primary,
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
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Capacity: $current / $total",
                          style: TextStyle(
                            fontSize: 15,
                            color: Theme.of(
                              context,
                            ).textTheme.bodyMedium?.color?.withOpacity(0.6),
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
                                    ? Theme.of(
                                      context,
                                    ).colorScheme.error.withOpacity(0.2)
                                    : (percent >= 0.5
                                        ? Theme.of(
                                          context,
                                        ).colorScheme.secondary.withOpacity(0.2)
                                        : Theme.of(context).colorScheme.primary
                                            .withOpacity(0.18)),
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
                                      ? Theme.of(context).colorScheme.error
                                      : (percent >= 0.5
                                          ? Theme.of(
                                            context,
                                          ).colorScheme.secondary
                                          : Theme.of(
                                            context,
                                          ).colorScheme.primary),
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
      painter: _CapacityPainter(percent, context),
      child: SizedBox(
        width: 80,
        height: 80,
        child: Center(
          child: Text(
            "${(percent * 100).round()}%",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ),
          ),
        ),
      ),
    );
  }
}

class _CapacityPainter extends CustomPainter {
  final double percent;
  final BuildContext context;

  _CapacityPainter(this.percent, this.context);

  @override
  void paint(Canvas canvas, Size size) {
    final stroke = 6.0;
    final radius = min(size.width, size.height) / 2 - stroke;
    final center = Offset(size.width / 2, size.height / 2);

    final backgroundPaint =
        Paint()
          ..strokeWidth = stroke
          ..color = Theme.of(context).colorScheme.surfaceVariant
          ..style = PaintingStyle.stroke;

    final progressPaint =
        Paint()
          ..strokeWidth = stroke
          ..color =
              percent >= 0.75
                  ? Theme.of(context).colorScheme.error
                  : (percent >= 0.5
                      ? Theme.of(context).colorScheme.secondary
                      : Theme.of(context).colorScheme.primary)
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
