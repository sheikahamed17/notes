import 'package:flutter/cupertino.dart';
import 'package:notes/data/hive_database.dart';

import 'note.dart';

class NoteData extends ChangeNotifier {
  final db = HiveDatabase();

  List<Note> allNotes = [];

  void initializeNotes() {
    allNotes = db.loadNotes();
  }

  List<Note> getAllNotes() {
    return allNotes;
  }

  void addNewNote(Note note) {
    allNotes.add(note);
    notifyListeners();
  }

  void updateNote(Note note, String text) {
    for (int i = 0; i < allNotes.length; i++) {
      if (allNotes[i].id == note.id) {
        allNotes[i].text = text;
      }
    }
    notifyListeners();
  }

  void deleteNode(Note note) {
    allNotes.remove(note);
    notifyListeners();
  }
}
