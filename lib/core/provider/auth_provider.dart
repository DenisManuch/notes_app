import 'package:flutter/material.dart';
import 'package:notes_app/core/supabase_services/auth_service.dart';
import 'package:notes_app/ui/screens/home_widget.dart';
import 'package:notes_app/ui/screens/login_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

///
class AuthProvider extends ChangeNotifier {
  ///
  bool _clientSession = true;

  ///
  final AuthService _authService = AuthService();

  ///
  final supabase = Supabase.instance.client;

  ///
  static const supabaseSessionKey = 'supabase_session';

  ///
  Future<void> signInWithPasswordProvider(
    BuildContext context,
    String email,
    String password,
  ) async {
    try {
      final trimEmail = email.trim();
      final trimPassword = password.trim();
      final success =
          await _authService.signInWithPassword(trimEmail, trimPassword);
      print(success);
      if (success) {
        await Navigator.pushAndRemoveUntil<void>(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => const HomeWidget(),
          ),
          ModalRoute.withName('/home'),
        );
        notifyListeners();
      }
    } catch (e) {
      debugPrint('$e');
    }
  }

  ///
  Future<void> singOut(BuildContext context) async {
    try {
      final success = await _authService.signOut();

      if (success) {
        await Navigator.pushAndRemoveUntil<void>(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => const LoginScreen(),
          ),
          ModalRoute.withName('/login'),
        );
        notifyListeners();
      } else {
        debugPrint('Error');
      }
    } catch (e) {
      debugPrint('$e');
    }
  }

  ///
  // Future<bool?> initialAuth() async {
  //   _clientSession = AuthService().getInitialAuthState();
  //   notifyListeners();

  //   return _clientSession;
  // }
}
