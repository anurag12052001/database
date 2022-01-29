import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  void initState() {
    super.initState();
    setupDB();
  }

  setupDB() async {
    var dbPath =
        await getExternalStorageDirectory(); //getDatabasesPath(); // it will help to get database path
    print("DB path $dbPath");
    var db = await openDatabase(
      // it will open database/ it will also create new database
      join(dbPath!.path, "school.db"),
      version: 1,
      onConfigure: (db) {
        print("Configure DB");
      },
      onCreate: (db, version) {
        // yaha pta chalega ki database create ho gya / we will get the call back in it
        print("create DB");
      },
      onOpen: (db) async {
        print("Open DB");
        db.execute(
            'CREATE TABLE IF NOT EXISTS student (id INTEGER PRIMARY KEY, name TEXT, age INTEGER)');

        int insertedID = await db.insert("student", {
          // to insert data
          "name": "Anurag",
          "age": 20
        }); // name and age is map, student is database name
        print("inserted ID $insertedID");

        int updatedId =
            await db.update("student", {"age": 70}, // to update data
                where: "name = ?",
                whereArgs: ["Anurag"]);
        print("updatedId Id $updatedId");

        // int deleteId =
        //     await db.delete("student", where: "name=?", whereArgs: ["Anurag"]);
        //     print("deleteId Id $deleteId");

        List<Map<String, dynamic>> result = await db.query("student");
        print("Result is ${result}");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
