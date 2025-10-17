import 'package:equatable/equatable.dart';
import 'package:fake_store_lyqx/features/home/data/models/product_entity.dart';

sealed class FavoritesState extends Equatable {
  const FavoritesState();

  @override
  List<Object> get props => [];
}

final class FavoritesInitial extends FavoritesState {}

final class FavoritesLoading extends FavoritesState {}

final class FavoritesLoaded extends FavoritesState {
  const FavoritesLoaded({required this.favoritesIds, required this.products});

  final List<ProductEntity> products;
  final List<int> favoritesIds;

  @override
  List<Object> get props => [favoritesIds, products];
}

final class FavoritesError extends FavoritesState {
  const FavoritesError({required this.message});

  final String message;

  @override
  List<Object> get props => [message];
}
