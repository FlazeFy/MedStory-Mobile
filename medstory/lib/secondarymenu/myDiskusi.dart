import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medstory/main.dart';

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
      appBar: AppBar(
        iconTheme: 
          const IconThemeData(
            color: Color(0xFF4183D7),
            size: 35.0,
          ),
        title: const Text("Pertanyaan Ku", 
        style: TextStyle(
          color: Color(0xFF4183D7),
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
      automaticallyImplyLeading: false,
      actions: [
        IconButton(
          icon: const Icon(Icons.home, color: Color(0xFF4183D7)),
          iconSize: 40,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const NavBar()),
            );
          },
        )
      ],

        //Transparent setting.
        backgroundColor: const Color(0x44FFFFFF),
        elevation: 0,
      ),

      //Body.
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Flexible(            
          child : SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: <Widget>[
                
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
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    children:[
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
                      const SizedBox(height: 10),
                      Flexible(
                        child: GetMyDiskusi(passUsername: widget.passUsername)
                      )
                    ]
                  )
                )
              ]
            )
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
  final Stream<QuerySnapshot> _diskusi = FirebaseFirestore.instance.collection('diskusi').where('namaPengguna', isEqualTo: passUsername).snapshots();

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
          children: snapshot.data.docs.map((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data() as Map<String, dynamic>;
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
                        SizedBox(
                          width: MediaQuery.of(context).size.width*0.2,
                        ),
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

          }).toList(),
        );
      },
    );
  }
}

class GetBalasanById extends StatefulWidget {
  const GetBalasanById({Key key, this.passDocumentId}) : super(key: key);
  final String passDocumentId;

  @override

  _GetBalasanById createState() => _GetBalasanById();
}

class _GetBalasanById extends State<GetBalasanById> {
  // GetBalasanById(this.documentId);
  final Stream<QuerySnapshot> _balasan = FirebaseFirestore.instance.collection('balasan').snapshots();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _balasan,
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
          children: snapshot.data.docs.map((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data() as Map<String, dynamic>;
            if(data['pengirim'] == passUsername){
              data['pengirim'] = 'Anda';
            }
            Widget getVerifiedAnswer() {
              if(data['status'] == 'verified'){
                return ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    'assets/images/verified.png', width: 30),
                );
              } else {
                return const SizedBox();
              }
            }
            if(widget.passDocumentId == data['id_diskusi']){
              return Container(
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
                                      data['pengirim'],
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
                                      "${DateFormat('dd MMM | hh:mm a').format((data['datetime'] as Timestamp).toDate()).toString()}",
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 13,
                                      )
                                    ),
                                  )                          
                                ]
                              ),
                            ),
                            getVerifiedAnswer(),
                          ]
                        )    
                      )                   
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(                     
                          data['isi'],
                          style: const TextStyle(
                            color: Color(0xFF6B6B6B),
                            fontWeight: FontWeight.w400,
                            fontSize: 13,
                          )
                        ),   
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: TextButton.icon(
                        onPressed: () {
                            // Respond to button press
                        },
                        icon: const Icon(Icons.arrow_upward, size: 14),
                        label: const Text("2"),
                      ),
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
            } //Empty message still duplicate. even if count = 0 method still error 
            if(widget.passDocumentId != data['id_diskusi']) {
              return const SizedBox();
            }

          }).toList(),
        );
      },
    );
  }
}