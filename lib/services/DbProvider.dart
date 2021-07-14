import 'dart:io';

import 'package:directwp/models/Contact.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DbProvider {
  Database db;

  // Create a new database
  Future init() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentDirectory.path, 'db.sqlite');
    this.db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database newDb, int version) {
        // Run some SQL
        newDb.execute("""
        CREATE TABLE contacts (
          id INTEGER PRIMARY KEY,
          number TEXT,
          message LONGTEXT
        )
      """);
      },
    );
  }

  // Fetch Items
  Future<List> fetchItems() async {
    final results = await this.db.query('contacts', groupBy: "number");

    if (results.length <= 0) {
      return null;
    }
    return results;
  }

  // Insert Item
  Future<int> insertItem(Contact contact) {
    return this.db.insert('contacts', contact.toMap());
  }

  // Delete item
  Future<int> deleteItem(int id) {
    return this.db.delete("contacts", where: "id = ?", whereArgs: [id]);
  }
}
