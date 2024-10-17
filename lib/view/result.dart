import 'package:flutter/material.dart';
import 'package:work_calculator/view/result_paint.dart';

import '../data/data.dart';

class ResultView extends StatefulWidget {
  const ResultView({super.key});

  @override
  State<ResultView> createState() => _ResultViewState();
}

class _ResultViewState extends State<ResultView> {
  final ResultData result = ResultData(
      myData: Data(
          equipmentData:
              EquipmentData(width: 38.0, bladeCount: 8, extremeCutWidth: 0.15),
          mainPlasticHeight: 100.0,
          mainPlasticWidth: 120.0,
          plasticHeight: 10,
          plasticWidth: 12,
          plasticCount: 70),
      stripCount: 9,
      rectangleRemainderHeight: 10);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text('Result'),
        ),
        //body: Text('Animation')));
        body: Row(
          children: [
            GestureDetector(
              child: Container(
                  color: Colors.white,
                  height: MediaQuery.of(context).size.height - 100,
                  width: 30,
                  child: const Center(child: Icon(Icons.arrow_back))),
              onTap: () {
                print('Tap on back');
              },
            ),
            Expanded(
              child: /*Center(
                child: PlayAnimationBuilder<double>(
                  tween: Tween(begin: 50.0, end: 200.0),
                  duration: const Duration(seconds: 5),
                  builder: (context, value, _) {
                    return Container(
                      width: value,
                      height: value,
                      color: Colors.blue,
                    );
                  },
                ),
              ),*/
                  CustomPaint(
                painter: ResultPaint(result),
                child: Container(),
              ),
            ),
            GestureDetector(
              child: Container(
                  color: Colors.white,
                  height: MediaQuery.of(context).size.height - 100,
                  width: 30,
                  child: const Center(child: Icon(Icons.arrow_forward))),
              onTap: () {
                print('Tap on forward');
              },
            ),
          ],
        ),
      ),
    );
  }
}
