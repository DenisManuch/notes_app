import 'package:flutter/material.dart';
import 'package:notes_app/ui/screens/add_note_screen.dart';
import 'package:notes_app/ui/screens/detail_screen.dart';
import 'package:notes_app/ui/screens/home_screen.dart';
import 'package:notes_app/ui/screens/login_screen.dart';
import 'package:notes_app/ui/screens/register_screen.dart';
import 'package:notes_app/ui/screens/splash_screen.dart';

///
class MainNavigation {
  
  ///
  final routes = <String, Widget Function(BuildContext)>{
    '/splash': (context) => const SplashScreen(),
    '/home': (context) => const HomeScreen(),
    '/home/detail': (context) => const DetailScreen(),
    '/login': (context) => const LoginScreen(),
    '/login/register': (context) => const RegisterScreen(),
    '/home/addnote': (context) => const AddNoteScreen(),
  };
  ///
  String initialRoute({required bool isAuth}) => isAuth
      ? MainNavigationRoutesNames.homeRoute
      : MainNavigationRoutesNames.loginRoute;
}

///
abstract class MainNavigationRoutesNames {
  ///
  static const splashRoute = '/splash';

  ///
  static const loginRoute = '/login';

  ///
  static const registerRoute = '/login/register';

  ///
  static const homeRoute = '/home';

  ///
  static const detailRoute = '/home/detail';
}
