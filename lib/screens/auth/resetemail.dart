import 'dart:async';
import 'package:flutter/material.dart';
import 'package:greenbus_frontend/Providers/authprovider.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController emailController = TextEditingController();
  bool _isSending = false;
  bool _onCooldown = false;
  int _cooldownSeconds = 60;
  Timer? _timer;

  void _startCooldownTimer() {
    setState(() {
      _onCooldown = true;
      _cooldownSeconds = 30;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _cooldownSeconds--;
        if (_cooldownSeconds == 0) {
          _onCooldown = false;
          timer.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double bdr = 15;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 80),
              Image.asset("assets/transparent/logoGreenQuetta.png", width: 220),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 40,
                    horizontal: 20,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(bdr),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        "Reset Password",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 30),
                      TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          labelText: "Enter your email",
                          labelStyle: TextStyle(
                            color: Theme.of(context).hintColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 18,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(bdr),
                            borderSide: BorderSide(
                              color: Theme.of(
                                context,
                              ).colorScheme.primary.withOpacity(0.2),
                              width: 2,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(bdr),
                            borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.primary,
                              width: 2,
                            ),
                          ),
                          fillColor: Theme.of(context).cardColor,
                          filled: true,
                        ),
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        onPressed:
                            _onCooldown || _isSending
                                ? null
                                : () async {
                                  setState(() {
                                    _isSending = true;
                                  });
                                  try {
                                    sendreset(emailController.text.trim());
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text("Reset email sent."),
                                      ),
                                    );
                                    _startCooldownTimer();
                                  } catch (e) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          "Failed to send reset email.",
                                        ),
                                      ),
                                    );
                                  } finally {
                                    setState(() {
                                      _isSending = false;
                                    });
                                  }
                                },
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          foregroundColor:
                              Theme.of(context).colorScheme.onPrimary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(bdr),
                          ),
                        ),
                        child:
                            _onCooldown
                                ? Text("Wait $_cooldownSeconds sec")
                                : _isSending
                                ? CircularProgressIndicator(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                )
                                : const Text(
                                  "Send Reset Link",
                                  style: TextStyle(fontSize: 18),
                                ),
                      ),
                    ],
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  style: TextButton.styleFrom(
                    foregroundColor: Theme.of(context).colorScheme.primary,
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                        width: 1.5,
                      ),
                    ),
                    backgroundColor: Theme.of(
                      context,
                    ).colorScheme.primary.withOpacity(0.08),
                  ),
                  child: const Text("Back to Login"),
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
