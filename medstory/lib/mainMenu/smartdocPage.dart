

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:medstory/main.dart';
import 'package:medstory/mainMenu/forumPage.dart';
import 'package:medstory/widgets/sideNav.dart';

class SmartDocPage extends StatefulWidget {
  const SmartDocPage({Key key, this.passUsername, this.passIdUser}) : super(key: key);

  final String passUsername;
  final String passIdUser;

  @override

  _SmartDocPage createState() => _SmartDocPage();
}

class _SmartDocPage extends State<SmartDocPage> {
  int passBeratBMI;
  int passTinggiBMI;

  int passTinggiCal;
  int passBeratCal;
  int passUsiaCal;
  int passGenderCal;
  int passAktvCal;

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: ListView(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 10.0),
              child: const Align(
                alignment: Alignment.centerLeft,
                child: Text("  SmartDoc",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600
                  )         
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                      child: const Text(
                        "Kalkulator BMI", 
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF212121)
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: const Text(
                        "Body Mass Index (BMI) atau Indeks Massa Tubuh (IMT) adalah angka yang menjadi penilaian standar untuk menentukan apakah berat badan Anda tergolong normal, kurang, berlebih, atau obesitas.", 
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xFF6B6B6B)
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                    child: Row(
                      children: [
                        SizedBox(
                          width:120,
                          height: 50,
                          child: SpinBox(
                            min: 1, max: 220,
                            value: 1,
                            spacing: 1,
                            textStyle: const TextStyle(
                              fontSize: 16.0,
                            ),

                            onChanged: (value) => passTinggiBMI = value.toInt(),
                            decoration: const InputDecoration(labelText: 'Tinggi Badan (Cm)'),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5.0),
                          width:120,
                          height: 50,
                          child: SpinBox(
                            min: 1, max: 160,
                            value: 1,
                            spacing: 1,
                            textStyle: const TextStyle(
                              fontSize: 16.0,
                            ),
                            onChanged: (value) => passBeratBMI = value.toInt(),
                            decoration: const InputDecoration(labelText: 'Berat Badan (Kg)'),
                          ),
                        ),
                        SizedBox(
                          height: 45,
                          child: ElevatedButton(
                            onPressed: () async {
                              double tinggi = passTinggiBMI/100;
                              int berat = passBeratBMI;
                              double bmi = berat / (tinggi * tinggi);
		
                              if (bmi < 18.6) {
                                //Thin Body
                                return showDialog<void>(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Kurus :(', style: TextStyle(fontWeight: FontWeight.bold)),
                                      content: SingleChildScrollView(
                                        child: ListBody(
                                          children: <Widget>[
                                            ClipRRect(
                                              child: Image.asset(
                                                'assets/icon/Thin.png', width: 100),
                                            ),
                                            const Text('Tambah asupan makanan, kurangi stres, dan istirahat yang cukup'),
                                          ],
                                        ),
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          child: const Text('Oke, siap'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              } else if (bmi >= 18.6 && bmi < 29.9) {
                                //Normal Body
                                return showDialog<void>(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Normal :)', style: TextStyle(fontWeight: FontWeight.bold)),
                                      content: SingleChildScrollView(
                                        child: ListBody(
                                          children: <Widget>[
                                            ClipRRect(
                                              child: Image.asset(
                                                'assets/icon/Normal.png', width: 100),
                                            ),
                                            const Text('Tetap jaga pola makan Anda. Dan jangan lengah sampai terlena ya'),
                                          ],
                                        ),
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          child: const Text('Oke, siap'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              } else { 
                                //Obesity Body
                                return showDialog<void>(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Obesitas :(', style: TextStyle(fontWeight: FontWeight.bold)),
                                      content: SingleChildScrollView(
                                        child: ListBody(
                                          children: <Widget>[
                                            ClipRRect(
                                              child: Image.asset(
                                                'assets/icon/Big.png', width: 100),
                                            ),
                                            const Text('Ayo kurangi makan dan perbanyak olahraga'),
                                          ],
                                        ),
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          child: const Text('Oke, siap'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                            },
                            child: const Text("Hitung"),
                          )
                        )
                      ],
                    )
                  )
                ],
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10), 
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    blurRadius: 10.0, // soften the shadow
                    spreadRadius: 0.0, //extend the shadow
                    offset: const Offset(
                      5.0, // Move to right 10  horizontally
                      5.0, // Move to bottom 10 Vertically
                    ),
                  )
                ],
              ),
            ),

            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                      child: const Text(
                        "RoboDoc", 
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF212121)
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: const Text(
                        "RoboDoc adalah fitur yang dapat mendukung Anda untuk mengetahui penyakit yang Anda derita dengan cepat dan tanpa perlu diagnosa lansung dengan dokter. Anda cukup memberitahukan gejala yang Anda derita kepada RoboDoc. Dan kami akan menampilkan daftar kemungkinan penyakit yang Anda derita.", 
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xFF6B6B6B)
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      children: [
                        const Flexible(
                          // child: TextField(
                          //   maxLines: 3, //or null 
                          //   decoration: InputDecoration(hintText: "Sertakan tanda ',' untuk menambahkan gejala lainnya", labelText: "Gejala"),
                          //   style: TextStyle(
                          //     fontSize: 16.0,
                          //   )
                          // ),
                          child: AutocompleteBasicExample(),
                        ),
                        SizedBox(
                          height: 45,
                          child: ElevatedButton(
                            onPressed: () {
                              //
                            },
                            child: const Text("Hitung"),
                          )
                        )
                      ],
                    )
                  ), 
                  const SizedBox(
                    height: 10,
                  )
                ],
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10), 
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    blurRadius: 10.0, // soften the shadow
                    spreadRadius: 0.0, //extend the shadow
                    offset: const Offset(
                      5.0, // Move to right 10  horizontally
                      5.0, // Move to bottom 10 Vertically
                    ),
                  )
                ],
              ),
            ),

            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                      child: const Text(
                        "Kalkulator Kalori", 
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF212121)
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: const Text(
                        "Dengan alat ini Anda mengetahui berapa asupan kalori yang dibutuhkan. Hasil perhitungannya dapat Anda gunakan sebagai salah satu acuan untuk mengontrol asupan kalori per hari.", 
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xFF6B6B6B)
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                    child: Row(
                      children: [
                        SizedBox(
                          width:110,
                          height: 50,
                          child: SpinBox(
                            min: 1, max: 220,
                            value: 1,
                            spacing: 1,
                            textStyle: const TextStyle(
                              fontSize: 16.0,
                            ),
                            onChanged: (value) => passTinggiCal = value.toInt(),
                            decoration: const InputDecoration(labelText: 'Tinggi Badan (Cm)'),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5.0),
                          width:110,
                          height: 50,
                          child: SpinBox(
                            min: 1, max: 160,
                            value: 1,
                            spacing: 1,
                            textStyle: const TextStyle(
                              fontSize: 16.0,
                            ),
                            onChanged: (value) => passBeratCal = value.toInt(),
                            decoration: const InputDecoration(labelText: 'Berat Badan (Kg)'),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5.0),
                          width:100,
                          height: 50,
                          child: SpinBox(
                            min: 10, max: 110,
                            value:10,
                            spacing: 1,
                            textStyle: const TextStyle(
                              fontSize: 16.0,
                            ),
                            onChanged: (value) => passUsiaCal = value.toInt(),
                            decoration: const InputDecoration(labelText: 'Umur'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      children: [
                        Column(
                          children:[
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Jenis Kelamin", 
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Color(0xFF808080)
                                ),
                              ),
                            ),
                            Container(
                              transform: Matrix4.translationValues(-5.0, 0.0, 0.0),
                              child: const DropDownJK()
                            )
                          ]
                        ),
                        Column(
                          children:[
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Aktivitas Fisik / Olahraga", 
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Color(0xFF808080)
                                ),
                              ),
                            ),
                            Container(
                              transform: Matrix4.translationValues(25.0, 0.0, 0.0),
                              child: const DropDownAktv()
                            )
                          ]
                        ),
                      ],
                    )
                  ),
                  Container(
                    height: 45,
                    margin: const EdgeInsets.only(bottom: 10.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        //Not
                        int tinggi = passTinggiCal;
                        int berat = passBeratCal;
                        int usia = 21;
                        double aktivitas = 1; //for testing
                        int jKelamin = 1; //for testing
                        double total;

                        if(aktivitas==1){
                          aktivitas = 1.2;
                        } else if(aktivitas==2){
                          aktivitas = 1.4;
                        } else if(aktivitas==3){
                          aktivitas = 1.6;
                        } else if(aktivitas==4){
                          aktivitas = 1.8;
                        } else {
                          aktivitas = 2;
                        }
                        
                        if(jKelamin == 1){
                          total = (((88.4 + 13.4 * berat) + (4.8 * tinggi) - (5.68 * usia)) * aktivitas);
                        } else if(jKelamin == 2){
                          total = (((447.6 + 9.25 * berat) + (3.10 * tinggi) - (4.33 * usia)) * aktivitas);
                        }

                        return showDialog<void>(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Informasi', style: TextStyle(fontWeight: FontWeight.bold)),
                              content: SingleChildScrollView(
                                child: ListBody(
                                  children: <Widget>[
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(6),
                                      child: Image.asset(
                                        'assets/icon/Calorie.png', width: 100),
                                    ),
                                    Text('Kebutuhan harian Anda sebesar:'+ total.toStringAsFixed(2) +" cal"),
                                  ],
                                ),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text('Oke, siap'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: const Text("Hitung"),
                    )
                  )
                ],
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10), 
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    blurRadius: 10.0, // soften the shadow
                    spreadRadius: 0.0, //extend the shadow
                    offset: const Offset(
                      5.0, // Move to right 10  horizontally
                      5.0, // Move to bottom 10 Vertically
                    ),
                  )
                ],
              ),
            ),


          ], 

        )
      )
      
    );
  }
}

