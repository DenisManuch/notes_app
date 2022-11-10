import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:notes_app/core/models/note_model.dart';
import 'package:notes_app/core/provider/auth_provider.dart';
import 'package:notes_app/core/provider/notes_provider.dart';
import 'package:notes_app/core/provider/task_provider.dart';
import 'package:notes_app/core/src/constants.dart';
import 'package:provider/provider.dart';

///
class HomeScreen extends StatefulWidget {
  ///
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<void> _signOut() async {
    //await Provider.of<NotesProvider>(context, listen: false).getAllNotes();
    await Provider.of<AuthProvider>(context, listen: false).singOut(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: AppBar(
        title: const Text("data"),
        actions: [
          IconButton(
            onPressed: () => _signOut(),
            icon: const Icon(Icons.abc),
          ),
        ],
      ),
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
    return FutureBuilder<List<NoteModel>>(
      future: Provider.of<NotesProvider>(context, listen: false).getAllNotes(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: Text('fg'),
          );
        }
        if (snapshot.hasData) {
          return const NoteCardWidget();
        }

        return const Text('data');
      },
    );
  }
}

/// Widget
class NoteCardWidget extends StatelessWidget {
  ///
  //final List<NoteModel> _noteList = [];
  ///
  const NoteCardWidget({super.key});

  Future<void> _detailNotePage(BuildContext context) async {
    await Navigator.pushNamed(context, '/home/detail');
  }

  @override
  Widget build(BuildContext context) {
    final List<NoteModel> note =
        Provider.of<NotesProvider>(context).getNotesProvider;

    return MasonryGridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      itemCount: note.length,
      itemBuilder: (context, index) {
        return Card(
          color: colorPallete[note[index].colorNote],
          child: InkWell(
            onTap: () {
              Provider.of<TaskProvider>(context, listen: false)
                  .takeNoteInfo(note[index]);
              _detailNotePage(context);
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        note[index].title,
                        overflow: TextOverflow.clip,
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.access_alarm),
                      ),
                    ],
                  ),
                  const Divider(),
                  Row(
                    children: [
                      Text(
                        note[index].content ?? '',
                        overflow: TextOverflow.fade,
                        maxLines: 5,
                        softWrap: false,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
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
