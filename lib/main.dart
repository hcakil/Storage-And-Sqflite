import 'package:flutter/material.dart';
import 'package:flutter_storage_dersleri/dosya_islemleri.dart';
import 'package:flutter_storage_dersleri/shared_pref_kullanimi.dart';
import 'package:flutter_storage_dersleri/sqflite_islemleri1.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: SqfliteIslemleri(),
    );
  }
}


