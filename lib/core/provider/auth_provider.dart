import 'package:flutter/material.dart';
import 'package:notes_app/core/supabase_services/auth_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

///
class AuthProvider extends ChangeNotifier {
  ///
  final AuthService _authService = AuthService();

  ///
  final supabase = Supabase.instance.client;

  ///
  static const supabaseSessionKey = 'supabase_session';

  ///
  bool _checkAuthVar = false;

  ///
  Future<bool> signInWithPasswordProvider(
    String email,
    String password,
  ) async {
    try {
      final trimEmail = email.trim();
      final trimPassword = password.trim();
      final success =
          await _authService.signInWithPassword(trimEmail, trimPassword);
      if (success) {
        return true;
      }
    } catch (e) {
      debugPrint('$e');

      return false;
    }

    return false;
  }

  ///
  Future<bool> singOut() async {
    try {
      final success = await _authService.signOut();

      if (success) {
        return true;
      } else {
        debugPrint('Error');
      }
    } catch (e) {
      debugPrint('$e');

      return false;
    }

    return false;
  }

  ///
  Future<bool> checkAuth() async {
    final session = SupabaseAuth.instance.initialSession;
    final session2 = supabase.auth.currentSession;//
    if (session == null) {
      _checkAuthVar = false;
      notifyListeners();

      return _checkAuthVar;
    }

    return _checkAuthVar;
  }
}
