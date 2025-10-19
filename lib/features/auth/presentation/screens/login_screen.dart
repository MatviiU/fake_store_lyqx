import 'package:fake_store_lyqx/core/navigation/screen_names.dart';
import 'package:fake_store_lyqx/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:fake_store_lyqx/features/auth/presentation/widgets/login_form.dart';
import 'package:fake_store_lyqx/features/auth/presentation/widgets/login_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController _usernameController;
  late final TextEditingController _passwordController;
  final _formKey = GlobalKey<FormState>();
  var _isObscure = true;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const LoginHeader(),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('Login Successful!')));
            context.goNamed(ScreenNames.home, extra: state.user);
          } else if (state is AuthFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return LoginForm(
            formKey: _formKey,
            userNameController: _usernameController,
            passwordController: _passwordController,
            isObscure: _isObscure,
            onObscureChanged: () {
              setState(() {
                _isObscure = !_isObscure;
              });
            },
            onLoginPressed: () {
              if (_formKey.currentState!.validate()) {
                context.read<AuthBloc>().add(
                  LoginRequested(
                    username: _usernameController.text,
                    password: _passwordController.text,
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }
}
