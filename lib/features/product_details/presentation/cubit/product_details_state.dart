import 'package:equatable/equatable.dart';
import 'package:fake_store_lyqx/features/home/data/models/product_entity.dart';

sealed class ProductDetailsState extends Equatable {
  const ProductDetailsState();

  @override
  List<Object> get props => [];
}

final class ProductDetailsInitial extends ProductDetailsState {}

final class ProductDetailsLoading extends ProductDetailsState {}

final class ProductDetailsLoaded extends ProductDetailsState {
  const ProductDetailsLoaded({required this.product});

  final ProductEntity product;

  @override
  List<Object> get props => [product];
}

final class ProductDetailsError extends ProductDetailsState {
  const ProductDetailsError({required this.message});

  final String message;

  @override
  List<Object> get props => [message];
}
