import 'package:equatable/equatable.dart';
import 'package:fake_store_lyqx/features/auth/data/auth_repository.dart';
import 'package:fake_store_lyqx/features/auth/data/models/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

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
      final result = await _authRepository.login(
        event.username,
        event.password,
      );
      final token = result.token;
      final decodedToken = JwtDecoder.decode(token);
      final userId = decodedToken['sub'] as int;
      final user = await _authRepository.getUser(userId);
      emit(AuthSuccess(token: result.token, user: user));
    } catch (e) {
      emit(AuthFailure(message: e.toString()));
    }
  }
}
