import 'package:fake_store_lyqx/features/auth/presentation/bloc/auth_bloc.dart';
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
      appBar: AppBar(
        leadingWidth: 70,
        leading: Padding(
          padding: const EdgeInsets.only(left: 22),
          child: Align(
            alignment: AlignmentGeometry.centerLeft,
            child: Container(
              width: 41,
              height: 41,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFE8ECF4), width: 1),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: InkWell(
                  onTap: () => context.pop(),
                  child: const Icon(
                    Icons.arrow_back_ios_new,
                    color: Color(0xFF1E232C),
                    size: 19,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('Login Successful!')));
            // Navigate to the home screen
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
          return Form(
            key: _formKey,
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
                  TextFormField(
                    controller: _usernameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your username';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      fillColor: Color(0xFFF7F8F9),
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(
                          color: Color(0xFFE8ECF4),
                          width: 1,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(
                          color: Color(0xFFE8ECF4),
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(
                          color: Color(0xFFE8ECF4),
                          width: 1,
                        ),
                      ),
                      contentPadding: EdgeInsets.only(left: 17),
                      hintText: 'Enter your username',
                      hintStyle: TextStyle(
                        color: Color(0xFF8391A1),
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Urbanist',
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _passwordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                    obscureText: _isObscure,
                    obscuringCharacter: '*',
                    decoration: InputDecoration(
                      fillColor: const Color(0xFFF7F8F9),
                      filled: true,
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _isObscure = !_isObscure;
                          });
                        },
                        icon: Icon(
                          _isObscure ? Icons.visibility : Icons.visibility_off,
                          size: 22,
                        ),
                      ),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(
                          color: Color(0xFFE8ECF4),
                          width: 1,
                        ),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(
                          color: Color(0xFFE8ECF4),
                          width: 1,
                        ),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(
                          color: Color(0xFFE8ECF4),
                          width: 1,
                        ),
                      ),
                      contentPadding: const EdgeInsets.only(left: 17),
                      hintText: 'Enter your password',
                      hintStyle: const TextStyle(
                        color: Color(0xFF8391A1),
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Urbanist',
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<AuthBloc>().add(
                            LoginRequested(
                              username: _usernameController.text,
                              password: _passwordController.text,
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1E1E1E),
                        padding: const EdgeInsets.symmetric(
                          vertical: 14,
                          horizontal: 24,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
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
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
