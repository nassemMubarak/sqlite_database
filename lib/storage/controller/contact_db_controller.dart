import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqlite_database/change_notifiers/contact_change_notifier.dart';
import 'package:sqlite_database/storage/db_provider.dart';

import '../../models/contact.dart';
import '../db_operations.dart';

class ContactDbController extends DbOperations<Contact> {
  Database _database;

  ContactDbController() : _database = DBProvider().database;

  @override
  Future<int> create(Contact data) async {
    return await _database.insert(Contact.tableName, data.toMap());

  }
  @override
  Future<bool> delete(int id) async {
    int countDeleted = await _database
        .delete(Contact.tableName, where: 'id = ?', whereArgs: [id]);
    return countDeleted != 0;
  }
  @override
  Future<List<Contact>> read() async {
    var rowsMap = await _database.query(Contact.tableName);
    return rowsMap.map((rowMap) => Contact.fromMap(rowMap)).toList();
  }
  @override
  Future<Contact?> show(int id) async {
    var data = await _database
        .query(Contact.tableName, where: 'id = ?', whereArgs: [id]);
    List contact = data.map((row) => Contact.fromMap(row)).toList();
    return contact.length > 0 ? contact.first : null;
  }
  @override
  Future<bool> update(Contact data) async {
    int countOfUpdatedRow = await _database.update(
        Contact.tableName, data.toMap(),
        where: 'id = ?', whereArgs: [data.id]);
    return countOfUpdatedRow != 0;
  }
}
