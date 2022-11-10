import 'package:flutter/material.dart';
import 'package:notes_app/core/api/api.dart';
import 'package:notes_app/core/provider/auth_provider.dart';
import 'package:notes_app/core/supabase_services/auth_service.dart';
import 'package:notes_app/ui/screens/home_widget.dart';
import 'package:notes_app/ui/screens/login_screen.dart';
import 'package:notes_app/ui/screens/register_screen.dart';
import 'package:notes_app/ui/screens/splash_screen.dart';
import 'package:provider/provider.dart' as provider;
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: supabaseUrl,
    anonKey: supabaseKey,
  );
  runApp(
    provider.MultiProvider(
      providers: [
        provider.ChangeNotifierProvider<AuthProvider>(
          create: (_) => AuthProvider(),
        ),
      ],
      child: const Main(),
    ),
  );
}

///
class Main extends StatelessWidget {
  ///
  const Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //home: const LoginScreen(),
      initialRoute: '/login',
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/home': (context) => const HomeWidget(),
        '/login': (context) => const LoginScreen(),
        '/login/register': (context) => const RegisterScreen(),
      },
    );
  }
}
