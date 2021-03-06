import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medstory/main.dart';
import 'package:medstory/secondaryMenu/balasanPage.dart';
import 'package:medstory/widgets/custombg.dart';

class MyDiscussionPage extends StatefulWidget {
  const MyDiscussionPage({Key key, this.passUsername}) : super(key: key);
  final String passUsername;

  @override

  _MyDiscussionPage createState() => _MyDiscussionPage();
}

class _MyDiscussionPage extends State<MyDiscussionPage> {
  final _pertanyaanCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    CollectionReference disc = FirebaseFirestore.instance.collection('diskusi');

    Future<void> addDiskusi() {
      // Call the user's CollectionReference to add a new user
      return disc
        .add({
          'kategori': passKategori,
          'namaPengguna': widget.passUsername, 
          'pertanyaan': _pertanyaanCtrl.text,
          'datetime': DateTime.tryParse(DateTime.now().toIso8601String()),
          'imageURL': 'null', //initial user for now
          'view': 0,
          'up': 0, //initial user for now
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
        .catchError((error) => print("Failed to add user: $error"));
    }
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
                                        const SizedBox(width: 10),
                                        SizedBox(
                                          height: 45,
                                          child: ElevatedButton.icon(
                                            onPressed: () {
                                              addDiskusi();
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

class GetMyDiskusi extends StatefulWidget {
  const GetMyDiskusi({Key key, this.passUsername}) : super(key: key);
  final String passUsername;

  @override
    _GetMyDiskusiState createState() => _GetMyDiskusiState();
}

class _GetMyDiskusiState extends State<GetMyDiskusi> {
  final Stream<QuerySnapshot> _diskusi = FirebaseFirestore.instance.collection('diskusi').orderBy('datetime', descending: true).snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _diskusi,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center( 
            child: CircularProgressIndicator()
          );
        }

        return ListView(
          padding: const EdgeInsets.only(top: 0),
          children: snapshot.data.docs.map((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data() as Map<String, dynamic>;
            if(data['namaPengguna'] == passUsername){
              return Container(
                transform: Matrix4.translationValues(0.0, -5.0, 0.0),
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Card(
                  child: Column(
                  children: [
                    Align(
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Row(
                          children: [ 
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 5.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.asset(
                                  'assets/images/User.jpg', width: 40),
                                ),
                            ),
                                    
                            SizedBox(
                              width: MediaQuery.of(context).size.width*0.73,
                              child: Column (
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(                     
                                      data['namaPengguna'],
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                      )
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(                     
                                      "${data['kategori']} ~ ${DateFormat('dd MMM | hh:mm a').format((data['datetime'] as Timestamp).toDate()).toString()}",
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 13,
                                      )
                                    ),
                                  )                          
                                ]
                              ),
                            ),
                            ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(
                              'assets/images/verified.png', width: 30),
                            ),
                          ]
                        )    
                      )                   
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(                     
                          data['pertanyaan'],
                          style: const TextStyle(
                            color: Color(0xFF6B6B6B),
                            fontWeight: FontWeight.w400,
                            fontSize: 13,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                        ),   
                      ),
                    ),
                    Row(
                      children: [            
                        TextButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (c, a1, a2) => DiscussionPage(documentId: document.id),
                                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                  final tween = Tween(begin: const Offset(0.0, 1.0), end: Offset.zero);
                                  final curvedAnimation = CurvedAnimation(
                                    parent: animation,
                                    curve: Curves.ease,
                                  );

                                  return SlideTransition(
                                    position: tween.animate(curvedAnimation),
                                    child: child,
                                  );
                                }
                              ),
                            );
                          },
                          icon: const Icon(Icons.arrow_drop_down, size: 14),
                          label: const Text("Lihat komentar (3)"),
                        ),
                        Spacer(),
                        TextButton.icon(
                          onPressed: () {
                            //
                          },
                          icon: const Icon(Icons.arrow_upward, size: 14),
                          label: Text(data['up'].toString()),
                        ),
                        TextButton.icon(
                          onPressed: () {
                              // Respond to button press
                          },
                          icon: const Icon(Icons.remove_red_eye, size: 14),
                          label: Text(data['view'].toString()),
                        ),
                      ]
                    ),       
                  ]

                  ),
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Color(0xFFe8e8e8), width: 1),
                    borderRadius: BorderRadius.circular(6),
                  ),
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
              );
            } else {
              return SizedBox();
            }
          }).toList(),
        );
      },
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