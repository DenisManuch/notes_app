import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:help_ukraine_widget/help_ukraine_widget.dart';
import 'package:notes_app/core/models/note_model.dart';
import 'package:notes_app/core/provider/auth_provider.dart';
import 'package:notes_app/core/provider/notes_provider.dart';
import 'package:notes_app/core/provider/task_provider.dart';
import 'package:notes_app/core/src/constants.dart';
import 'package:notes_app/core/src/main_navigation.dart';
import 'package:notes_app/ui/screens/login_screen.dart';
import 'package:notes_app/ui/widgets/drawer_list_widget.dart';
import 'package:provider/provider.dart';

///
class HomeScreen extends StatefulWidget {
  ///
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Future<void> _checkAuth() async {
  //   final bool _checkVar =
  //       await Provider.of<AuthProvider>(context, listen: false).checkAuth();
  //   if (_checkVar) {
  //     if (mounted) {
  //       return Navigator.pushAndRemoveUntil<void>(
  //         context,
  //         MaterialPageRoute<void>(
  //           builder: (BuildContext context) => const LoginScreen(),
  //         ),
  //         ModalRoute.withName('/login'),
  //       );
  //     }
  //   }
  // }

  Future<void> _signOut() async {
    //await Provider.of<NotesProvider>(context, listen: false).getAllNotes();
    final bool success =
        await Provider.of<AuthProvider>(context, listen: false).singOut();
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
    Provider.of<NotesProvider>(context, listen: false).noteIndexInList =
        listIndex;
    final NoteModel noteInfo =
        Provider.of<NotesProvider>(context, listen: false)
            .getNotesProvider[listIndex];
    await Provider.of<TaskProvider>(context, listen: false)
        .loadListOfTasks(noteInfo, listIndex);
    if (mounted) {
      await Navigator.of(context).pushNamed(
        MainNavigationRoutesNames.detailRoute,
      );
    }
  }

  @override
  void initState() {
    //_checkAuth();
    Provider.of<NotesProvider>(context, listen: false)
        .getAllNotesFromSupabase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      drawer: const DrawerWidget(),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).secondaryHeaderColor),
        backgroundColor: Theme.of(context).primaryColor,
        title:
            Provider.of<TaskProvider>(context).loadingIndicatorState(context),
        actions: [
          IconButton(
            //color: Theme.of(context).secondaryHeaderColor,
            onPressed: () {
              Provider.of<NotesProvider>(context, listen: false)
                  .getAllNotesFromSupabase();
            },
            icon: const Icon(Icons.refresh),
          ),
          IconButton(
            //color: Theme.of(context).secondaryHeaderColor,
            onPressed: () => _signOut(),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: OverlayWidget(
        alignment: Alignment.bottomLeft,
        overlayWidget: HorizontalHelpWidget(),
        child: MasonryGridView.count(
          crossAxisCount: axisCountK,
          mainAxisSpacing: axisSpacingK,
          crossAxisSpacing: axisSpacingK,
          itemCount:
              Provider.of<NotesProvider>(context).getNotesProvider.length,
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
                        style: Theme.of(context).textTheme.displayLarge,
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
      child: DrawerListWidget(),
    );
  }
}
