import 'package:flutter/material.dart';
import 'package:ideal_atm/main/presentation/home_screen/home_screen.dart';
import 'package:ideal_atm/main/presentation/profile/profile_screen.dart';
import 'package:ideal_atm/main/presentation/authorization/authorization_screen.dart';
import 'package:ideal_atm/main/presentation/utility_screens/pdf_screen.dart';
import 'package:ideal_atm/main/presentation/registration/registration_screen.dart';
import 'package:ideal_atm/main/presentation/qr/qr_screen.dart';
import 'package:ideal_atm/main/presentation/search/list_screen.dart';
import 'package:ideal_atm/main/presentation/search/map_screen.dart';

class AppRouter {
  static void back(BuildContext context) {
    if (Navigator.of(context).canPop()) Navigator.of(context).pop();
    return;
  }

  static void replaceWithListScreen(BuildContext context) {
    final route = MaterialPageRoute(builder: (context) => const ListScreen());
    Navigator.pushReplacement(context, route);
  }

  static void replaceWithMapScreen(BuildContext context) {
    final route = MaterialPageRoute(builder: (context) => const MapScreen());
    Navigator.pushReplacement(context, route);
  }

  static void toProfile(BuildContext context) {
    final route = MaterialPageRoute(builder: (_) => const ProfileScreen());
    Navigator.of(context).push(route);
  }

  static void toAuth(BuildContext context) {
    final route =
        MaterialPageRoute(builder: (_) => const AuthorizationScreen());
    Navigator.of(context).push(route);
  }

  static void toHomePage(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const HomeScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return child;
        },
      ),
      (route) => false,
    );
  }

  static void toScanQr(BuildContext context) {
    final route = MaterialPageRoute(builder: (_) => const QrScreen());
    Navigator.of(context).push(route);
  }

  static void toMapScreen(BuildContext context) {
    final route = MaterialPageRoute(builder: (_) => const MapScreen());
    Navigator.of(context).push(route);
  }

  static void toListScreen(BuildContext context) {
    final route = MaterialPageRoute(builder: (_) => const ListScreen());
    Navigator.of(context).push(route);
  }

  static void toReg(BuildContext context) {
    final route = MaterialPageRoute(builder: (_) => const RegistrationScreen());
    Navigator.of(context).push(route);
  }

  static void toPDF(BuildContext context, String asset) {
    final route = MaterialPageRoute(builder: (_) => PDFScreen(asset: asset));
    Navigator.of(context).push(route);
  }
}