//Autocomplete still no data passing
class AutocompleteBasicExample extends StatelessWidget {
  const AutocompleteBasicExample({Key key}) : super(key: key);

  static final List<String> _kOptions = <String>[
    GetDiskusi().toString()
  ];

  @override
  Widget build(BuildContext context) {
    return Autocomplete<String>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text == '') {
          return const Iterable<String>.empty();
        }
        return _kOptions.where((String option) {
          return option.contains(textEditingValue.text.toLowerCase());
        });
      },
      onSelected: (String selection) {
        debugPrint('You just selected $selection');
      },
    );
  }
}

class GetGejala extends StatefulWidget {
  const GetGejala({Key key}) : super(key: key);

  @override
    _GetGejalaState createState() => _GetGejalaState();
}

class _GetGejalaState extends State<GetGejala> {
 
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('gejala').snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center( 
            child: CircularProgressIndicator()
          );
        }

        // return ListView(
        //   children: snapshot.data.docs.map((DocumentSnapshot document) {
        //   Map<String, dynamic> data = document.data() as Map<String, dynamic>;
        //     return ListTile(
        //       title: Text(data['full_name']),
        //       subtitle: Text(data['company']),
        //     );
        //   }).toList(),
        // );
        snapshot.data.docs.map((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data() as Map<String, dynamic>;
          return data['nama_gejala'].toString();
        }).toList();
        
        
      },
    );
  }
}