import 'package:fake_store_lyqx/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartHeader extends StatelessWidget {
  const CartHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Cart',
          style: TextStyle(
            fontSize: 24,
            fontFamily: 'Urbanist',
            fontWeight: FontWeight.w600,
            color: Color(0xFF252425),
          ),
        ),
        Column(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFffe7ab),
              ),
              child: Center(
                child: IconButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(LogoutRequested());
                  },
                  icon: const Icon(size: 18, Icons.logout, color: Colors.black),
                ),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Logout',
              style: TextStyle(
                fontFamily: 'Lato',
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Color(0xFF3A3A3A),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
