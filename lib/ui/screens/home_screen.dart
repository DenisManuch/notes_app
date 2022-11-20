import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:notes_app/core/models/note_model.dart';
import 'package:notes_app/core/provider/auth_provider.dart';
import 'package:notes_app/core/provider/notes_provider.dart';
import 'package:notes_app/core/provider/task_provider.dart';
import 'package:notes_app/core/src/constants.dart';
import 'package:notes_app/ui/screens/login_screen.dart';
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
    final bool success = await Provider.of<AuthProvider>(context, listen: false)
        .singOut();
    if (success) {
      if (mounted) {
        return Navigator.pushAndRemoveUntil<void>(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => const LoginScreen(),
          ),
          ModalRoute.withName('/login'),
        );
      }
    }
  }

  ///
  Future<void> _detailNotePage(int listIndex) async {
    final NoteModel noteInfo =
        Provider.of<NotesProvider>(context, listen: false)
            .getNotesProvider[listIndex];
    await Provider.of<TaskProvider>(context, listen: false)
        .loadListOfTasks(noteInfo, listIndex);
    if (mounted) await Navigator.pushNamed(context, '/home/detail');
  }

  // Future<void> _updateNote(NoteModel note) async {
  //   Provider.of<TaskProvider>(context, listen: false).takeNoteInfo(note);
  // }

  @override
  void initState() {
    Provider.of<NotesProvider>(context, listen: false)
        .getAllNotesFromSupabase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _loading = Provider.of<NotesProvider>(context).loading;

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      drawer: const DrawerWidget(),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).secondaryHeaderColor),
        backgroundColor: Theme.of(context).primaryColor,
        title: _loading
            ? AutoSizeText(
                'Loading...',
                style: TextStyle(color: Theme.of(context).secondaryHeaderColor),
              )
            : AutoSizeText(
                'Note App',
                style: TextStyle(color: Theme.of(context).secondaryHeaderColor),
              ),
        actions: [
          IconButton(
            //color: Theme.of(context).secondaryHeaderColor,
            onPressed: () => Provider.of<NotesProvider>(context, listen: false)
                .getAllNotesFromSupabase(),
            icon: const Icon(Icons.refresh),
          ),
          IconButton(
            //color: Theme.of(context).secondaryHeaderColor,
            onPressed: () => _signOut(),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: MasonryGridView.count(
        crossAxisCount: axisCountK,
        mainAxisSpacing: axisSpacingK,
        crossAxisSpacing: axisSpacingK,
        itemCount: Provider.of<NotesProvider>(context).getNotesProvider.length,
        itemBuilder: (context, index) {
          final List<NoteModel> note =
              Provider.of<NotesProvider>(context).getNotesProvider;

          return GestureDetector(
            onTap: () => _detailNotePage(index),
            onLongPress: () {
              Provider.of<NotesProvider>(context, listen: false)
                  .deleteNote(index);
            },
            child: Card(
              color: colorPallete[note[index].colorNote],
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeText(
                      note[index].title,
                      style: Theme.of(context).textTheme.headline1,
                      maxLines: maxLinesK,
                      //minFontSize: 20,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    AutoSizeText(
                      note[index].content,
                      //style: Theme.of(context).textTheme.headline1,
                      //maxLines: 10,
                      //minFontSize: 20,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(
            context,
            '/home/addnote',
          );
        },
        child: const Icon(Icons.abc),
      ),
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
