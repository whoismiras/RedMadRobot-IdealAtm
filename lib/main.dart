import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ideal_atm/core/l10n/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ideal_atm/main/business/bloc/map/map_bloc.dart';
import 'package:ideal_atm/main/business/cubit/internet_cubit/internet_cubit.dart';
import 'package:ideal_atm/main/business/bloc/user_state/user_bloc.dart';
import 'package:ideal_atm/main/data/providers/local_provider.dart';
import 'package:ideal_atm/main/data/shared_oreferences/app_shared_preferences.dart';
import 'package:ideal_atm/main/presentation/home_screen/home_screen.dart';
import 'package:ideal_atm/main/presentation/utils/themes.dart';
import 'package:provider/provider.dart';
import 'package:ideal_atm/di/dependency_injection.dart' as sl;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await sl.init();
  await sl.di.allReady();
  Widget screen = const HomeScreen();

  runApp(IdealAtm(screen: screen));
}

class IdealAtm extends StatelessWidget {
  const IdealAtm({Key? key, required this.screen}) : super(key: key);
  final Widget screen;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MapBloc>(
          create: (_) => MapBloc(),
        ),
        BlocProvider<InternetCubit>(
          create: (_) => InternetCubit(connectivity: Connectivity()),
        ),
        BlocProvider<UserBloc>(
          create: (context) => UserBloc(),
        )
      ],
      child: ChangeNotifierProvider(
        create: (context) =>
            LocaleProvider(sl.di<AppSharedPreferences>().locale),
        builder: (context, child) {
          return Consumer<LocaleProvider>(
            builder: (context, provider, child) {
              return MaterialApp(
                scrollBehavior: const ScrollBehavior(),
                home: screen,
                debugShowCheckedModeBanner: false,
                theme: themeLight(),
                darkTheme: themeDark(),
                routes: const {},
                localizationsDelegates: const [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                locale: provider.locale,
                supportedLocales: L10n.support,
              );
            },
          );
        },
      ),
    );
  }
}
