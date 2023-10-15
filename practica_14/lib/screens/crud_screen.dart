import 'package:flutter/material.dart';
import 'package:practica_14/config.dart';
import 'package:sqflite/sqflite.dart';

class CrudScreen extends StatefulWidget {
  const CrudScreen({super.key});

  @override
  State<CrudScreen> createState() => _CrudScreenState();
}

class _CrudScreenState extends State<CrudScreen> {
  late String path;
  late Database database;

  @override
  void initState() {
    createDB();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConfig.colorFondo,
      appBar: AppBar(
        title: const Text('Practica 14 - SQLite'),
        centerTitle: true,
        backgroundColor: AppConfig.colorPrincipal,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'CRUD TEST',
              style: TextStyle(
                fontSize: AppConfig.sizeTitulo,
                color: AppConfig.colorDescripcion
              ),
              ),
              SizedBox(height: AppConfig.gap,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 300.0,
                  child: ElevatedButton(
                    onPressed: () {
                      insertDB();
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppConfig.colorPrincipal,
                        foregroundColor: AppConfig.colorFondo),
                    child: const Text('INSERT'),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 300.0,
                  child: ElevatedButton(
                    onPressed: () {
                      removeDB();
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppConfig.colorPrincipal,
                        foregroundColor: AppConfig.colorFondo),
                    child: const Text('REMOVE'),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 300.0,
                  child: ElevatedButton(
                    onPressed: () {
                      updateDB();
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppConfig.colorPrincipal,
                        foregroundColor: AppConfig.colorFondo),
                    child: const Text('UPDATE'),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                    width: 300.0,
                    child: ElevatedButton(
                      onPressed: () {
                        showDB();
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppConfig.colorPrincipal,
                          foregroundColor: AppConfig.colorFondo),
                      child: const Text('SHOW'),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void createDB() async {
    var dbpath = await getDatabasesPath();
    path = '{$dbpath}my_db.db';
    database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE Test (id INTEGER PRIMARY KEY,name TEXT,nickname TEXT)');
    });
  }

  void insertDB() async {
    await database.transaction((txn) async {
      int reg1 = await txn.rawInsert(
          'INSERT INTO Test (name,nickname) VALUES (?,?)', ['JUAN', 'LOAL']);

      print('Insert:$reg1');

      int reg2 = await txn.rawInsert(
          'INSERT INTO Test (name,nickname) VALUES ("Adrian","LOAL")');

      print('Insert:$reg2');
    });
  }

  void removeDB() async {
    int rem =
        await database.rawDelete('DELETE FROM Test WHERE name = ?', ['Adrian']);
    print('Remove:$rem');
  }

  void updateDB() async {
    int upt = await database.rawUpdate(
        'UPDATE Test SET nickname =? WHERE name = ?', ['loal9', "Adrian"]);

    print('Update:$upt');
  }

  void showDB() async {
    List<Map> show = await database.rawQuery('SELECT * FROM Test ');

    print(show);
  }
}
