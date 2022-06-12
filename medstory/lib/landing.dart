import 'package:flutter/material.dart';

import 'main.dart';

class Login extends StatelessWidget {
  var usernameCtrl = TextEditingController();
  var passwordCtrl = TextEditingController();

  Login({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
              child: Text('Selamat datang di',
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
              child: Text('MedStory',
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NavBar(pass_usernameNav: 'flazefy', pass_id_userNav: 'RPxpwFtMphTZCEZnxUIB')),
                    );
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