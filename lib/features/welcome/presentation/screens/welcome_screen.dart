import 'package:fake_store_lyqx/features/welcome/presentation/widgets/app_logo_and_title.dart';
import 'package:fake_store_lyqx/features/welcome/presentation/widgets/welcome_background.dart';
import 'package:fake_store_lyqx/features/welcome/presentation/widgets/welcome_login_button.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: WelcomeBackground(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 22),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 250),
                AppLogoAndTitle(),
                SizedBox(height: 40),
                WelcomeLoginButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
