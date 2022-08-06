import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medstory/firebase/getMyDiskusi.dart';
import 'package:medstory/main.dart';
import 'package:medstory/widgets/custombg.dart';
import 'dart:math';

class MyDiscussionPage extends StatefulWidget {
  const MyDiscussionPage({Key key, this.passUsername}) : super(key: key);
  final String passUsername;

  @override

  _MyDiscussionPage createState() => _MyDiscussionPage();
}

class _MyDiscussionPage extends State<MyDiscussionPage> {
  final _pertanyaanCtrl = TextEditingController();
  CollectionReference disc = FirebaseFirestore.instance.collection('diskusi');
  XFile file;
  String seed = "null";

  Future<void> addDiskusi(XFile imageFile, String seed) async {
    String type;

    if(imageFile != null){
      seed = getRandomString(20);
      
      // Create a Reference to the file
      Reference ref = FirebaseStorage.instance
        .ref()
        .child('diskusi')
        .child(seed);

      final metadata = SettableMetadata(
        //contentType: 'image', 
        customMetadata: {'picked-file-path': imageFile.path},
      );

      //return await ref.putData(await imageFile.readAsBytes(), metadata);
      await ref.putData(await imageFile.readAsBytes(), metadata);
      seed = await ref.getDownloadURL();
      type = 'image';
    } else {
      type = 'text';
    }

    // Call the user's CollectionReference to add a new user
    return disc
      .add({
        'kategori': passKategori,
        'id_user': passIdUser, 
        'pertanyaan': _pertanyaanCtrl.text,
        'datetime': DateTime.tryParse(DateTime.now().toIso8601String()),
        'url': seed,
        'type': type,
      })
      .then((value) => 
        showDialog<void>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Informasi', style: TextStyle(fontWeight: FontWeight.bold)),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    ClipRRect(
                      child: Image.asset(
                        'assets/icon/Success.png', width: 35),
                    ),
                    const Text('Pertanyaan berhasil diunggah'),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('Oke'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          }
        )
      )
      .catchError((error) => print("Failed to add diskusi: $error"));
  }

  //Create random string.
  var _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();

  String getRandomString(int length) => 
    String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(
        _rnd.nextInt(_chars.length)
      )
    )
  );

  //Get image picker
  Future<XFile> getImage() async {
    return await ImagePicker().pickImage(source: ImageSource.gallery);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Body.
      body: CustomPaint(
        painter : CurvedPainter3(),
        child : SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Align(
                child: Container(
                  margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.1),
                  child:ElevatedButton.icon(
                    icon: const Icon(Icons.close, size: 30),
                    label: const Text("Kembali", style: TextStyle(fontSize: 16)),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.white.withOpacity(0.5)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        )
                      )
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                )
              ),
              Expanded(
                child: Container(
                  child: Column(
                    children:[
                      ExpansionTile(
                        initiallyExpanded: true,
                        leading: IconButton(
                          iconSize: 30,
                          icon: const Icon(Icons.add,
                          color: Color(0xFF808080)),
                          onPressed: () {},
                        ),
                        title: const Text(
                          "Tambah Pertanyaan",
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w800
                          ),
                        ),
                        children: <Widget>[                     
                          Container(
                            margin: const EdgeInsets.all(10),               
                            child: Card(
                              child: Container(
                                margin: const EdgeInsets.all(10),
                                child: Column(
                                  children: <Widget>[
                                    const Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text("  Kategori",
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w500
                                        )         
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(horizontal: 10.0),
                                        child: const DropDown2()
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    const Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text("  Pertanyaan",
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w500
                                        )         
                                      ),
                                    ),
                                    Align(
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(horizontal: 10.0),
                                        child: TextField(
                                          controller: _pertanyaanCtrl,
                                          decoration: const InputDecoration(
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(color: Color(0xFF4169E1), width: 2.0),
                                            ),
                                        
                                            hintText: "Ketikkan pertanyaan Anda disini",
                                          ),
                                        ),
                                      )
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children:[
                                        Container(
                                          child: IconButton(
                                            icon: const Icon(Icons.info),
                                            color: Colors.white,
                                            onPressed: () => showDialog<String>(
                                              context: context,
                                              builder: (BuildContext context) => AlertDialog(
                                                title: const Text('Kebijakan'),
                                                content: SizedBox(
                                                  height: 240,
                                                  child: Column(
                                                    children: const [
                                                      Text(                     
                                                        "1. Ukuran maksimal gambar yang diunggah sebesar 5 mb",
                                                        style: TextStyle(
                                                          color: Color(0xFF6B6B6B),
                                                          fontWeight: FontWeight.w400,
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                        Text(                     
                                                        "2. Unggah gambar yang tidak menggangu perasaan orang lain dan sesuai dengan topik yang dibahas",
                                                        style: TextStyle(
                                                          color: Color(0xFF6B6B6B),
                                                          fontWeight: FontWeight.w400,
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                        Text(                     
                                                        "3. Dilarang membahas topik mengenai SARA dan politik",
                                                        style: TextStyle(
                                                          color: Color(0xFF6B6B6B),
                                                          fontWeight: FontWeight.w400,
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                        Text(                     
                                                        "4. Pengguna yang terindikasi menyebarkan informasi palsu akan mendapatkan peringatan untuk diblokir",
                                                        style: TextStyle(
                                                          color: Color(0xFF6B6B6B),
                                                          fontWeight: FontWeight.w400,
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                        Text(                     
                                                        "5. Gunakan bahasa yang sopan dan mudah dimengerti",
                                                        style: TextStyle(
                                                          color: Color(0xFF6B6B6B),
                                                          fontWeight: FontWeight.w400,
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                        Text(                     
                                                        "6. Jumlah karakter yang terdapat dalam pertanyaan maupun balasan sebesar 500 karakter",
                                                        style: TextStyle(
                                                          color: Color(0xFF6B6B6B),
                                                          fontWeight: FontWeight.w400,
                                                          fontSize: 14,
                                                        ),
                                                      )
                                                    ],
                                                  )
                                                ),
                                                actions: <Widget>[
                                                  TextButton(
                                                    onPressed: () => Navigator.pop(context, 'OK'),
                                                    child: const Text('OK'),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(6),
                                            color: Colors.blue,
                                          ) 
                                        ),
                                        Container(
                                          margin: const EdgeInsets.symmetric(horizontal: 5),
                                          child: IconButton(
                                            icon: const Icon(Icons.image_search),
                                            color: Colors.white,
                                            onPressed: () async {
                                              file = await getImage();
                                            }
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(6),
                                            color: Colors.green,
                                          ) 
                                        ),
                                        const Spacer(),
                                        SizedBox(
                                          height: 45,
                                          child: ElevatedButton.icon(
                                            onPressed: () async {
                                              addDiskusi(file, seed);
                                              setState(() {});
                                            },
                                            label: const Text("Unggah Pertanyaan", style: TextStyle(color: Colors.white),),

                                            style: ButtonStyle(
                                            backgroundColor: MaterialStateProperty.all(Colors.green),
                                            
                                            ),
                                            icon: const Icon(Icons.send, color: Colors.white),
                                          ),
                                        )
                                      ]
                                    )
                                  ]
                                ),
                              )
                            ),
                            decoration: BoxDecoration(
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
                          )
                        ]
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: const Text("Pertanyaan Ku",
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Color(0xFF4183d7),
                            fontWeight: FontWeight.w500
                          )         
                        ),
                      ),
                      Flexible(
                        child: GetMyDiskusi(passUsername: widget.passUsername)
                      ) 
                    ]
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.5),
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                  )
                ) 
              )
            ]
          )
        )
      ),
    );
  }
}

//Dropdown kategori untuk buat pertanyaan
class DropDown2 extends StatefulWidget {
  const DropDown2({Key key}) : super(key: key);

  @override
  State<DropDown2> createState() => _DropDown2State();
}

class _DropDown2State extends State<DropDown2> {
  String dropdownValue = 'Penyakit Dalam';

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_drop_down),
      elevation: 16,
      style: const TextStyle(color: Color(0xFF212121)),
      underline: Container(
        height: 2,
        color: const Color(0xFF4183D7),
      ),
      onChanged: (String newValue) {
        setState(() {
          dropdownValue = newValue;
          passKategori = dropdownValue;
        });
      },
      items: <String>['Penyakit Dalam', 'Penyakit Menular', 'Vaksin & Imunisasi', 'Kulit & Kelamin', 'Otot & Saraf', 'THT & Mata', 'Penyakit Lansia', 'Obat-Obatan', 'Gaya Hidup Sehat', 'Kandungan & Bedah', 'Gigi', 'Anak']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}