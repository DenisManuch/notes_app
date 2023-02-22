import 'package:flutter/material.dart';
import 'package:notes_app/core/src/main_navigation.dart';

///
class DrawerListWidget extends StatelessWidget {
  ///
  const DrawerListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: Image.asset('asset/drawer_background.png')),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        InkWell(
          onTap: () {
            Navigator.of(context).pushReplacementNamed(
                                      MainNavigationRoutesNames.homeRoute,);
          },
          child: SizedBox(
            height: 50,
            child: Row(
              children: const [
                SizedBox(
                  width: 20,
                ),
                Icon(
                  Icons.assignment_outlined,
                  size: 30,
                ),
                SizedBox(
                  width: 20,
                ),
                Text('Notes'),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        InkWell(
          onTap: () {
            print('object');
          },
          child: SizedBox(
            height: 50,
            child: Row(
              children: const [
                SizedBox(
                  width: 20,
                ),
                Icon(
                  Icons.bookmark,
                  size: 30,
                ),
                SizedBox(
                  width: 20,
                ),
                Text('Bookmark'),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ), //assignment_outlined
        InkWell(
          onTap: () {
            print('object');
          },
          child: SizedBox(
            height: 50,
            child: Row(
              children: const [
                SizedBox(
                  width: 20,
                ),
                Icon(
                  Icons.archive_outlined,
                  size: 30,
                ),
                SizedBox(
                  width: 20,
                ),
                Text('Archive'),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ), //assignment_outlined
        InkWell(
          onTap: () {
            print('object');
          },
          child: SizedBox(
            height: 50,
            child: Row(
              children: const [
                SizedBox(
                  width: 20,
                ),
                Icon(
                  Icons.delete_sweep_outlined,
                  size: 30,
                ),
                SizedBox(
                  width: 20,
                ),
                Text('Recycle Bin'),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        InkWell(
          onTap: () {
            print('object');
          },
          child: SizedBox(
            height: 50,
            child: Row(
              children: const [
                SizedBox(
                  width: 20,
                ),
                Icon(
                  Icons.settings_outlined,
                  size: 30,
                ),
                SizedBox(
                  width: 20,
                ),
                Text('Settings'),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        InkWell(
          onTap: () {
            print('object');
          },
          child: SizedBox(
            height: 50,
            child: Row(
              children: const [
                SizedBox(
                  width: 20,
                ),
                Icon(
                  Icons.question_mark_outlined,
                  size: 30,
                ),
                SizedBox(
                  width: 20,
                ),
                Text('About'),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
