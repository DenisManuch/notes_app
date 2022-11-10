import 'package:flutter/material.dart';

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
    // Future.delayed(const Duration(seconds: 3), () {
      
    // });
    super.initState();
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
