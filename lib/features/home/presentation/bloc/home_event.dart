part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

final class HomeDataRequested extends HomeEvent {
  const HomeDataRequested({required this.userId});

  final int userId;

  @override
  List<Object?> get props => [userId];
}
