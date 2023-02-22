import 'package:flutter/material.dart';
import 'package:notes_app/core/api/api.dart';
import 'package:notes_app/core/provider/auth_provider.dart';
import 'package:notes_app/core/provider/notes_provider.dart';
import 'package:notes_app/core/provider/task_provider.dart';
import 'package:notes_app/core/src/main_navigation.dart';
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
        provider.ChangeNotifierProvider<NotesProvider>(
          create: (_) => NotesProvider(),
        ),
        provider.ChangeNotifierProvider<TaskProvider>(
          create: (_) => TaskProvider(),
        ),
      ],
      child: const Main(),
    ),
  );
}

///
class Main extends StatelessWidget {
  ///
  static final mainNavigation = MainNavigation();
  ///
  const Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: mainNavigation.initialRoute(true),
      routes: mainNavigation.routes,
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute<void>(
          builder: (context) {
            return const Scaffold(
              body: Center(child: Text('Ohhhhh noooooo')),
            );
          },
        );
      },
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: const Color(0xFF4859F2),
        backgroundColor: const Color(0xFF0A0C24),
        secondaryHeaderColor: Colors.black,
        textTheme: const TextTheme(
          headline1: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          headline2: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
