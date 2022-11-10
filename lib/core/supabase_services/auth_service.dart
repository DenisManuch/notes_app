import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

///
class AuthService {
  ///
  final supabase = Supabase.instance.client;

  ///
  static const supabaseSessionKey = 'supabase_session';

  ///
  Future<bool> signUp(String email, String password) async {
    final res = await supabase.auth.signUp(email: email, password: password);
    try {
      debugPrint('done!');
    } catch (e) {
      debugPrint('$e');
    }

    return true;
  }

  ///
  Future<bool> signInWithPassword(String email, String password) async {
    try {
      final res = await supabase.auth
          .signInWithPassword(email: email, password: password);
      //debugPrint(res.user as String);

      return true;
    } catch (e) {
      debugPrint('$e');

      return false;
    }
  }

  ///
  Future<bool> signOut() async {
    final res = supabase.auth.signOut();
    debugPrint('${res}');

    return true;
  }

  Future<void> _persistSession(Session session) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(supabaseSessionKey, session.persistSessionString);
  }

  ///
  Future<bool> getInitialAuthState() async {
    try {
      await SupabaseAuth.instance.initialSession;
      // Redirect users to different screens depending on the initial session

      return true;
    } catch (e) {
      // Handle initial auth state fetch error here
      return false;
    }
  }

  ///
  // Future<bool> recoverSession() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   if (prefs.containsKey(supabaseSessionKey)) {
  //     final jsonStr = prefs.getString(supabaseSessionKey) ?? '';
  //     final response = await _client.recoverSession(jsonStr);
  //     if (response.error == null) {
  //       await _persistSession(response.data ?? const Session(accessToken: ''));

  //       return true;
  //     }
  //   }

  //   return false;
  // }
}
