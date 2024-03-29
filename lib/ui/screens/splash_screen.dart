import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
  /// Supabase client
  final supabase = Supabase.instance.client;

  @override
  void initState() {
    //_redirect();
    // Provider.of<NotesProvider>(context, listen: false).getAllNotes();
    super.initState();
  }

  // Future<void> _redirect() async {
  //   await Future<dynamic>.delayed(const Duration(milliseconds: 1000));

  //   // final session = supabase.auth.currentSession;
  //   final Future<Session?> session = SupabaseAuth.instance.initialSession;
  //   print("session is: $session");
  //   if (session == null) {
  //     if (mounted) {
  //       return Navigator.pushAndRemoveUntil<void>(
  //         context,
  //         MaterialPageRoute<void>(
  //           builder: (BuildContext context) => const LoginScreen(),
  //         ),
  //         ModalRoute.withName('/login'),
  //       );
  //     }
  //   } else {
  //     if (mounted) {
  //       return Navigator.pushAndRemoveUntil<void>(
  //         context,
  //         MaterialPageRoute<void>(
  //           builder: (BuildContext context) => const HomeScreen(),
  //         ),
  //         ModalRoute.withName('/home'),
  //       );
  //     }
  //   }
  // }

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
