import 'package:equatable/equatable.dart';
import 'package:fake_store_lyqx/features/auth/data/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

part 'auth_event.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({required AuthRepository authRepository})
    : _authRepository = authRepository,
      super(AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
  }

  final AuthRepository _authRepository;

  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    try {
      final response = await _authRepository.login(
        event.username,
        event.password,
      );
      emit(AuthSuccess(token: response.token));
    } catch (e) {
      emit(AuthFailure(message: e.toString()));
    }
  }
}
