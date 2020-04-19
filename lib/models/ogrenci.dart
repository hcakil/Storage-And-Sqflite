class Ogrenci{

  int _id;
  String _isim;
  bool _aktif;

  int get id => _id;

  set id(int value) {
    _id = value;
  }

  String get isim => _isim;

  bool get aktif => _aktif;

  set aktif(bool value) {
    _aktif = value;
  }

  set isim(String value) {
    _isim = value;
  }

  Ogrenci(this._isim, this._aktif);


  Ogrenci.withID(this._id, this._isim, this._aktif);

  //Sqflte dan veri getirilirken kullanılacak
  Ogrenci.fromMap(Map<String,dynamic> map){
    this._isim = map["ad_soyad"];
    this._id = map["id"];
    this._aktif = map["aktif"] == "1" ? true:false;
  }

   //Sqflite map yapısında çalışıyor nu yüzden veritabanına giderken Map yapısına dönüştürmeliyiz
  Map<String,dynamic> toMap (){
    var map = Map<String,dynamic>();
    map["id"]=_id;
    map["ad_soyad"]=_isim;
    map["aktif"]=_aktif;
    return map;
  }

  @override
  String toString() {
    return 'Ogrenci{_id: $_id, _isim: $_isim, _aktif: $_aktif}';
  }


}