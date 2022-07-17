import 'package:flutter/material.dart';
import 'package:medstory/widgets/custombg.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class StatisticsPage extends StatefulWidget{
  const StatisticsPage({Key key}) : super(key: key);

  @override
  _StatisticsPage createState()=> _StatisticsPage();
}

class _StatisticsPage extends State<StatisticsPage>{
   List<_DisData> data = [
    _DisData('Jan', 35),
    _DisData('Feb', 28),
    _DisData('Mar', 34),
    _DisData('Apr', 32),
    _DisData('May', 40)
  ];
  List<_PieData> data2 = [
    _PieData('Vaksin & Imunisasi', 10),
    _PieData('Penyakit Dalam', 10),
    _PieData('Penyakit Menular', 10),
    _PieData('Kulit & Kelamin', 10),
    _PieData('Otot & Saraf', 10),
    _PieData('THT & Mata', 10),
    _PieData('Penyakit Lansia', 10),
    _PieData('Obat-Obatan', 5),
    _PieData('Gaya Hidup Sehat', 5),
    _PieData('Kandungan & Bedah', 5),
    _PieData('Gigi', 5),
    _PieData('Anak', 10)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomPaint(
        painter: CurvedPainter3(),
        child : Container(
          margin: const EdgeInsets.only(top: 80.0),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [ 
              Align(
                child: Container(
                  margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),
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
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: ListView(
                    padding: const EdgeInsets.only(top: 0),
                    children: [
                      Container(
                        margin: const EdgeInsets.all(10),
                        child: SfCartesianChart(
                          primaryXAxis: CategoryAxis(),
                          title: ChartTitle(text: 'Total Diskusi per bulan 2022'),
                          legend: Legend(isVisible: true),
                          tooltipBehavior: TooltipBehavior(enable: true),
                          series: <ChartSeries<_DisData, String>>[
                            LineSeries<_DisData, String>(
                              dataSource: data,
                              xValueMapper: (_DisData sales, _) => sales.year,
                              yValueMapper: (_DisData sales, _) => sales.sales,
                              name: 'Diskusi',
                              dataLabelSettings: const DataLabelSettings(isVisible: true))
                          ]
                        ),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        )
                      ),
                      Container(
                        margin: const EdgeInsets.all(10),
                        child: SfCircularChart(
                          title: ChartTitle(text: 'Kategori Diskusi'),
                          legend: Legend(isVisible: true),
                          series: <PieSeries<_PieData, String>>[
                            PieSeries<_PieData, String>(
                              explode: true,
                              explodeIndex: 0,
                              dataSource: data2,
                              xValueMapper: (_PieData data, _) => data.xData,
                              yValueMapper: (_PieData data, _) => data.yData,
                              dataLabelMapper: (_PieData data, _) => data.text,
                              dataLabelSettings: const DataLabelSettings(isVisible: true)),
                          ]
                        ),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        )
                      ),
                      
                    ],
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
}

class _DisData {
  _DisData(this.year, this.sales);

  final String year;
  final double sales;
}
class _PieData {
 _PieData(this.xData, this.yData, [this.text]);
 final String xData;
 final num yData;
 final String text;
}