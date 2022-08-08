import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:full_screen_menu/full_screen_menu.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medstory/firebase/forum/countKomentar.dart';
import 'package:medstory/firebase/forum/getBalasan.dart';
import 'package:medstory/firebase/forum/getDiskusionBalasan.dart';
import 'package:medstory/main.dart';
import 'package:medstory/widgets/custombg.dart';
import 'dart:math';

class DiscussionPage extends StatefulWidget {
  const DiscussionPage({Key key, this.documentId}) : super(key: key);
  final String documentId;

  @override

  _DiscussionPage createState() => _DiscussionPage(documentId);
}

class _DiscussionPage extends State<DiscussionPage> with SingleTickerProviderStateMixin{
  _DiscussionPage(documentId);
  final _isiCtrl = TextEditingController();
  CollectionReference balasan = FirebaseFirestore.instance.collection('balasan');
  XFile file;
  String seed = "null";
  
  Future<void> replyDiscussion(XFile imageFile, String seed) async {
    String type;

    if(imageFile != null){
      seed = getRandomString(20);
      
      // Create a Reference to the file
      Reference ref = FirebaseStorage.instance
        .ref()
        .child('balasan')
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

    return balasan
      .add({
        'id_diskusi': widget.documentId, 
        'datetime': DateTime.tryParse(DateTime.now().toIso8601String()),
        'isi': _isiCtrl.text,
        'id_user': passIdUser,
        'status': 'null',
        'url': seed,
        'type': type,
      })
      .then((value) => print("Balasan terkirim"))
      .catchError((error) => print("Failed to add balasan: $error"));
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
    double fullHeight = MediaQuery.of(context).size.height;
    double fullWidth = MediaQuery.of(context).size.width;

    return Scaffold(
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
                        MaterialPageRoute(builder: (context) => const NavBar()),
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
                    padding: const EdgeInsets.all(0),
                    children:[
                      GetDiskusiOnBalasan(passDocumentId: widget.documentId),
                      CountKomentar2(passDocumentId: widget.documentId),
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
              
              Container(
                alignment: Alignment.bottomCenter,
                padding: const EdgeInsets.only(left: 10,bottom: 10,top: 10),
                margin: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5),
                height: 60,
                width: double.infinity,
                child: Row(
                  children: <Widget>[
                    GestureDetector(
                      onTap: (){
                        //Bug : not close after back button is pressed
                        FullScreenMenu.show(
                          context,
                          backgroundColor: Colors.white,
                          items: [
                            FSMenuItem(
                              icon: const Icon(Icons.mic, color: Colors.white),
                              text: const Text('Audio', style: TextStyle(color: Colors.blue)),
                              gradient: blueGradient,
                            ),
                            FSMenuItem(
                              icon: const Icon(Icons.file_copy, color: Colors.white),
                              text: const Text('Document', style: TextStyle(color: Colors.blue)),
                              gradient: purpleGradient,
                            ),
                            FSMenuItem(
                              icon: const Icon(Icons.image, color: Colors.white),
                              text: const Text('Image', style: TextStyle(color: Colors.blue)),
                              gradient: redGradient,
                              onTap: () async {
                                file = await getImage();
                              },
                            ),
                          ],
                        );
                      },
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          color: Colors.lightBlue,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const Icon(Icons.add, color: Colors.white, size: 20, ),
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      width: fullWidth*0.7,
                      child: TextField(
                        controller: _isiCtrl,
                        decoration: const InputDecoration(
                          hintText: "Ketik balasan Anda...",
                          hintStyle: TextStyle(color: Color(0xFF6B6B6B)),
                          border: InputBorder.none
                        ),
                      ),
                    ),
                    const Spacer(),
                    FloatingActionButton(
                      onPressed: () async{
                        replyDiscussion(file, seed);
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
            ], 
          )
        )
      )
    );
  }
}