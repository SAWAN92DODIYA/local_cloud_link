import 'package:hive_flutter/adapters.dart';

import '../models/notes_model.dart';

class Boxes{
  static Box<NoteModel> getData() => Hive.box<NoteModel>('notes') ;


}