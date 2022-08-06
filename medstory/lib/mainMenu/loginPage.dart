
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medstory/main.dart';
import 'package:medstory/mainMenu/createAccPage.dart';
import 'package:medstory/widgets/custombg.dart';


class Login extends StatelessWidget {
  var usernameCtrl = TextEditingController();
  var passwordCtrl = TextEditingController();

  Login({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter : CurvedPainter(),
      child : SizedBox(
        height: MediaQuery.of(context).size.height,
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [   
            Flexible(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
                transform: Matrix4.translationValues(MediaQuery.of(context).size.width*0.2, 0.0, 0.0),
                child: ClipRRect(
                child: Image.asset(
                  'assets/icon/Hello.png', width: MediaQuery.of(context).size.width*0.9),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20.0),
                child: const Text('Selamat datang di',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 15,
                    color: Colors.white
                  ),
                ),
              )
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20.0),
                child: const Text('MedStory',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 30,
                    color: Colors.white
                  ),
                ),
              )
            ),

            //Username section.
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
                child: TextFormField(
                  controller: usernameCtrl,
                  decoration: InputDecoration(
                    labelStyle: const TextStyle(color: Colors.black),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: const BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: const BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    labelText: 'Nama Pengguna', 
                  ),
                  style:const TextStyle(color: Colors.white),
                ),
              ),
            ),

            //Password section.
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
                child: TextFormField(
                  obscureText: true,
                  controller: passwordCtrl,
                  decoration: InputDecoration(
                    labelStyle: const TextStyle(color: Colors.black),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: const BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: const BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    labelText: 'Password',
                  ),
                  style:const TextStyle(color: Colors.white),
                ),
              ),
            ),

            Row(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextButton(
                    onPressed: () {
                      
                    },
                    child: const Text('Ganti Password',
                      style: TextStyle(
                        fontSize: 14,
                        decoration: TextDecoration.underline,
                      )
                    ),
                    style: TextButton.styleFrom(
                      primary: const Color(0xFFFFFFFF),
                    ),
                  ),
                ),
                SizedBox(width: MediaQuery.of(context).size.width* 0.3),
                Container(
                  height: 40,
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: ElevatedButton(
                    child: const Text('Submit'),
                    onPressed: () async{
                      int i = 0;
                      FirebaseFirestore.instance
                      .collection('pengguna')
                      .get()
                      .then((QuerySnapshot querySnapshot) {
                          querySnapshot.docs.forEach((doc) {
                            if((doc["namaPengguna"] == usernameCtrl.text)&&(doc["password"] == passwordCtrl.text)){
                              i++;
                              passIdUser = doc.id;
                              passUsername = doc['namaPengguna'];
                            }
                          });
                          if(i > 0){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const NavBar()),
                            );
                          } else {
                            return showDialog<void>(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Perhatian', style: TextStyle(fontWeight: FontWeight.bold)),
                                  content: SingleChildScrollView(
                                    child: ListBody(
                                      children: <Widget>[
                                        ClipRRect(
                                          child: Image.asset(
                                            'assets/icon/Failed.png', width: 20),
                                        ),
                                        const Text('Username atau password Anda salah'),
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
                      });
                    
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF4169E1)),
                    ),
                  )
                ),
              ],  
            ),
            Row(
              children: <Widget>[
                const Text('Belum punya akun?', style: TextStyle(fontSize: 14)),
                TextButton(
                  child: const Text(
                    'Daftar Akun',
                    style: TextStyle(
                      fontSize: 14,
                      decoration: TextDecoration.underline,
                      color: Colors.white,
                    )
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const CreateAccountPage()),
                    );
                  },
                )
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
                child: const Text(
                  "V1.0", 
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Colors.white
                  ),
                ),
              ),
            ),
          ],
        )
      )
    );
  }
}
