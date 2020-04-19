/*import 'dart:async';
import 'dart:io';
import 'package:flutter_storage_dersleri/models/ogrenci.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class DatabaseHelper0 {

  static DatabaseHelper _databaseHelper;
  static Database _database;
  //SUTUN ADLARI STRING OLARAK TANIMLANIR
  String _ogrenciTablo = "ogrenci";
  String _columnId = "id";
  String _columnIsim = "ad_soyad";
  String _columnAktif = "aktif";
  

  //İsinmlendirilmiş constructor Bu ne zaman çalıştırılırsa datbase helperdan bir nesne üretiliyor
  DatabaseHelper._internal();

  factory DatabaseHelper(){
    if(_databaseHelper == null){
      print("DATABASE HELPER NULL, OLUSTURULACAK");
      _databaseHelper = DatabaseHelper._internal();
      return _databaseHelper;
    }
    return _databaseHelper;
  }


  //Database._internal();
  Future<Database> _getDatabase() async{
    if(_database == null)
      {
        print("DATABASE NESNESİ NULL, OLUSTURULACAK");
        _database = await _initializeDatabase();
        return _database;
      }
    else{
      print("DATABASE NESNESİ NULL DEĞİL");
    return _database;}
  }

  Future<Database> _initializeDatabase() async{
    //Şu an sadece yol olusturuldu Dosya OluşturulMAdı.
    Directory klasor = await getApplicationDocumentsDirectory();
    String path = join(klasor.path,"ogrenci.db");
    print("olusan path  $path");
    
    var ogrenciDb = await openDatabase(path,version: 1,onCreate: _createDb);
    return ogrenciDb;
    //CRUD ISLEMLER
  }

  Future _createDb(Database db, int version) async {
    print("CREATE DB METODU ÇALIŞTI TABLO OLUŞTURULACAK");
    await db.execute("CREATE TABLE $_ogrenciTablo ($_columnId INTEGER PRIMARY KEY AUTOINCREMENT, $_columnIsim TEXT, $_columnAktif TEXT )"); 
    }
    
    Future<int> ogrenciEkle (Ogrenci ogrenci) async {
    //_database.insert(table, values) 
    //Raw query tipi Direk olarak Sql sorgunuzu yazabileceğiniz bir alan
      //_database.rawQuery(sql);
   var db = await _getDatabase();
   var sonuc = db.insert(_ogrenciTablo,ogrenci.toMap());
   return sonuc;
    }
    
    
}*/