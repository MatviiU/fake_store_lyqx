part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

final class HomeDataRequested extends HomeEvent {
  const HomeDataRequested({required this.user});

  final User user;

  @override
  List<Object?> get props => [user];
}
