import 'dart:async';
import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';
import 'login.dart';
import 'HomePage.dart';

void main() {
  runApp(MyApp());
}

var connection = PostgreSQLConnection(
  "10.0.2.2",
  5432,
  "clubdb",
  username: "postgres",
  password: "1Mero3Postgres7",
);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future<void> initDb() async {
      try {
        debugPrint('Connecting...');
        await connection.open();
        debugPrint("Database Connected!");
      } catch (e) {
        debugPrint("Error: $e");
      }
    }

    imageCache.clear();
    initDb();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: login(),
    );
  }
}
