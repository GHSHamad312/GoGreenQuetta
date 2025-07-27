import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:greenbus_frontend/Providers/authprovider.dart';
import 'package:greenbus_frontend/Providers/userdataprovider.dart';
import 'loginscreen.dart';

class EmailVerificationScreen extends StatefulWidget {
  final String email;
  final String password;
  final String name;
  final String phone;

  const EmailVerificationScreen({
    super.key,
    required this.email,
    required this.password,
    required this.name,
    required this.phone,
  });

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  Timer? _checkTimer;
  Timer? _cooldownTimer;
  int _resendCooldown = 30;
  bool _isCooldown = true;
  bool _isVerifying = false;

  @override
  void initState() {
    super.initState();
    _startVerificationProcess();
  }

  Future<void> _startVerificationProcess() async {
    final auth = Provider.of<Authprovider>(context, listen: false);
    final userData = Provider.of<UserDataProvider>(context, listen: false);

    try {
      // Step 1: Register user
      await auth.registerUser(widget.email, widget.password);

      // Step 2: Save data to Firestore
      await userData.savedata(widget.name, int.parse(widget.phone));

      // Step 3: Send verification email
      await auth.sendVerificationEmail();

      // Step 4: Start timers
      _startCooldown();
      _checkTimer = Timer.periodic(
        const Duration(seconds: 3),
        (_) => _checkEmailVerified(),
      );

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Verification email sent")));
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: ${e.toString()}")));
    }
  }

  void _startCooldown() {
    setState(() {
      _resendCooldown = 30;
      _isCooldown = true;
    });

    _cooldownTimer?.cancel();
    _cooldownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _resendCooldown--;
        if (_resendCooldown <= 0) {
          timer.cancel();
          _isCooldown = false;
        }
      });
    });
  }

  Future<void> _resendVerification() async {
    final auth = Provider.of<Authprovider>(context, listen: false);
    try {
      await auth.sendVerificationEmail();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Email resent")));
      _startCooldown();
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Failed to resend: $e")));
    }
  }

  Future<void> _checkEmailVerified() async {
    final auth = Provider.of<Authprovider>(context, listen: false);
    final isVerified = await auth.checkEmailVerified();

    if (isVerified) {
      _checkTimer?.cancel();
      _cooldownTimer?.cancel();
      setState(() => _isVerifying = true);

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
        (_) => false,
      );
    }
  }

  @override
  void dispose() {
    _checkTimer?.cancel();
    _cooldownTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Center(
        child:
            _isVerifying
                ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    SizedBox(height: 20),
                    Text("Verifying email...", style: TextStyle(fontSize: 18)),
                  ],
                )
                : Container(
                  padding: const EdgeInsets.all(30),
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).dividerColor,
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.mark_email_read_outlined,
                        size: 72,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Check your email",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "We've sent a verification email to:",
                        style: TextStyle(color: Colors.grey[700]),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        widget.email,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 25),
                      Text(
                        "Please verify your email to continue.",
                        style: TextStyle(color: Theme.of(context).hintColor),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 30),
                      _isCooldown
                          ? Text(
                            "You can resend in $_resendCooldown seconds",
                            style: TextStyle(
                              color: Theme.of(context).hintColor,
                            ),
                          )
                          : ElevatedButton.icon(
                            onPressed: _resendVerification,
                            icon: const Icon(Icons.refresh),
                            label: const Text("Resend Email"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Theme.of(context).colorScheme.primary,
                              foregroundColor:
                                  Theme.of(context).colorScheme.onPrimary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 14,
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
