import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medstory/main.dart';
import 'package:medstory/secondaryMenu/myDiskusiPage.dart';
import 'package:medstory/widgets/custombg.dart';

class DiscussionPage extends StatefulWidget {
  const DiscussionPage({Key key, this.documentId}) : super(key: key);
  final String documentId;

  @override

  _DiscussionPage createState() => _DiscussionPage(documentId);
}

class _DiscussionPage extends State<DiscussionPage> with SingleTickerProviderStateMixin{
  _DiscussionPage(documentId);
  final _isiCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    CollectionReference diskusi = FirebaseFirestore.instance.collection('diskusi');
    CollectionReference balasan = FirebaseFirestore.instance.collection('balasan');

    Future<void> replyDiscussion() {
      return balasan
        .add({
          'id_diskusi': widget.documentId, 
          'datetime': DateTime.tryParse(DateTime.now().toIso8601String()),
          'imageURL': 'null', //initial user for now
          'isi': _isiCtrl.text,
          'pengirim': passUsername,
          'status': 'null',
        })
        .then((value) => print("Balasan terkirim"))
        .catchError((error) => print("Failed to add user: $error"));
    }

    return FutureBuilder<DocumentSnapshot>(
      future: diskusi.doc(widget.documentId).get(),
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
                        margin: const EdgeInsets.only(top: 10.0),
                        padding: const EdgeInsets.all(5),
                        child: Column(
                          children:[
                            Align(
                              child: Container(
                                margin: const EdgeInsets.only(top: 10.0),
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
                                                      "${data['kategori']} ~ ${DateFormat('yyyy-MM-dd | hh:mm a').format((data['datetime'] as Timestamp).toDate()).toString()}",
                                                      style: const TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 13,
                                                      )
                                                    ),
                                                  )                          
                                                ]
                                              ),
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
                                          )
                                        ),   
                                      ),
                                    ),
                                    Row(
                                      children: [            
                                        SizedBox(
                                          width: MediaQuery.of(context).size.width*0.6,
                                        ),
                                        TextButton.icon(
                                          onPressed: () {
                                              // Respond to button press
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
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                margin: const EdgeInsets.symmetric(vertical: 10.0),
                                transform: Matrix4.translationValues(0.0, 5.0, 0.0),
                                child: const Text("  Balasan (3)",
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF4183D7)
                                  )         
                                ),
                              )
                            ),
                            Flexible(
                              child: GetBalasanById(passDocumentId: widget.documentId)
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                padding: const EdgeInsets.only(left: 10,bottom: 10,top: 10),
                                margin: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5),
                                height: 60,
                                width: double.infinity,
                                child: Row(
                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: (){
                                      },
                                      child: Container(
                                        height: 30,
                                        width: 30,
                                        decoration: BoxDecoration(
                                          color: Colors.lightBlue,
                                          borderRadius: BorderRadius.circular(30),
                                        ),
                                        child: const Icon(Icons.image, color: Colors.white, size: 20, ),
                                      ),
                                    ),
                                    const SizedBox(width: 15,),
                                    Expanded(
                                      child: TextField(
                                        controller: _isiCtrl,
                                        decoration: const InputDecoration(
                                          hintText: "Ketik balasan Anda...",
                                          hintStyle: TextStyle(color: Color(0xFF6B6B6B)),
                                          border: InputBorder.none
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 15,),
                                    FloatingActionButton(
                                      onPressed: () async{
                                        replyDiscussion();
                                      },
                                      child: const Icon(Icons.send,color: Colors.white,size: 18,),
                                      backgroundColor: Colors.green,
                                      elevation: 0,
                                    ),
                                  ],
                                  
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Colors.white, 
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
                            ),
                          ]
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.5),
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                        )
                      ),
                    )
                  ], 

                )
              )
            )
          );
        }

        //Loading
        return const Center( 
          child: CircularProgressIndicator()
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
  final Stream<QuerySnapshot> _balasan = FirebaseFirestore.instance.collection('balasan').orderBy('datetime', descending: true).snapshots();
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
          padding: const EdgeInsets.only(top: 0),
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
                              width: MediaQuery.of(context).size.width*0.5,
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
                            const Spacer(),
                            Container(
                              margin: const EdgeInsets.only(right: 10),
                              child: getVerifiedAnswer(),
                            )
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
                      blurRadius: 10.0, 
                      spreadRadius: 0.0, 
                      offset: const Offset(5.0, 5.0),
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