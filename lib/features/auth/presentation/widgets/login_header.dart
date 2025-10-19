import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginHeader extends StatelessWidget implements PreferredSizeWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
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
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
