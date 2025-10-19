import 'package:equatable/equatable.dart';
import 'package:fake_store_lyqx/features/auth/data/repository/auth_repository.dart';
import 'package:fake_store_lyqx/features/auth/data/repository/models/user_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

part 'auth_state.dart';

part 'auth_event.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({required AuthRepository authRepository})
    : _authRepository = authRepository,
      super(AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
    on<LogoutRequested>(_onLogoutRequested);
    on<AppStarted>(_onAppStarted);
    add(AppStarted());
  }

  final AuthRepository _authRepository;

  Future<void> _onAppStarted(AppStarted event, Emitter<AuthState> emit) async {
    try {
      final token = await _authRepository.getToken() as String?;
      if (token == null) {
        emit(Unauthenticated());
      } else {
        final decodedToken = JwtDecoder.decode(token);
        final userId = decodedToken['sub'] as int;
        final user = await _authRepository.getUser(userId);
        emit(AuthSuccess(token: token, user: user));
      }
    } catch (e) {
      emit(Unauthenticated());
    }
  }

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
      if (token == null) {
        throw Exception('Token is null');
      }
      final decodedToken = JwtDecoder.decode(token);
      final userId = decodedToken['sub'] as int;
      final user = await _authRepository.getUser(userId);
      await _authRepository.saveToken(token);
      emit(AuthSuccess(token: token, user: user));
    } catch (e) {
      emit(AuthFailure(message: e.toString()));
    }
  }

  Future<void> _onLogoutRequested(
    LogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    await _authRepository.deleteToken();
    emit(Unauthenticated());
  }
}
