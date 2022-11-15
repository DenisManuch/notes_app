// ignore_for_file: avoid_dynamic_calls

import 'package:flutter/material.dart';
import 'package:notes_app/core/provider/notes_provider.dart';
import 'package:notes_app/ui/screens/home_screen.dart';
import 'package:notes_app/ui/screens/login_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:provider/provider.dart';

///
class SplashScreen extends StatelessWidget {
  ///
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ProgressIndicatorWidget(),
    );
  }
}

///
class ProgressIndicatorWidget extends StatefulWidget {
  ///
  const ProgressIndicatorWidget({super.key});

  @override
  State<ProgressIndicatorWidget> createState() =>
      _ProgressIndicatorWidgetState();
}

class _ProgressIndicatorWidgetState extends State<ProgressIndicatorWidget> {
  @override
  void initState() {
    _redirect();
    //Provider.of<NotesProvider>(context, listen: false).getAllNotes();
    super.initState();
  }

  /// Supabase client
  final supabase = Supabase.instance.client;

  Future<void> _redirect() async {
    // await for for the widget to mount
    await Future<dynamic>.delayed(Duration.zero);

    final session = supabase.auth.currentSession;
    if (session == null) {
      await Navigator.pushAndRemoveUntil<void>(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => const LoginScreen(),
        ),
        ModalRoute.withName('/login'),
      );
    } else {
      await context.read<NotesProvider>().getAllNotesFromSupabase();
      await Navigator.pushAndRemoveUntil<void>(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => const HomeScreen(),
        ),
        ModalRoute.withName('/home'),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: Colors.black,
      ),
    );
  }
}

///
class NextPageWidget extends StatelessWidget {
  ///
  const NextPageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
