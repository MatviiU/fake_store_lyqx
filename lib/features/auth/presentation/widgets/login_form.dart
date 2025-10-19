import 'package:fake_store_lyqx/features/auth/presentation/widgets/custom_text_form_field.dart';
import 'package:fake_store_lyqx/features/auth/presentation/widgets/login_button.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    required this.formKey,
    required this.userNameController,
    required this.passwordController,
    required this.isObscure,
    required this.onObscureChanged,
    required this.onLoginPressed,
    super.key,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController userNameController;
  final TextEditingController passwordController;
  final bool isObscure;
  final VoidCallback onObscureChanged;
  final VoidCallback onLoginPressed;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Text(
              'Welcome back! Glad to see you, Again!',
              style: TextStyle(
                color: Color(0xFF1E232C),
                fontSize: 30,
                letterSpacing: -0.01,
                fontWeight: FontWeight.w700,
                fontFamily: 'Urbanist',
              ),
            ),
            const SizedBox(height: 20),
            CustomTextFormField(
              controller: userNameController,
              hintText: 'Enter your username',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your username';
                }
                return null;
              },
              isObscure: false,
              suffixIcon: const SizedBox.shrink(),
            ),
            const SizedBox(height: 20),
            CustomTextFormField(
              controller: passwordController,
              hintText: 'Enter your password',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                return null;
              },
              isObscure: isObscure,
              suffixIcon: IconButton(
                onPressed: onObscureChanged,
                icon: Icon(
                  isObscure ? Icons.visibility : Icons.visibility_off,
                  size: 22,
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: LoginButton(onPressed: onLoginPressed),
            ),
          ],
        ),
      ),
    );
  }
}
