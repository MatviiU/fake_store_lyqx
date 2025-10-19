import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppLogoAndTitle extends StatelessWidget {
  const AppLogoAndTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset('assets/logo/logo_icon.svg'),
        const SizedBox(height: 10),
        const Text('Fake Store', style: TextStyle(fontSize: 30)),
      ],
    );
  }
}
