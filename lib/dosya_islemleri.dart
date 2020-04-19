import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class DosyaIslemleri extends StatefulWidget {
  @override
  _DosyaIslemleriState createState() => _DosyaIslemleriState();
}

class _DosyaIslemleriState extends State<DosyaIslemleri> {
  var textController = TextEditingController();



  //Oluşturulacak Dosyann Klasör Yolu
  Future<String> get getKlasorYolu async {
    Directory klasor = await getApplicationDocumentsDirectory();
    debugPrint("Klasor path" +klasor.path);
    return klasor.path;
 }

  //Oluşturulacak Dosyann  Yolu
  Future<File> get dosyaOlustur async{
    var olusturulacakDosyaninKlasorununYolu =  await getKlasorYolu;
    return File(olusturulacakDosyaninKlasorununYolu +"/myDosya.txt");

  }
 //dosya Okuma İşlemleri
  Future<String> dosyaOku() async{

    try{

      var myDosya = await dosyaOlustur;
      String dosyaIcerigi = await myDosya.readAsString();
      return dosyaIcerigi;
    }catch(exception){
      return "hata çıktı "+ exception.toString();
    }
  }
  //dosyaya yaz
  Future<File> dosyayaYaz(String yazilacakString) async{
    var myDosya = await dosyaOlustur;
    return myDosya.writeAsString(yazilacakString);
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Dosya İşlemleri"),),
      body: SingleChildScrollView(

        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: textController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: "Buraya yazılacak Değerler Dosyaya kaydedilir...",
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: <Widget>[
              RaisedButton(onPressed: _dosyaOku,color: Colors.green,child: Text("Dosyadan Oku"),),
              RaisedButton(onPressed: _dosyayaYaz,color: Colors.blue,child: Text("Dosyaya Yaz"),)
            ],),
          ],
        )
      ),
    );
  }

  _dosyaOku() async{
    debugPrint(" okunan Değer  "+await dosyaOku());
  }

  _dosyayaYaz() {
    dosyayaYaz(textController.text.toString());
  }
}
