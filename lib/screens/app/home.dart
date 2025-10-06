import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:greenbus_frontend/Providers/userdataprovider.dart';
import 'package:greenbus_frontend/screens/app/notis.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:greenbus_frontend/Providers/authprovider.dart' as myauth;
import 'package:greenbus_frontend/Providers/ticketprovider.dart' as myticket;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<Map<String, dynamic>> _userFuture;
  late Future<List<Map<String, dynamic>>> _transactionsFuture;

  @override
  void initState() {
    super.initState();
    final userdata = Provider.of<UserDataProvider>(context, listen: false);
    _userFuture = userdata.getdata();
    _transactionsFuture = Future.value([]);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      // give the scaffold a soft background tint to reduce all-white look
      backgroundColor: colorScheme.background.withOpacity(0.98),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: FutureBuilder<Map<String, dynamic>>(
                      future: _userFuture,
                      builder: (context, snapshot) {
                        final name = snapshot.data?['name'] ?? 'Guest';
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Welcome back',
                              style:
                                  theme.textTheme.titleLarge ??
                                  theme.textTheme.titleMedium,
                            ),
                            const SizedBox(height: 6),
                            Text(
                              name,
                              style: theme.textTheme.headlineSmall?.copyWith(
                                color: colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),

                  IconButton(
                    onPressed:
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const NotificationPage(),
                          ),
                        ),
                    icon: Icon(
                      Icons.notifications,
                      color: colorScheme.primary,
                      size: 26,
                    ),
                  ),
                ],
              ),
            ),

            // What's New — responsive carousel
            SizedBox(
              height: 160,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final cardWidth = MediaQuery.of(context).size.width * 0.78;
                  return ListView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    children: [
                      _buildNewsCard(
                        context,
                        colorScheme,
                        cardWidth,
                        "What's New",
                        'New eco-friendly buses on Route 5 — Safer, Cleaner, Greener',
                      ),
                      _buildNewsCard(
                        context,
                        colorScheme,
                        cardWidth,
                        'Tips',
                        'How to reduce your commute footprint',
                      ),
                      _buildNewsCard(
                        context,
                        colorScheme,
                        cardWidth,
                        'Service Update',
                        'Route 3 timing changed slightly',
                      ),
                    ],
                  );
                },
              ),
            ),

            const SizedBox(height: 16),

            // Quick actions
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: _buildActionTile(
                      context,
                      Icons.explore,
                      'Plan Trip',
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildActionTile(
                      context,
                      Icons.location_on,
                      'Nearby Stops',
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildActionTile(
                      context,
                      Icons.support_agent,
                      'Support',
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Transactions header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Recent Transactions',
                style: theme.textTheme.titleMedium?.copyWith(
                  color: colorScheme.primary,
                ),
              ),
            ),

            const SizedBox(height: 8),

            // Transactions list (scrollable)
            Expanded(
              child: Builder(
                builder: (context) {
                  final authProvider = Provider.of<myauth.Authprovider>(
                    context,
                    listen: false,
                  );
                  final userId = authProvider.currentUser?.uid;
                  if (userId == null) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 16,
                      ),
                      child: Text(
                        'Login to see recent transactions.',
                        style: TextStyle(
                          color: colorScheme.onBackground.withOpacity(0.7),
                        ),
                      ),
                    );
                  }

                  final ticketProvider = Provider.of<myticket.TicketProvider>(
                    context,
                    listen: false,
                  );
                  _transactionsFuture = ticketProvider.fetchUserTransactions(
                    userId,
                  );

                  return FutureBuilder<List<Map<String, dynamic>>>(
                    future: _transactionsFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      final txs = snapshot.data ?? [];
                      if (txs.isEmpty) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 16,
                          ),
                          child: Text(
                            'No recent transactions. Buy a ticket to see it here.',
                            style: TextStyle(
                              color: colorScheme.onBackground.withOpacity(0.7),
                            ),
                          ),
                        );
                      }

                      return ListView.separated(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        separatorBuilder: (_, __) => const SizedBox(height: 12),
                        itemCount: txs.length,
                        itemBuilder: (context, i) {
                          final tx = txs[i];
                          String dateText = '';
                          DateTime? dateTime;
                          try {
                            final dtField = tx['dateTime'];
                            if (dtField is DateTime) {
                              dateTime = dtField;
                            } else if (dtField is String) {
                              dateTime = DateTime.tryParse(dtField);
                            } else if (dtField is Timestamp) {
                              dateTime = dtField.toDate();
                            }
                            if (dateTime != null) {
                              dateText =
                                  '${dateTime.toLocal().day}/${dateTime.toLocal().month}/${dateTime.toLocal().year} ${dateTime.toLocal().hour.toString().padLeft(2, '0')}:${dateTime.toLocal().minute.toString().padLeft(2, '0')}';
                            } else {
                              dateText = tx['dateTime']?.toString() ?? '';
                            }
                          } catch (_) {
                            dateText = tx['dateTime']?.toString() ?? '';
                          }

                          final routeText =
                              (tx['routeName'] ??
                                      tx['route'] ??
                                      'Unknown Route')
                                  .toString();
                          final amount = tx['amount']?.toString() ?? '';

                          return Material(
                            color: Colors.transparent,
                            elevation: 4,
                            borderRadius: BorderRadius.circular(16),
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              decoration: BoxDecoration(
                                color: colorScheme.surface,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12.0,
                                  vertical: 14,
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    // Ticket badge
                                    Container(
                                      width: 56,
                                      height: 56,
                                      decoration: BoxDecoration(
                                        color: colorScheme.primary.withOpacity(
                                          0.12,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Center(
                                        child: Icon(
                                          FontAwesomeIcons.ticket,
                                          color: colorScheme.primary,
                                          size: 22,
                                        ),
                                      ),
                                    ),

                                    const SizedBox(width: 12),

                                    // Route and date
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            routeText,
                                            style: theme.textTheme.titleMedium
                                                ?.copyWith(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 16,
                                                ),
                                          ),
                                          const SizedBox(height: 6),
                                          Text(
                                            dateText,
                                            style: theme.textTheme.bodySmall
                                                ?.copyWith(
                                                  color: colorScheme
                                                      .onBackground
                                                      .withOpacity(0.6),
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    // Amount
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 8,
                                      ),
                                      decoration: BoxDecoration(
                                        color: colorScheme.primary,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            'Rs',
                                            style: theme.textTheme.bodySmall
                                                ?.copyWith(
                                                  color: colorScheme.onPrimary,
                                                ),
                                          ),
                                          const SizedBox(height: 2),
                                          Text(
                                            amount,
                                            style: theme.textTheme.titleMedium
                                                ?.copyWith(
                                                  color: colorScheme.onPrimary,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildNewsCard(
    BuildContext context,
    ColorScheme cs,
    double width,
    String title,
    String text,
  ) {
    // Surface-based news card with subtle shadow and a primary accent
    return Container(
      width: width,
      margin: const EdgeInsets.only(right: 12, top: 6, bottom: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: cs.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // small accent row
            Row(
              children: [
                Container(
                  width: 6,
                  height: 22,
                  decoration: BoxDecoration(
                    color: cs.primary,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  title,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Flexible(
              child: Text(
                text,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const Spacer(),
            Text(
              'Tap to learn more',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: cs.onBackground.withOpacity(0.6),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionTile(BuildContext context, IconData icon, String label) {
    final cs = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: () {},
      child: Material(
        elevation: 2,
        borderRadius: BorderRadius.circular(14),
        color: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: cs.surface,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.02),
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: cs.primary.withOpacity(0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: cs.primary, size: 22),
              ),
              const SizedBox(height: 8),
              Text(label, style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
        ),
      ),
    );
  }
}
