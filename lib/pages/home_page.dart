import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes/models/note_data.dart';
import 'package:provider/provider.dart';

import '../models/note.dart';
import 'editing_note_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Provider.of<NoteData>(context, listen: false).initializeNotes();
  }

  void createNewNode() {
    int id = Provider.of<NoteData>(context, listen: false).getAllNotes().length;
    Note newNote = Note(id: id, text: '');

    goToNotePage(newNote, true);
  }

  void goToNotePage(Note note, bool isNewNote) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EditingNotePage(
            note: note,
            isNewNote: isNewNote,
          ),
        ));
  }

  void deleteNote(Note note) {
    Provider.of<NoteData>(context, listen: false).deleteNode(note);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NoteData>(
        builder: (context, value, child) => Scaffold(
              backgroundColor: CupertinoColors.secondarySystemBackground,
              floatingActionButton: FloatingActionButton(
                onPressed: createNewNode,
                backgroundColor: Colors.grey[300],
                elevation: 0,
                child: const Icon(Icons.add, color: Colors.white),
              ),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 25, top: 75),
                    child: Text(
                      "Note",
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                  ),
                  value.getAllNotes().length == 0
                      ? Padding(
                          padding: const EdgeInsets.only(top: 50),
                          child: Center(
                            child: Text(
                              'Nothing here..',
                              style: TextStyle(color: Colors.grey[400]),
                            ),
                          ),
                        )
                      : CupertinoListSection.insetGrouped(
                          children: List.generate(
                              value.getAllNotes().length,
                              (index) => CupertinoListTile(
                                    title:
                                        Text(value.getAllNotes()[index].text),
                                    onTap: () => goToNotePage(
                                        value.getAllNotes()[index], false),
                                    trailing: IconButton(
                                      icon: Icon(Icons.delete),
                                      onPressed: () => deleteNote(
                                          value.getAllNotes()[index]),
                                    ),
                                  )),
                        )
                ],
              ),
            ));
  }
}
