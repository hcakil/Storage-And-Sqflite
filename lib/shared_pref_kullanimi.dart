import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefKullanimi extends StatefulWidget {
  @override
  _SharedPrefKullanimiState createState() => _SharedPrefKullanimiState();
}

class _SharedPrefKullanimiState extends State<SharedPrefKullanimi> {
  String isim;
  int id;
  bool cinsiyet;
  var formKey = GlobalKey<FormState>();
  SharedPreferences mySharedPreferences;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //SharedPreferences.getInstance().then((sf)=>mySharedPreferences=sf);
    SharedPreferences.getInstance().then((sf) {
      mySharedPreferences = sf;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    (mySharedPreferences as State).dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shared Preferences Kullanımı"),
      ),
      body: SingleChildScrollView(
        child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    onSaved: (deger) {
                      isim = deger;
                    },
                    decoration: InputDecoration(
                      labelText: "İsminizi Giriniz",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    onSaved: (deger) {
                      id = int.parse(deger);
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Id Giriniz",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RadioListTile(
                      value: true,
                      groupValue: cinsiyet,
                      onChanged: (secildi) {
                        setState(() {
                          cinsiyet = secildi;
                        });
                      },
                      title: Text("Erkek"),
                    )),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RadioListTile(
                      value: false,
                      groupValue: cinsiyet,
                      onChanged: (secildi) {
                        setState(() {
                          cinsiyet = secildi;
                        });
                      },
                      title: Text("Kadın"),
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    RaisedButton(
                      onPressed: _ekle,
                      child: Text("Kaydet"),
                      color: Colors.green,
                    ),
                    RaisedButton(
                      onPressed: _goster,
                      child: Text("Göster"),
                      color: Colors.blue,
                    ),
                    RaisedButton(
                      onPressed: _sil,
                      child: Text("Sil"),
                      color: Colors.red,
                    ),
                  ],
                )
              ],
            )),
      ),
    );
  }

  void _ekle() async{

    formKey.currentState.save();
   await mySharedPreferences.setString("myName", isim);
   await mySharedPreferences.setInt("myId", id);
   await mySharedPreferences.setBool("mySex", cinsiyet);

  }

  void _goster() {

    debugPrint("Okunan İsim  " +mySharedPreferences.getString("myName")?? "N/A");
    debugPrint("Okunan Id  " +mySharedPreferences.getInt("myId").toString()?? "N/A");
    debugPrint("Okunan Cinsiyet Erkek mi  " +mySharedPreferences.getBool("mySex").toString()?? "N/A");

  }

  void _sil() {

    mySharedPreferences.remove("myName");
    mySharedPreferences.remove("myId");
    mySharedPreferences.remove("mySex");
  }
}
