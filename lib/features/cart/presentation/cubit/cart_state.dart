import 'package:equatable/equatable.dart';
import 'package:fake_store_lyqx/features/cart/data/repository/models/cart_item_entity.dart';

sealed class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

final class CartInitial extends CartState {}

final class CartLoading extends CartState {}

final class CartLoaded extends CartState {
  const CartLoaded({required this.items});

  final List<CartItemEntity> items;

  @override
  List<Object> get props => [items];
}

final class CartError extends CartState {
  const CartError({required this.message});

  final String message;

  @override
  List<Object> get props => [message];
}
