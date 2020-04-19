import 'package:flutter/material.dart';
import 'package:flutter_storage_dersleri/models/ogrenci.dart';
import 'package:flutter_storage_dersleri/utils/database_helper1.dart';
import 'package:sqflite/sqflite.dart';

class SqfliteIslemleri extends StatefulWidget {
  @override
  _SqfliteIslemleriState createState() => _SqfliteIslemleriState();
}

class _SqfliteIslemleriState extends State<SqfliteIslemleri> {
  DatabaseHelper databaseHelper;
  //Formun dinamik olabilmesi için
  var formKey = GlobalKey<FormState>();
  var scaffoldKey = GlobalKey<ScaffoldState>();
  String isim = "";
  bool aktiflik = false;
  //tıklanılan öğenin id sini alacapız ki güncellemede bu elemanın üzerinde işlem yapabilelim
  int id = 0;
  //Bu güncellemede kullanılıyor
  int tiklanilanListeID =0;
  List<Ogrenci> tumOgrenciListesi;
  //alttan herhangi bir karta basılınca text forma adını yazdırmak için
  var _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    tumOgrenciListesi = List<Ogrenci>();
    databaseHelper = DatabaseHelper();
    databaseHelper.tumOgrenciler().then((mapListesi) {
      for (Map okunanMap in mapListesi) {
        tumOgrenciListesi.add(Ogrenci.fromMap(okunanMap));
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //snackbarın nerede çıkağının belirlenmesi için oluşturuldu ve koyuldu
      key: scaffoldKey,
      appBar: AppBar(
        title: Text("SqfLite Kullanimi"),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: TextFormField(
                      controller: _controller,
                      autofocus: false,
                      decoration: InputDecoration(
                        labelText: "Öğrenci ismini giriniz",
                        border: OutlineInputBorder(),
                      ),
                      validator: (girilenDeger) {
                        if (girilenDeger.length < 3) {
                          return "En az 3 karakter giriniz";
                        }
                      },
                      onSaved: (girilenIsim) {
                        isim = girilenIsim;
                      },
                    ),
                  ),
                  SwitchListTile(
                    title: Text(
                      "Aktif",
                    ),
                    value: aktiflik,
                    onChanged: (aktifMi) {
                      setState(() {
                        aktiflik = aktifMi;
                      });
                    },
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
                  child: Text("Kaydet"),
                  color: Colors.green,
                  onPressed: () {
                    if (formKey.currentState.validate()) {
                      formKey.currentState.save();
                      _ogrenciEkle(Ogrenci(isim, aktiflik));
                    }
                  },
                ),
                RaisedButton(
                  child: Text("Güncelle"),
                  color: Colors.yellow.shade200,
                  onPressed: () {
                    //yani yukarıda tanımlanan 3 karakter kuralı geçilmiş ve
                    //text form field validate olmuşsa tap
                    if (formKey.currentState.validate()) {
                      formKey.currentState.save();
                      _ogrenciGuncelle(Ogrenci.withID(id, isim, aktiflik), tiklanilanListeID);
                    }
                  },
                ),

                RaisedButton(
                  onPressed: () {
                    _tumOgrenciKayitlariniSil(context);
                  },
                  color: Colors.red,
                  child: Text("Tüm Tabloyu Sil"),
                )
              ],
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: tumOgrenciListesi.length,
                  itemBuilder: (context, index) {
                    return Card(
                      color: tumOgrenciListesi[index].aktif == true
                          ? Colors.green.shade200
                          : Colors.red.shade200,
                      child: ListTile(
                        onTap: () {
                          setState(() {
                            isim = tumOgrenciListesi[index].isim;
                            aktiflik = tumOgrenciListesi[index].aktif;
                            id = tumOgrenciListesi[index].id;
                            //orda görünen listede hangi indexteyse o tutuluyor.
                            //Böylelikle veritabanındaki değişiklik interfacede de yapılmış oluyor
                            //o index ui daki index number
                            tiklanilanListeID = index;
                            _controller.text = isim;
                            debugPrint("isim $isim aktiflik $aktiflik");
                          });
                        },
                        title: Text(tumOgrenciListesi[index].isim),
                        subtitle: Text(tumOgrenciListesi[index].id.toString()),
                        //Sondaki silme ikonunun Tap özelliğiiçin GestureDetector içine alındı
                        trailing: GestureDetector(
                          onTap: () {
                            databaseHelper.ogrenciSil(
                                tumOgrenciListesi[index].id).then((silinenId) {
                              setState(() {
                                tumOgrenciListesi.removeAt(index);
                              });
                            });
                          },
                          child: Icon(Icons.delete),
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }

  _ogrenciEkle(Ogrenci ogrenci) async {
    await databaseHelper.ogrenciEkle(ogrenci).then((eklenenInt) {
      setState(() {
        ogrenci.id = eklenenInt;
        //son eklenen öğrencinin 0'ıncı indexe eklenmesi amacıyla ypılmıştır.
        tumOgrenciListesi.insert(0, ogrenci);
      });
    });
  }

  void _tumOgrenciKayitlariniSil(BuildContext context) async {
    await databaseHelper.tumOgrenciTablosunuSil().then((silinenElemanSayisi) {
      //Alttan çıkan uyarı barı
      scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text(silinenElemanSayisi.toString() + " kayıt silindi"),
          duration: Duration(seconds: 2),
        ),
      );

      setState(() {
        tumOgrenciListesi.clear();
      });
    });
  }

  _ogrenciGuncelle(Ogrenci ogrenci, int tiklanilanListeID) async{
    await databaseHelper.ogrenciGuncelle(ogrenci).then((guncellenenInt) {
      setState(() {
        tumOgrenciListesi[tiklanilanListeID] = ogrenci;
      });
    });
  }
}