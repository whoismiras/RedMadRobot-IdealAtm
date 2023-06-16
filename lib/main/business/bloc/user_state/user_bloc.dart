import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ideal_atm/core/services/secure_storage/secure_storage.dart';
import 'package:ideal_atm/core/services/secure_storage/secure_storage_impl.dart';

part 'user_event.dart';

part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(const UserState()) {
    on<UserLoggedIn>(_onUserLoggedIn);
    on<UserLoggedOff>(_onUserLoggedOff);
    on<UserTimedOut>(_onUserTimedOut);
  }

  void _onUserLoggedIn(UserLoggedIn event, Emitter<UserState> emit) {
    emit(state.copyWith(loginState: LoginState.loggedIn));
  }

  void _onUserLoggedOff(UserLoggedOff event, Emitter<UserState> emit) {
    final SecureStorage secureStorage = SecureStorageImpl();
    secureStorage.clearSession();
    emit(state.copyWith(loginState: LoginState.loggedOff));
  }

  void _onUserTimedOut(UserTimedOut event, Emitter<UserState> emit) {
    emit(state.copyWith(loginState: LoginState.loggedOff));
  }
}
