import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String dersAdi;
  int dersKredi = 1;
  static int sayac = 0;
  double dersDegeri = 4, ortalama = 0;
  List<Dersler> tumDersler;

  var formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tumDersler = [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Gano Hesaplama"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (formKey.currentState.validate()) {
            formKey.currentState.save();
          }
        },
        child: Icon(Icons.add),
      ),
      body: OrientationBuilder(builder: (context, orientation) {
        if (orientation == Orientation.portrait) {
          return uygulamaGovdesi();
        } else {
          return uygulamaGovdesiLandscape();
        }
      }),
    );
  }

  Widget uygulamaGovdesi() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.all(10),
            // color: Colors.deepPurple.shade200,
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Ders Adı",
                      hintText: "Ders Adını Giriniz",
                      border: OutlineInputBorder(),
                    ),
                    validator: (deger) {
                      if (deger.length > 0)
                        return null;
                      else
                        return "Ders Adı bos olamaz";
                    },
                    onSaved: (deger) {
                      dersAdi = deger;
                      setState(() {
                        tumDersler.add(Dersler(dersAdi, dersDegeri, dersKredi,
                            rastGeleRenkOlustur()));
                        ortalama = 0;
                        ortalamaHesapla();
                      });
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.orangeAccent, width: 2),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<int>(
                            items: dersKredileriItems(),
                            value: dersKredi,
                            onChanged: (secilenDeger) {
                              setState(() {
                                dersKredi = secilenDeger;
                              });
                            },
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.orangeAccent, width: 2),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<double>(
                            items: dersHarfDegerleriItems(),
                            value: dersDegeri,
                            onChanged: (secilendeger) {
                              setState(() {
                                dersDegeri = secilendeger;
                              });
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            height: 70,
            //  color: Colors.blue.shade200,
            child: Center(
                child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(children: [
                TextSpan(
                    text: tumDersler.length == 0
                        ? " Lütfen ders ekleyin"
                        : "Ortalama : ",
                    style: TextStyle(color: Colors.black, fontSize: 23)),
                TextSpan(
                    text: tumDersler.length == 0
                        ? ""
                        : "${ortalama.toStringAsFixed(2)}",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.bold)),
              ]),
            )),
          ),
          Expanded(
            child: Container(
              // color: Colors.blue.shade200,
              child: ListView.builder(
                itemBuilder: _listeElemanlariniOlustur,
                itemCount: tumDersler.length,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget uygulamaGovdesiLandscape() {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  // color: Colors.deepPurple.shade200,
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: "Ders Adı",
                            hintText: "Ders Adını Giriniz",
                            border: OutlineInputBorder(),
                          ),
                          validator: (deger) {
                            if (deger.length > 0)
                              return null;
                            else
                              return "Ders Adı bos olamaz";
                          },
                          onSaved: (deger) {
                            dersAdi = deger;
                            setState(() {
                              tumDersler.add(Dersler(dersAdi, dersDegeri,
                                  dersKredi, rastGeleRenkOlustur()));
                              ortalama = 0;
                              ortalamaHesapla();
                            });
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 10),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.orangeAccent, width: 2),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<int>(
                                  items: dersKredileriItems(),
                                  value: dersKredi,
                                  onChanged: (secilenDeger) {
                                    setState(() {
                                      dersKredi = secilenDeger;
                                    });
                                  },
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 10),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.orangeAccent, width: 2),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<double>(
                                  items: dersHarfDegerleriItems(),
                                  value: dersDegeri,
                                  onChanged: (secilendeger) {
                                    setState(() {
                                      dersDegeri = secilendeger;
                                    });
                                  },
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.all(10),
                    //  color: Colors.blue.shade200,
                    child: Center(
                        child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(children: [
                        TextSpan(
                            text: tumDersler.length == 0
                                ? " Lütfen ders ekleyin"
                                : "Ortalama : ",
                            style:
                                TextStyle(color: Colors.black, fontSize: 23)),
                        TextSpan(
                            text: tumDersler.length == 0
                                ? ""
                                : "${ortalama.toStringAsFixed(2)}",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 22,
                                fontWeight: FontWeight.bold)),
                      ]),
                    )),
                  ),
                ),
              ],
            ),
            flex: 2,
          ),
          Expanded(
            child: Container(
              // color: Colors.blue.shade200,
              child: ListView.builder(
                itemBuilder: _listeElemanlariniOlustur,
                itemCount: tumDersler.length,
              ),
            ),
            flex: 3,
          )
        ],
      ),
    );
  }

  List<DropdownMenuItem<int>> dersKredileriItems() {
    List<DropdownMenuItem<int>> krediler = [];
    for (int i = 1; i <= 10; i++) {
      krediler.add(DropdownMenuItem(
        value: i,
        child: Text(
          "$i kredi",
          style: TextStyle(fontSize: 20),
        ),
      ));
    }
    return krediler;
  }

  List<DropdownMenuItem<double>> dersHarfDegerleriItems() {
    List<DropdownMenuItem<double>> harfler = [];
    harfler.add(DropdownMenuItem(
      child: Text(" AA ",
          style: TextStyle(
            fontSize: 20,
          )),
      value: 4,
    ));
    harfler.add(DropdownMenuItem(
      child: Text(" BA ",
          style: TextStyle(
            fontSize: 20,
          )),
      value: 3.5,
    ));
    harfler.add(DropdownMenuItem(
      child: Text(" BB ",
          style: TextStyle(
            fontSize: 20,
          )),
      value: 3,
    ));
    harfler.add(DropdownMenuItem(
      child: Text(" CB ",
          style: TextStyle(
            fontSize: 20,
          )),
      value: 2.5,
    ));
    harfler.add(DropdownMenuItem(
      child: Text(" CC ",
          style: TextStyle(
            fontSize: 20,
          )),
      value: 2,
    ));
    harfler.add(DropdownMenuItem(
      child: Text(" DC ",
          style: TextStyle(
            fontSize: 20,
          )),
      value: 1.5,
    ));
    harfler.add(DropdownMenuItem(
      child: Text(" DD ",
          style: TextStyle(
            fontSize: 20,
          )),
      value: 1,
    ));
    harfler.add(DropdownMenuItem(
      child: Text(" FF ",
          style: TextStyle(
            fontSize: 20,
          )),
      value: 0,
    ));
    return harfler;
  }

  Widget _listeElemanlariniOlustur(BuildContext context, int index) {
    sayac++;
    return Dismissible(
      key: Key(sayac.toString()),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) {
        setState(() {
          tumDersler.removeAt(index);
          ortalamaHesapla();
        });
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: tumDersler[index].renk, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        margin: EdgeInsets.all(5),
        child: ListTile(
          leading: Icon(
            Icons.done,
            size: 25,
            color: tumDersler[index].renk,
          ),
          title: Text(tumDersler[index].ad),
          subtitle: Text(tumDersler[index].kredi.toString() +
              "kredi Ders degeri:" +
              tumDersler[index].harfnotu.toString()),
        ),
      ),
    );
  }

  void ortalamaHesapla() {
    double toplamNot = 0, toplamKredi = 0;
    for (var oAnkidersler in tumDersler) {
      var kredi = oAnkidersler.kredi;
      var dersNotu = oAnkidersler.harfnotu;
      toplamKredi += kredi;
      toplamNot += (dersNotu * kredi);
    }
    ortalama = toplamNot / toplamKredi;
  }

  static Color rastGeleRenkOlustur() {
    return Color.fromARGB(150 + Random().nextInt(105), Random().nextInt(255),
        Random().nextInt(255), Random().nextInt(255));
  }
}

class Dersler {
  String ad;
  double harfnotu;
  int kredi;
  Color renk;

  Dersler(this.ad, this.harfnotu, this.kredi, this.renk);
}
