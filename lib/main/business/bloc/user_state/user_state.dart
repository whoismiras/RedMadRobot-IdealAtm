part of 'user_bloc.dart';

enum LoginState { loggedIn, loggedOff }

class UserState extends Equatable {
  const UserState({this.loginState = LoginState.loggedOff});

  final LoginState loginState;

  UserState copyWith({LoginState? loginState}) {
    return UserState(loginState: loginState ?? this.loginState);
  }

  @override
  List<Object?> get props => [loginState];
}
