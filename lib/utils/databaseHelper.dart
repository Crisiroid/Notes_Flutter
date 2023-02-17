// ignore_for_file: non_constant_identifier_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_interpolation_to_compose_strings, unnecessary_new, camel_case_types

import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class noteC {
  final int? id;
  final String title;
  final String note;
  noteC({this.id, required this.title, required this.note});

  factory noteC.fromMap(Map<String, dynamic> json) => new noteC(
        id: json['id'],
        title: json['title'],
        note: json['note'],
      );

  Map<String, dynamic> toMap() {
    return {'id': id, 'title': title, 'note': note};
  }
}

class databaseHelper {
  //creating database helper class
  databaseHelper._privateConstructor();
  static final databaseHelper instance = databaseHelper._privateConstructor();
  //searching for database
  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();
  //initializing database
  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'databasee.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  //creating database if it was not available
  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE noteList(
        id INTEGER PRIMARY KEY, 
        title TEXT,
        note TEXT
      )
''');
  }

  //get notes from database for showing
  Future<List<noteC>> getNoteList() async {
    Database db = await instance.database;
    var noteCs = await db.query('noteList', orderBy: 'title');

    List<noteC> notelist =
        noteCs.isNotEmpty ? noteCs.map((e) => noteC.fromMap(e)).toList() : [];
    return notelist;
  }

  //adding new notes to database using sqflite
  Future<int> add(noteC noteCsd) async {
    Database db = await instance.database;
    return await db.insert('noteList', noteCsd.toMap());
  }

  //removing notes
  Future<int> remove(dynamic id) async {
    Database db = await instance.database;
    return await db.delete('noteList', where: 'id = ?', whereArgs: [id]);
  }

  //editing notes
  Future<int> update(noteC noteCsd) async {
    Database db = await instance.database;
    return await db.update('noteList', noteCsd.toMap(),
        where: 'id = ?', whereArgs: [noteCsd.id]);
  }
}
