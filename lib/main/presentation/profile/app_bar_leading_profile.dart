import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ideal_atm/main/business/bloc/user_state/user_bloc.dart';

class AppBarLeadingProfileScreen extends StatelessWidget {
  const AppBarLeadingProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserBloc bloc = BlocProvider.of<UserBloc>(context);
    return IconButton(
      onPressed: () => bloc.add(UserLoggedOff()),
      icon: Icon(
        Icons.logout,
        color: Theme.of(context).colorScheme.onSurface,
      ),
    );
  }
}
