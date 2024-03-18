import 'package:flutter/material.dart';
import 'package:group_project_1/dropdown.dart';
// import 'package:group_project_1/home.dart';
import 'package:group_project_1/loginscreen.dart';
// import 'package:group_project_1/search.dart';
// import 'package:group_project_1/loginscreen.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

dynamic database;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  database = await openDatabase(
    join(await getDatabasesPath(), 'FarmerDB.db'),
    version: 1,
    onCreate: (db, version) async {
      await db.execute(
          "CREATE TABLE FARMERS(id INTEGER PRIMARY KEY,fname TEXT,number INTEGER,city TEXT,accNumber INTEGER)");
      await db.execute(
          "CREATE TABLE MILKENTRY(entryId INTEGER PRIMARY KEY,id INTEGER,animal TEXT,fat REAL,quantity REAL,date TEXT,total REAL,FOREIGN KEY(id) REFERENCES FARMERS(id))");
    },
  );
  runApp(const MainApp());
  // await dropDatabase();
}

dropDatabase() async {
  String path = join(await getDatabasesPath(), 'FarmerDB.db');
  bool exist = await databaseExists(path);

  if (exist) {
    await deleteDatabase(path);
    print("database dropped successfully");
  } else {
    print("Database not exist");
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const LoginPage(),
      // home: const SearchScreen(),
      routes: {
        '/dropdown': (context) => const DropDown(),
      },
    );
  }
}
