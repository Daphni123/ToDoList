
import 'package:sqflite/sqflite.dart';
import 'package:todolist/core/modul/module.dart';

class DBHelper {
static Database _db;
static final int _version = 1;
static final String _tablename = 'tasks';


static Future<void> initDb() async {
if (_db != null) {
return;
}
try {
String _path = await getDatabasesPath() + 'task.db';
_db =
await openDatabase(_path, version: _version, onCreate: (db, version) {
return db.execute(
"CREATE TABLE $_tablename(id INTEGER PRIMARY KEY AUTOINCREMENT, title STRING, note TEXT, date STRING)",
);
});
} catch (e) {
print(e);
}
}

static Future<int> insert(Task note) async {
return await _db.insert(_tablename, note.toJson());
}

static Future<int> delete(Task note) async {
return await _db.delete(_tablename, where: 'id = ?', whereArgs: [note.id]);
}

static Future<List<Map<String, dynamic>>> query() async {
print("query function called");
return _db.query(_tablename);
}

static Future<int> update(Task note) async {
print("update function called");
return await _db.rawUpdate(
"UPDATE tasks SET title = ?, note = ? WHERE id = ? ",
[note.title, note.task, note.id],
);
}
}
