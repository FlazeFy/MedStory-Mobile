import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medstory/widgets/custombg.dart';
import 'dart:math';

int editTinggi = 0;
int editBerat = 0;

class EditAccPage extends StatefulWidget {
  const EditAccPage({Key key, this.passUsername, this.passDocumentId}) : super(key: key);

  final String passUsername;
  final String passDocumentId;

  @override
  _EditAccPageState createState() => _EditAccPageState();
}
class _EditAccPageState extends State<EditAccPage> {
  final _namaLengkapCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _ponselCtrl = TextEditingController();
  final _pekerjaanCtrl = TextEditingController();
  final _alamatCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();

  var namaLengkap = ""; 
  var email = "";
  var ponsel = "";
  var pekerjaan = "";
  var alamat = "";
  var password = "";
  int tinggiEdit = 0;
  int beratEdit = 0;

  CollectionReference users = FirebaseFirestore.instance.collection('pengguna');
  XFile file;
  String seed = "null";

  Future<void> updatePengguna() async {
    return users
      .doc(widget.passDocumentId)
      .update({
        'namaLengkap': namaLengkap, 
        'email': email, 
        'ponsel': ponsel, 
        'pekerjaan': pekerjaan, 
        'alamat': alamat, 
        'password': password, 
        'tinggiBadan': tinggiEdit, 
        'beratBadan': beratEdit
      })
      .then((value) => print("Profil berhasil diupdate"))
      .catchError((error) => print("Failed to update user: $error"));
  }

