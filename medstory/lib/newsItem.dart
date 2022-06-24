import 'package:flutter/material.dart';

class Item1 extends StatelessWidget {
  const Item1({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        decoration: BoxDecoration(
          borderRadius : BorderRadius.circular(10),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.3, 1],
            colors: [Color(0xff22A7F0),Color(0xff22A7F0),]
          ),
        ),
        child: 
          Align(
            alignment: Alignment.bottomLeft,
            child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                transform: Matrix4.translationValues(0.0, -5.0, 0.0),
                child: Image.asset(
                  'assets/images/News1.jpeg',
                  height: 150.0,
                  width: 310,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                transform: Matrix4.translationValues(0.0, -2.0, 0.0),
                child: const Text(
                  "Resmi! Kasus Aktif Covid-19 di Indonesia Kalahkan India",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500
                  )
                ),
              ),
            ],
          ),
        )
      ),
      onTap: () {
        print("test-1");
      },
    );
  }
}

class Item2 extends StatelessWidget {
  const Item2({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        decoration: BoxDecoration(
          borderRadius : BorderRadius.circular(10),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.3, 1],
            colors: [Color(0xff22A7F0),Color(0xff22A7F0),]
          ),
        ),
        child: 
          Align(
            alignment: Alignment.bottomLeft,
            child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                transform: Matrix4.translationValues(0.0, -5.0, 0.0),
                child: Image.asset(
                  'assets/images/News2.jpeg',
                  height: 150.0,
                  width: 310,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                transform: Matrix4.translationValues(0.0, -2.0, 0.0),
                child: const Text(
                  "Menkes: Vaksin Moderna untuk Nakes karena Stok Terbatas",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500
                  )
                ),
              ),
            ],
          ),
        )
      ),
      onTap: () {
        print("test-2");
      },
    );
  }
}

class Item3 extends StatelessWidget {
  const Item3({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        decoration: BoxDecoration(
          borderRadius : BorderRadius.circular(10),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.3, 1],
            colors: [Color(0xff22A7F0),Color(0xff22A7F0),]
          ),
        ),
        child: 
          Align(
            alignment: Alignment.bottomLeft,
            child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                transform: Matrix4.translationValues(0.0, -5.0, 0.0),
                child: Image.asset(
                  'assets/images/News3.jpeg',
                  height: 150.0,
                  width: 310,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                transform: Matrix4.translationValues(0.0, -2.0, 0.0),
                child: const Text(
                  "Susul Moderna, Vaksin Pfizer Sebentar Lagi Dapat Izin di RI",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500
                  )
                ),
              ),
            ],
          ),
        )
      ),
      onTap: () {
        print("test-3");
      },
    );
  }
}

class Item4 extends StatelessWidget {
  const Item4({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell( 
      child: Container(
        decoration: BoxDecoration(
          borderRadius : BorderRadius.circular(10),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.3, 1],
            colors: [Color(0xff22A7F0),Color(0xff22A7F0),]
          ),
        ),
        child: 
          Align(
            alignment: Alignment.bottomLeft,
            child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                transform: Matrix4.translationValues(0.0, -5.0, 0.0),
                child: Image.asset(
                  'assets/images/News4.jpeg',
                  height: 150.0,
                  width: 310,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                transform: Matrix4.translationValues(0.0, -2.0, 0.0),
                child: const Text(
                  "Cara mengatasi penyakit maag agar tidak kambuh lagi",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500
                  )
                ),
              ),
            ],
          ),
        )
      ),
      onTap: () {
        print("test-4");
      },
    );
  }
}