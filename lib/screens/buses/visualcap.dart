import 'package:flutter/material.dart';

class BusCapacityDetail extends StatelessWidget {
  final String busNumber;
  final int currentCapacity;
  final int totalCapacity;

  const BusCapacityDetail({
    required this.busNumber,
    required this.currentCapacity,
    required this.totalCapacity,
  });

  @override
  Widget build(BuildContext context) {
    int seatsPerRow = 4; // 2 seats on each side of aisle
    int totalRows = (totalCapacity / seatsPerRow).ceil();

    return Scaffold(
      appBar: AppBar(
        title: Text('$busNumber Capacity'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              '$currentCapacity / $totalCapacity seats occupied',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: totalRows,
                itemBuilder: (context, rowIndex) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(5, (seatIndex) {
                        // 0,1 => Left seats, 2 => aisle, 3,4 => Right seats
                        if (seatIndex == 2) {
                          return SizedBox(width: 24); // aisle gap
                        } else {
                          int seatNumber =
                              rowIndex * seatsPerRow +
                              (seatIndex > 2 ? seatIndex - 1 : seatIndex);
                          bool isOccupied = seatNumber < currentCapacity;
                          if (seatNumber >= totalCapacity) {
                            return SizedBox(width: 24); // skip seat rendering
                          }
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 4.0,
                            ),
                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                color:
                                    isOccupied
                                        ? Theme.of(context).colorScheme.primary
                                        : Theme.of(
                                          context,
                                        ).colorScheme.surfaceVariant,
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                  color: Theme.of(context).dividerColor,
                                ),
                              ),
                            ),
                          );
                        }
                      }),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
