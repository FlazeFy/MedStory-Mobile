import 'package:flutter/material.dart';

final List<String> imgList = [
  'assets/images/News1.jpeg',
  'assets/images/News2.jpeg',
  'assets/images/News3.jpeg',
  'assets/images/News4.jpeg',
];

final List<String> titleList = [
  'Resmi! Kasus Aktif Covid-19 di Indonesia Kalahkan India',
  'Menkes: Vaksin Moderna untuk Nakes karena Stok Terbatas',
  'Susul Moderna, Vaksin Pfizer Sebentar Lagi Dapat Izin di RI',
  'Cara mengatasi penyakit maag agar tidak kambuh lagi',
];

final List<Widget> imageSliders = imgList
  .map((item) => Container(
    margin: const EdgeInsets.all(5.0),
    child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(5.0)),
        child: Stack(
          children: <Widget>[
            Image.asset(item, fit: BoxFit.cover, width: 1000.0),
            Positioned(
              bottom: 0.0,
              left: 0.0,
              right: 0.0,
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(200, 0, 0, 0),
                      Color.fromARGB(0, 0, 0, 0)
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 20.0),
                child: Text(
                  titleList[imgList.indexOf(item)].toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        )),
  ))
.toList();

