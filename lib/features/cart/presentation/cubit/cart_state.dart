import 'package:equatable/equatable.dart';
import 'package:fake_store_lyqx/features/cart/data/repository/models/cart_entity.dart';

sealed class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

final class CartInitial extends CartState {}

final class CartLoading extends CartState {}

final class CartLoaded extends CartState {
  const CartLoaded({required this.cart});

  final CartEntity cart;

  @override
  List<Object> get props => [cart];
}

final class CartDeleted extends CartState {}

final class CartError extends CartState {
  const CartError({required this.message});

  final String message;

  @override
  List<Object> get props => [message];
}
