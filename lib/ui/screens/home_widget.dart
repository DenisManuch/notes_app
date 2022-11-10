import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:notes_app/core/provider/auth_provider.dart';
import 'package:notes_app/core/supabase_services/auth_service.dart';
import 'package:provider/provider.dart';

///
class HomeWidget extends StatefulWidget {
  ///
  const HomeWidget({Key? key}) : super(key: key);

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  Future<void> _signOut() async {
    await Provider.of<AuthProvider>(context, listen: false).singOut(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: AppBar(title: const Text("data"), actions: [
        IconButton(
          onPressed: () => _signOut(),
          icon: const Icon(Icons.abc),
        ),
      ]),
      body: const GridViewWidger(),
    );
  }
}

///
class GridViewWidger extends StatelessWidget {
  ///
  const GridViewWidger({super.key});

  @override
  Widget build(BuildContext context) {
    return MasonryGridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 2,
      crossAxisSpacing: 2,
      itemBuilder: (context, index) {
        const int _randmItr = 100000000;
        final _random = Random();
        final int itr = _random.nextInt(_randmItr);

        return Card(
          child: Text('ssssdsf $itr'),
        );
      },
    );
  }
}

///
class DrawerWidget extends StatelessWidget {
  ///
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Drawer(
      child: Center(
        child: Text('Drawer'),
      ),
    );
  }
}
