import 'package:hive_flutter/hive_flutter.dart';

import '../models/note.dart';

class HiveDatabase {
  final _myBox = Hive.box('note_database');

  List<Note> loadNotes() {
    List<Note> savedNotesFormatted = [];

    if (_myBox.get("ALL_NOTES") != null) {
      List<dynamic> savedNotes = _myBox.get("ALL_NOTES");

      for (int i = 0; i < savedNotes.length; i++) {
        Note individualNote =
            Note(id: savedNotes[i][0], text: savedNotes[i][1]);
        savedNotesFormatted.add(individualNote);
      }
    } else {
      savedNotesFormatted.add(Note(id: 0, text: 'First Note'));
    }

    return savedNotesFormatted;
  }

  void savedNotes(List<Note> allNotes) {
    List<List<dynamic>> allNotesFormatted = [];
    for (var note in allNotes) {
      int id = note.id;
      String text = note.text;
      allNotesFormatted.add([id, text]);
    }
    _myBox.put("ALL_NOTES", allNotesFormatted);
  }
}
