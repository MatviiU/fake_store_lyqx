import 'package:fake_store_lyqx/core/navigation/screen_names.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WelcomeLoginButton extends StatelessWidget {
  const WelcomeLoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: () => context.pushNamed(ScreenNames.login),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF1E1E1E),
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        ),
        child: const Text(
          'Login',
          style: TextStyle(
            fontFamily: 'Intern',
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
