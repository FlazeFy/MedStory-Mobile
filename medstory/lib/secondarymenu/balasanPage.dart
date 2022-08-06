import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medstory/firebase/getBalasan.dart';
import 'package:medstory/firebase/getDiskusionBalasan.dart';
import 'package:medstory/firebase/getUsername.dart';
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
  CollectionReference diskusi = FirebaseFirestore.instance.collection('diskusi');
  CollectionReference balasan = FirebaseFirestore.instance.collection('balasan');
  Future<void> replyDiscussion() {
    return balasan
      .add({
        'id_diskusi': widget.documentId, 
        'datetime': DateTime.tryParse(DateTime.now().toIso8601String()),
        'imageURL': 'null', //initial user for now
        'isi': _isiCtrl.text,
        'pengirim': passIdUser,
        'status': 'null',
      })
      .then((value) => print("Balasan terkirim"))
      .catchError((error) => print("Failed to add balasan: $error"));
  }

  @override
  Widget build(BuildContext context) {
    double fullHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      //Body.
      body: CustomPaint(
        painter : CurvedPainter3(),
        child : SizedBox(
          height: fullHeight,
          child: Column(
            children: [
              Align(
                child: Container(
                  margin: EdgeInsets.only(top: fullHeight*0.1),
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => NavBar()),
                      );
                    },
                  )
                )
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(top: 10.0),
                  padding: const EdgeInsets.all(5),
                  height: fullHeight*0.8,
                  child: ListView(
                    padding: EdgeInsets.all(0),
                    children:[
                      GetDiskusiOnBalasan(passDocumentId: widget.documentId),
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
                      
                    ]
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.5),
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                  )
                ),
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => DiscussionPage(documentId: widget.documentId)),
                          );
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
            ], 

          )
        )
      )
    );
  }
}