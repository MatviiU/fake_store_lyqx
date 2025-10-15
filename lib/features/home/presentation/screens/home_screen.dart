import 'package:fake_store_lyqx/features/home/presentation/bloc/home_bloc.dart';
import 'package:fake_store_lyqx/features/home/presentation/widgets/home_header.dart';
import 'package:fake_store_lyqx/features/home/presentation/widgets/product_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return switch (state) {
          HomeLoaded() => Scaffold(
            extendBody: true,
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 35,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HomeHeader(user: state.user),
                    const SizedBox(height: 30),
                    const Text(
                      'Fake Store',
                      style: TextStyle(
                        fontFamily: 'Urbanist',
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF252425),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ProductListWidget(products: state.products),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              iconSize: 30,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home_outlined,
                    color: Color(0xFFCBCBD4),
                    weight: 1.5,
                  ),
                  activeIcon: Icon(
                    Icons.home_outlined,
                    color: Colors.black,
                    weight: 1.5,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.favorite_border_outlined,
                    color: Color(0xFFCBCBD4),
                    weight: 1.5,
                  ),
                  activeIcon: Icon(
                    Icons.favorite_border_outlined,
                    color: Colors.black,
                    weight: 1.5,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.shopping_bag_outlined,
                    color: Color(0xFFCBCBD4),
                    weight: 1.5,
                  ),
                  activeIcon: Icon(
                    Icons.shopping_bag_outlined,
                    color: Colors.black,
                    weight: 1.5,
                  ),
                  label: '',
                ),
              ],
            ),
          ),
          HomeInitial() ||
          HomeLoading() => const Center(child: CircularProgressIndicator()),
          HomeError() => Center(child: Text(state.message)),
        };
      },
    );
  }
}
