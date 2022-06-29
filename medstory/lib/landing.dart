import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:pinput/pinput.dart';

import 'main.dart';

bool checkedCreateAcc = false;

class Login extends StatelessWidget {
  var usernameCtrl = TextEditingController();
  var passwordCtrl = TextEditingController();

  Login({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child:Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [   
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20.0),
              child: const Text('Selamat datang di',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 15,
                  color: Color(0xFF4169E1)
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
                  color: Color(0xFF4169E1)
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
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Nama Pengguna',
                ),
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
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
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
                    primary: const Color(0xFF4169E1),
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
                    color: Color(0xFF4169E1),
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
                  color: Color(0xFF808080)
                ),
              ),
            ),
          ),
        ],
      )
      
    );
  }
}

class WhitePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final height = size.height;
    final width = size.width;
    Paint paint = Paint();

    Path mainBackground = Path();
    mainBackground.addRect(Rect.fromLTRB(0, 0, width, height));
    paint.color = Colors.white;
    canvas.drawPath(mainBackground, paint);

    Path ovalPath = Path();
    ovalPath.lineTo(0, 120);

    ovalPath.quadraticBezierTo(
        width *0.55, height*0.34, width *0.7, height*0.33);

    ovalPath.quadraticBezierTo(width *0.8, height*0.33, width*0.88, height*0.31);

    ovalPath.lineTo(width*2, 0);

    ovalPath.close();

    paint.color = Color(0xFF4183D7);
    canvas.drawPath(ovalPath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}

class CreateAccountPage extends StatefulWidget{
  const CreateAccountPage({Key key}) : super(key: key);

  @override
  _CreateAccountPage createState()=> _CreateAccountPage();
}

class _CreateAccountPage extends State<CreateAccountPage>{
  CollectionReference users = FirebaseFirestore.instance.collection('pengguna');

  var usernameCtrl = TextEditingController();
  var emailCtrl = TextEditingController();
  var ponselCtrl = TextEditingController();
  var passwordCtrl = TextEditingController();
  var confirmpasswordCtrl = TextEditingController();

  var namaLengkapCtrl = TextEditingController();
  var nikCtrl = TextEditingController();
  var tempatLahirCtrl = TextEditingController();
  var tanggalLahirCtrl = TextEditingController();
  var alamatCtrl = TextEditingController();
  var pekerjaanCtrl = TextEditingController();
  int tinggiBadanCtrl;
  int beratBadanCtrl;

  int _index = 0;

  Future<void> insertAccount() {
      return users
        .add({
          'namaPengguna': usernameCtrl.text, 
          'email': emailCtrl.text, 
          'ponsel': ponselCtrl.text, 
          'password': passwordCtrl.text, 
          'namaLengkap': namaLengkapCtrl.text,
          'nik': nikCtrl.text,
          'tempatLahir': tempatLahirCtrl.text,
          'tanggalLahir': '17-08-1945',
          'alamat': alamatCtrl.text,
          'pekerjaan': pekerjaanCtrl.text,
          'tinggiBadan': tinggiBadanCtrl,
          'beratBadan': beratBadanCtrl,
        })
        .then((value) => print("Akun berhasil didaftar"))
        .catchError((error) => print("Failed to add user: $error"));
    }

  Widget buildPinPut() {
    return Pinput(
      onCompleted: (pin) => print(pin),
    );
  }

