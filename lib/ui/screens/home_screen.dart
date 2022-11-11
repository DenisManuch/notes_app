import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/core/models/note_model.dart';
import 'package:notes_app/core/provider/auth_provider.dart';
import 'package:notes_app/core/provider/notes_provider.dart';
import 'package:notes_app/core/provider/task_provider.dart';
import 'package:notes_app/core/src/constants.dart';
import 'package:notes_app/ui/screens/add_note_screen.dart';
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

  ///
  Future<void> _detailNotePage(NoteModel note) async {
    Provider.of<TaskProvider>(context, listen: false).takeNoteInfo(note);
    await Navigator.pushNamed(context, '/home/detail');
  }

  Future<void> _updateNote(NoteModel note) async {
    Provider.of<TaskProvider>(context, listen: false).takeNoteInfo(note);
  }

  @override
  void initState() {
    Provider.of<NotesProvider>(context, listen: false).getAllNotes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      drawer: const DrawerWidget(),
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text("data"),
        actions: [
          IconButton(
            onPressed: () => null,
            icon: const Icon(Icons.abc),
          ),
          IconButton(
            onPressed: () => _signOut(),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: Provider.of<NotesProvider>(context).getNotesProvider.length,
        itemBuilder: (context, index) {
          final List<NoteModel> note =
              Provider.of<NotesProvider>(context).getNotesProvider;

          return Column(children: note.map(_toNoteWidget).toList());
        },
      ),
      // body: StreamBuilder<dynamic>(
      //   stream: Provider.of<NotesProvider>(context).test(),
      //   builder: (BuildContext context, AsyncSnapshot snapshot) {
      //     return Container(
      //       child: Text('${snapshot.data}'),
      //     );
      //   },
      // ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(
              context,
              '/home/addnote',
            );
          },
          child: const Icon(Icons.abc),),
    );
  }

  Widget _toNoteWidget(NoteModel note) {
    return Dismissible(
      key: ValueKey(note.id),
      direction: DismissDirection.endToStart,
      //confirmDismiss: (_) {},
      //Services.of(context).notesService.deleteNote(note.id),
      //onDismissed: (_) => setState(() {
      //  debugPrint(''); // crutch
      //}),
      background: Container(
        padding: const EdgeInsets.all(16.0),
        //color: Theme.of(context).errorColor,
        alignment: Alignment.centerRight,
        child: const Icon(Icons.delete),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          color: colorPallete[note.colorNote],
          child: ListTile(
            leading: const Icon(Icons.paste),
            trailing: const Icon(Icons.arrow_forward_ios),
            title: AutoSizeText(
              note.title,
              style: Theme.of(context).textTheme.headline1,
              maxLines: 3,
            ),
            // Text(
            //   note.title,
            //   style: const TextStyle(fontSize: 25),
            // ),
            subtitle: AutoSizeText(
              note.content ?? 'description',
              maxLines: 5,
            ),
            onLongPress: () => _updateNote(note),
            onTap: () => _detailNotePage(note),
          ),
        ),
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