  Future<void> updateImage(XFile imageFile, String seed, String oldUrl) async {
    if(imageFile != null){
      seed = getRandomString(20);
      
      // Create a Reference to the file
      Reference ref = FirebaseStorage.instance
        .ref()
        .child('pengguna')
        .child(seed);

      final metadata = SettableMetadata(
        //contentType: 'image', 
        customMetadata: {'picked-file-path': imageFile.path},
      );

      //return await ref.putData(await imageFile.readAsBytes(), metadata);
      await ref.putData(await imageFile.readAsBytes(), metadata);
      seed = await ref.getDownloadURL();

      //Split url into filename.
      final url = oldUrl.split('%2F');
      final location = url[1].split('?alt'); 
      oldUrl = location[0];

      // Call the user's CollectionReference to add a new user
      await users
        .doc(widget.passDocumentId)
        .update({
          'url': seed
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
                      const Text('Foto Profil berhasil diubah'),
                      const Text('Perubahan memakan waktu berapa saat'),
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
          ),
        )
        .catchError((error) => print("Failed to add diskusi: $error"));

      //Delete old image.
      Reference desertRef = FirebaseStorage.instance.ref().child('pengguna').child(oldUrl);
      await desertRef.delete();
    } else {
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
                    child: Image.asset(
                      'assets/icon/Failed.png', width: 35),
                  ),
                  const Text('Anda belum memilih foto profil'),
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
      );
    }
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
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(widget.passDocumentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data.exists) {
          return const Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data.data() as Map<String, dynamic>;
          return Scaffold(     
            body: CustomPaint(
              painter: WhitePainter(),
              child : SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Row(  
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 20.0),
                          transform: Matrix4.translationValues(0.0, 100.0, 0.0),
                          alignment: Alignment.topLeft,
                          height: 60,
                          width: 60,
                          padding: const EdgeInsets.all(2),
                          child: Ink(
                            decoration: const ShapeDecoration(
                              color: Colors.white,
                              shape: CircleBorder(),
                            ),
                            child: IconButton(
                              icon: const Icon(Icons.arrow_back, size: 40),
                              color: Colors.white,
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: const Color(0xFFd9534f),
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromARGB(255, 190, 190, 190),            
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset: Offset(0, 3)
                              )
                            ],
                          )
                        ),
                        SizedBox(width: MediaQuery.of(context).size.width*0.26),
                        Stack(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.09),
                              alignment: Alignment.topRight,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Image.network(data['url'], width: 180),
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(100), 
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
                              transform: Matrix4.translationValues(120.0, MediaQuery.of(context).size.height*0.23, 0.0),                    
                              alignment: Alignment.bottomRight,
                              height: 60,
                              width: 60,
                              padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),                              
                              child: GestureDetector(
                              onTap: () async {
                                  file = await getImage();
                                  updateImage(file, seed, data['url']);
                                  setState(() {});
                                },  
                                child: ClipRRect(
                                  child: Image.asset('assets/icon/Add Image.png', width: 40),
                                ),
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFF4183D7),
                                border: Border.all(
                                  color: Colors.white,
                                  width: 3,
                                ),
                                borderRadius: BorderRadius.circular(100), 
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
                        )
                      ]
                    ),
                    const SizedBox(height: 20),
                    Flexible(
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height,
                        child: ListView(
                          padding: const EdgeInsets.only(top: 0),
                          children:[ 
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                                child: const Text(                     
                                  'Data Akun',
                                  style: TextStyle(
                                    color: Color(0xFF212121),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  )
                                ),   
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                              child: TextField(
                                controller: _namaLengkapCtrl,
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  labelText: data['namaLengkap'],
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  margin: const EdgeInsets.symmetric(horizontal: 10.0),
                                  width: MediaQuery.of(context).size.width*0.5,
                                  child: TextField(
                                    controller: _emailCtrl,
                                    decoration: InputDecoration(
                                      border: const OutlineInputBorder(),
                                      labelText: data['email'],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width*0.4,
                                  child: TextField(
                                    controller: _ponselCtrl,
                                    decoration: InputDecoration(
                                      border: const OutlineInputBorder(),
                                      labelText: data['ponsel'],
                                    ),
                                  ),
                                ),
                              
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                              child: TextField(
                                controller: _passwordCtrl,
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  labelText: data['password'],
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                                child: const Text(                     
                                  'Data Diri',
                                  style: TextStyle(
                                    color: Color(0xFF212121),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  )
                                ),   
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                              child: TextField(
                                controller: _alamatCtrl,
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  labelText: data['alamat'],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                              child: TextField(
                                controller: _pekerjaanCtrl,
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  labelText: data['pekerjaan'],
                                ),
                              ),
                            ),
                            const SizedBox(height: 10,),
                            Row(
                              children: [
                                const SizedBox(width:10),
                                SizedBox(
                                  width:140,
                                  height: 50,
                                  child: SpinBox(
                                    min: 1, max: 220,
                                    value: data['tinggiBadan'].toDouble(),
                                    spacing: 1,
                                    textStyle: const TextStyle(
                                      fontSize: 16.0,
                                    ),
                                    onChanged: (value) => editTinggi = value.toInt(),
                                    decoration: const InputDecoration(labelText: 'Tinggi Badan (Cm)'),
                                  ),
                                ),
                                const SizedBox(width:10),
                                SizedBox(
                                  width:140,
                                  height: 50,
                                  child: SpinBox(
                                    min: 1, max: 220,
                                    value: data['beratBadan'].toDouble(),
                                    spacing: 1,
                                    textStyle: const TextStyle(
                                      fontSize: 16.0,
                                    ),
                                    onChanged: (value) => editBerat = value.toInt(),
                                    decoration: const InputDecoration(labelText: 'Berat Badan (Kg)'),
                                  ),
                                ),
                                const SizedBox(width:10),
                                Container(
                                  child: IconButton(
                                    icon: const Icon(Icons.info),
                                    color: Colors.white,
                                    onPressed: () {},
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    color: Colors.blue,
                                  ) 
                                )

                              ],
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 10.0),
                              child: ElevatedButton.icon(
                                onPressed: () async {
                                  if(_namaLengkapCtrl.text.isEmpty){
                                    namaLengkap = data['namaLengkap'];
                                  } else {
                                    namaLengkap = _namaLengkapCtrl.text;
                                  }
                                  if(_emailCtrl.text.isEmpty){
                                    email = data['email'];
                                  } else {
                                    email = _emailCtrl.text;
                                  }
                                  if(_ponselCtrl.text.isEmpty){
                                    ponsel = data['ponsel'];
                                  } else {
                                    ponsel = _ponselCtrl.text;
                                  }
                                  if(_pekerjaanCtrl.text.isEmpty){
                                    pekerjaan = data['pekerjaan'];
                                  } else {
                                    pekerjaan = _pekerjaanCtrl.text;
                                  }
                                  if(_alamatCtrl.text.isEmpty){
                                    alamat = data['alamat'];
                                  } else {
                                    alamat = _alamatCtrl.text;
                                  }
                                  if(_passwordCtrl.text.isEmpty){
                                    password = data['password'];
                                  } else {
                                    password = _passwordCtrl.text;
                                  }
                                  if(editTinggi == 0){
                                    tinggiEdit = data['tinggiBadan'];
                                  } else {
                                    tinggiEdit = editTinggi;
                                  }
                                  if(editBerat == 0){
                                    beratEdit = data['beratBadan'];
                                  } else {
                                    beratEdit = editBerat;
                                  }
                                  updatePengguna();
                                  Navigator.pop(context);
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.green, // Background color
                                ),
                                icon: const Icon(Icons.save, size: 18),
                                label: const Text("Simpan Perubahan"),
                              )
                            )

                          ]
                        )
                      )
                    )
                  ],
                )
              ),
            ),
          );  
        }

        return const Center( 
          child: CircularProgressIndicator()
        );
      },
    );
  }
  
}