  Widget buildProfileImg(){
    if(_index == 2){
      return SizedBox(
        height: MediaQuery.of(context).size.height* 0.21,
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                transform: Matrix4.translationValues(30.0, 0.0, 0.0),
                width: MediaQuery.of(context).size.width* 0.4, 
                child: Text("Selesaikan pendaftaran sebelum waktu berikut", style: TextStyle(color: Colors.white))
              )
            )
          ],
        )
      );
    } else {
      return Stack(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(right: 20.0),
            alignment: Alignment.topRight,
            child: ClipRRect(
              child: Image.asset(
                'assets/icon/DefaultProfile.png', width: 180),
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
            transform: Matrix4.translationValues(120.0, 120.0, 0.0),                    
            alignment: Alignment.bottomRight,
            height: 60,
            width: 60,
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
            child: ClipRRect(
              child: Image.asset(
                'assets/icon/Add Image.png', width: 40),
            ),
            decoration: BoxDecoration(
              color: const Color(0xFF4183D7),
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
        ]
      );
    }
  }

  final defaultPinTheme = PinTheme(
    width: 60,
    height: 60,
    textStyle: const TextStyle(fontSize: 20, color: Color(0xFF4183D7), fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      border: Border.all(color: const Color.fromRGBO(234, 239, 243, 1)),
      borderRadius: BorderRadius.circular(20),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  CustomPaint(
        painter: WhitePainter(),
        child : Container(
          margin: const EdgeInsets.only(top: 80.0),
          height: MediaQuery.of(context).size.height,
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [ 
              Row(  
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 20.0),
                    transform: Matrix4.translationValues(0.0, -60.0, 0.0),
                    alignment: Alignment.topLeft,
                    child: Ink(
                      decoration: const ShapeDecoration(
                        color: Colors.white,
                        shape: CircleBorder(),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back, size: 30),
                        color: Colors.blueAccent,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.white,
                    )
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width*0.3),
                  buildProfileImg(),
                ]
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: const Text('Daftar',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      color: Color(0xFF4169E1)
                    ),
                  ),
                )
              ),
              Flexible(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height*0.65,
                  child: Stepper(
                    type: StepperType.horizontal,
                    physics : const ClampingScrollPhysics(),
                    currentStep: _index,
                    onStepCancel: () {
                      if (_index > 0) {
                        setState(() {
                          _index -= 1;
                        });
                      }
                      
                    },
                    onStepContinue: () {
                      if (_index <= 1) {
                        setState(() {
                          _index += 1;
                        });
                      } 
                    },
                    onStepTapped: (int index) {
                      setState(() {
                        _index = index;
                      });
                    },
                    steps: <Step>[
                      Step(
                        title: const Text('Data Akun'),
                        content: Column(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 10.0),
                                child: const Text('Data Akun',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                    color: Color(0xFF4169E1)
                                  ),
                                )
                              )
                            ),

                            //Username section.
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 7.0, top: 5),
                                child: TextFormField(
                                  controller: usernameCtrl,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Nama Pengguna',
                                  ),
                                ),
                              ),
                            ),

                            //Email section.
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 7.0),
                                child: TextFormField(
                                  controller: emailCtrl,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Email (example@gmail.com)',
                                  ),
                                ),
                              ),
                            ),

                            //Email section.
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 7.0),
                                child: TextFormField(
                                  controller: ponselCtrl,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Ponsel',
                                  ),
                                ),
                              ),
                            ),

                            //Password section.
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 7.0),
                                child: TextFormField(
                                  obscureText: true,
                                  controller: passwordCtrl,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Password',
                                  ),
                                ),
                              ),
                            ),

                            //Confirmation Password section.
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 7.0),
                                child: TextFormField(
                                  obscureText: true,
                                  // controller: confirmpasswordCtrl,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Konfirmasi Password',
                                  ),
                                ),
                              ),
                            ),

                            Row(
                              children:[
                                Container(
                                  margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                                  child: const Icon(
                                    Icons.info,
                                    color: Color(0xFF808080),
                                    size: 24.0,
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width* 0.7,
                                  margin: const EdgeInsets.symmetric(vertical: 5.0),
                                  child: const Text(
                                    "Password must have min 8 character, Have 1 capital and 1 number.", 
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 13,
                                      color: Color(0xFF212121)
                                    ),
                                  ),
                                ),
                                
                              ]
                            ),

                            Row(
                              children:  [
                                const Align(
                                  child: CheckboxWidget(),
                                ),  
                                SizedBox(
                                  width: MediaQuery.of(context).size.width* 0.75,
                                  child: const Text(
                                    "Saya menyetujui segala Persyaratan dan Ketentuan yang ditetapkan oleh aplikasi. Dan saya akan mengisi data dengan sebenar-benarnya.", 
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Color(0xFF4169E1),
                                    ),
                                  ),
                                ),
                                
                              ]       
                            ),
                            
                          ],
                        ),
                      ),

                      Step(
                        title: const Text('Data Diri'),
                        content: Column(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 10.0),
                                child: const Text('Data Diri',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                    color: Color(0xFF4169E1)
                                  ),
                                )
                              )
                            ),

                            //Nama Lengkap section.
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 7.0),
                                child: TextFormField(
                                  controller: namaLengkapCtrl,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Nama Lengkap',
                                  ),
                                ),
                              ),
                            ),

                            //NIK section.
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 7.0),
                                child: TextFormField(
                                  controller: nikCtrl,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'NIK',
                                  ),
                                ),
                              ),
                            ),

                            //Tempat lahir section.
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 7.0),
                                child: TextFormField(
                                  controller: tempatLahirCtrl,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Tempat Lahir',
                                  ),
                                ),
                              ),
                            ),

                            //Tanggal lahir section.
                            //Not finished
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 7.0),
                                child: TextFormField(
                                  controller: tanggalLahirCtrl,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Tanggal Lahir',
                                  ),
                                ),
                              ),
                            ),

                            //Alamat section.
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 7.0),
                                child: TextFormField(
                                  controller: alamatCtrl,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Alamat',
                                  ),
                                ),
                              ),
                            ),

                            //Pekerjaan section.
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 12.0),
                                child: TextFormField(
                                  controller: pekerjaanCtrl,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Pekerjaan',
                                  ),
                                ),
                              ),
                            ),

                            Row(
                              children: [
                                SizedBox(
                                  width:140,
                                  height: 50,
                                  child: SpinBox(
                                    min: 1, max: 220,
                                    spacing: 1,
                                    textStyle: const TextStyle(
                                      fontSize: 16.0,
                                    ),
                                    onChanged: (value) => tinggiBadanCtrl = value.toInt(),
                                    decoration: const InputDecoration(labelText: 'Tinggi Badan (Cm)'),
                                  ),
                                ),
                                const SizedBox(width:10),
                                SizedBox(
                                  width:140,
                                  height: 50,
                                  child: SpinBox(
                                    min: 1, max: 220,
                                    spacing: 1,
                                    textStyle: const TextStyle(
                                      fontSize: 16.0,
                                    ),
                                    onChanged: (value) => beratBadanCtrl = value.toInt(),
                                    decoration: const InputDecoration(labelText: 'Berat Badan (Kg)'),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      Step(
                        title: const Text('Verifikasi'),
                        content: Column(
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Container(
                                  margin: const EdgeInsets.only(bottom: 10.0),
                                  child: const Text('Verifikasi',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                      color: Color(0xFF4169E1)
                                    ),
                                  )
                                )
                              ),

                              Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  margin: const EdgeInsets.only(bottom: 7.0),
                                  child: const Text("Kami telah mengirim kode OTP ke email Anda. Mohon untuk mengisi kolom berikut sesuai kode yang telah Kami kirim", 
                                  style: TextStyle(color: Colors.blueAccent))
                                ),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Container(
                                  margin: const EdgeInsets.symmetric(vertical: 40.0),
                                    child: buildPinPut(),
                                )
                              ),
                              Row(
                                children:[
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width*0.4,
                                    child: const Text("Belum menerima kode? Coba metode lain", 
                                    style: TextStyle(color: Color(0xFF808080))),
                                  ), 
                                  SizedBox(width: MediaQuery.of(context).size.width*0.07),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width*0.3,
                                    child: OutlinedButton(
                                      onPressed: () {
                                          // Respond to button press
                                      },
                                      child: const Text("Via SMS"),
                                    )
                                  )
                                ]
                              ),
                              Row(
                                children:[
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width*0.4,
                                    child: const Text("Atau, kirim ulang", 
                                    style: TextStyle(color: Color(0xFF808080))),
                                  ), 
                                  SizedBox(width: MediaQuery.of(context).size.width*0.07),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width*0.3,
                                    child: OutlinedButton(
                                      onPressed: () {
                                          // Respond to button press
                                      },
                                      child: const Text("Via Email"),
                                    )
                                  )
                                ]
                              ),
                              ElevatedButton(
                                onPressed: () async{
                                  int i = 0;
                                  FirebaseFirestore.instance
                                  .collection('pengguna')
                                  .get()
                                  .then((QuerySnapshot querySnapshot) {
                                      querySnapshot.docs.forEach((doc) {
                                        if(doc["namaPengguna"] == usernameCtrl.text){
                                          i++;
                                        }
                                      });
                                      if(i == 0){
                                        passUsername = usernameCtrl.text;
                                        insertAccount();
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
                                                    const Text('Username telah terdaftar'),
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
                                child: const Text("Daftar"),
                              )

                          ],
                        ),
                      ),
                    ],
                  )
                )
                
              )
            ],
          )
          )
        
      )
    );
  }
}

class CheckboxWidget extends StatefulWidget {
  const CheckboxWidget({Key key}) : super(key: key);

  @override
  State<CheckboxWidget> createState() => _MyStatefulWidgetState3();
}

class _MyStatefulWidgetState3 extends State<CheckboxWidget> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.white;
      }
      return const Color(0xFF4169E1);
    }

    return Checkbox(
      checkColor: Colors.white,
      fillColor: MaterialStateProperty.resolveWith(getColor),
      value: isChecked,
      onChanged: (bool value) {
        setState(() {
          isChecked = value;
          checkedCreateAcc = isChecked;
        });
      },
    );
  }
}