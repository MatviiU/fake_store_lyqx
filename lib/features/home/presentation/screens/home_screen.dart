import 'package:fake_store_lyqx/features/home/presentation/bloc/home_bloc.dart';
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
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 35,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome, \n${state.user.username}',
                          style: const TextStyle(
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
                                  onPressed: () {},
                                  icon: const Icon(
                                    size: 18,
                                    Icons.logout,
                                    color: Colors.black,
                                  ),
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
                    ),
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
                    Expanded(
                      child: ListView.separated(
                        itemBuilder: (context, index) {
                          final product = state.products[index];
                          return Column(
                            spacing: 8,
                            children: [
                              InkWell(
                                onTap: () {},
                                borderRadius: BorderRadius.circular(12),
                                child: Container(
                                  height: 120,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.black.withValues(alpha: 0.05),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 12,
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 90,
                                          height: 90,
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                          ),
                                          child: Image.network(
                                            product.image,
                                            fit: BoxFit.contain,
                                            loadingBuilder:
                                                (
                                                  context,
                                                  child,
                                                  loadingProgress,
                                                ) {
                                                  if (loadingProgress == null) {
                                                    return child;
                                                  }
                                                  return const Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  );
                                                },
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                                  return const Center(
                                                    child: Icon(Icons.error),
                                                  );
                                                },
                                          ),
                                        ),
                                        const SizedBox(width: 16),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      product.title,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 2,
                                                      style: const TextStyle(
                                                        fontFamily: 'Urbanist',
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 8),
                                                  SizedBox(
                                                    width: 24,
                                                    height: 24,
                                                    child: IconButton(
                                                      onPressed: () {},
                                                      padding: EdgeInsets.zero,
                                                      icon: const Icon(
                                                        Icons.favorite_border,
                                                        size: 20,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 8),
                                              Row(
                                                children: [
                                                  const Icon(
                                                    Icons.star,
                                                    size: 10,
                                                    color: Colors.black,
                                                  ),
                                                  const SizedBox(width: 4),
                                                  Text(
                                                    '${product.rate}',
                                                    style: const TextStyle(
                                                      fontFamily: 'Urbanist',
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Color(0xFF303539),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const Spacer(),
                                              Text(
                                                '\$${product.price.toStringAsFixed(2)}',
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 20),
                        itemCount: state.products.length,
                      ),
                    ),
                  ],
                ),
              ),
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
