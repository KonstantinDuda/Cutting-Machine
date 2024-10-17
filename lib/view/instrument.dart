import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_calculator/bloc/provider_bloc.dart';

import '../bloc/calculate_bloc.dart';
import '../data/data.dart';
import '../event_state/calculate_es.dart';

class InstrumentView extends StatefulWidget {
  const InstrumentView();

  @override
  _InstrumentState createState() => _InstrumentState();
}

class _InstrumentState extends State<InstrumentView> {
  List<double> list = [38.0, 8.0, 0.15, 120.0, 100.0, 0.0, 0.0, 100];
  List<double> newList = [];

  @override
  Widget build(BuildContext context) {
    newList.addAll(list);
    //print(newList);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text('Details'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const Text(
                'Обладнання',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              //Text('Ширина робочої поверхні обладнання:'),
              _pare('Ширина робочої поверхні обладнання:',
                  0), // instrumentWidth),
              _pare('Кількість лез:', 1), //instrumentNumberOfBlades),
              _pare('Ширина відрізної-крайньої полоси', 2),
              const Text(
                'Пластик',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const Text('Розміри вихідного листа'),
              _pare('Висота:', 3), //mainPlasticHeight),
              _pare('Ширина:', 4), //mainPlasticWidth),
              const Text('Розміри необхідної деталі'),
              _pare('Висота:', 5), // plasticHeight),
              _pare('Ширина:', 6), //plasticWidth),
              _pare('Необхідна кількість деталей:', 7),
            ],
          ),
        ),
        floatingActionButton: TextButton(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(Colors.blue),
            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
              const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
            ),
          ),
          onPressed: () {
            print('instrumentWidth == ${newList[0]}');
            print('instrumentNumberOfBlades == ${newList[1]}');
            print('extrimeCutWidth == ${newList[2]}');
            print('mainPlasticHeight == ${newList[3]}');
            print('mainPlasticWidth == ${newList[4]}');
            print('plasticHeight == ${newList[5]}');
            print('plasticWidth == ${newList[6]}');
            print('plasticCount == ${newList[7]}');

            Data dataToSend = Data(
              equipmentData: EquipmentData(
                  width: newList[0],
                  bladeCount: newList[1].toInt(),
                  extremeCutWidth: newList[2]),
              /*instrumentWidth: newList[0],
              instrumentNumberOfBlades: newList[1],
              extrimeCutWidth: newList[2],*/
              mainPlasticHeight: newList[3],
              mainPlasticWidth: newList[4],
              plasticHeight: newList[5],
              plasticWidth: newList[6],
              plasticCount: newList[7].toInt(),
            );

            //print(dataToSend);

            context
                .read<CalculateBloc>()
                .add(CalculateRequestEvent(dataToSend));
            context.read<ProviderBloc>().add(LoadingEvent(dataToSend));
          },
          child: const Text(
            'Порахувати',
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
    );
  }

  _pare(String title, int listIndex) {
    var textController = TextEditingController(text: '');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          textAlign: TextAlign.left,
        ),
        TextField(
          controller: textController,
          keyboardType: TextInputType.number,
          style: const TextStyle(fontSize: 16),
          decoration: InputDecoration(
              hintText: list[listIndex].toString(),
              hintStyle: const TextStyle(color: Colors.grey)),
          onChanged: (value) {
            print('enterText == $value');
            double doubleValue = _toDouble(value);
            if (doubleValue >= 0.0) {
              newList[listIndex] = doubleValue;
            } else {
              print('doubleValue < 0.0');
              newList[listIndex] = list[listIndex];
            }
          },
        )
      ],
    );
  }

  double _toDouble(String text) {
    double? value = double.tryParse(text);
    if (value != null) {
      if (value.runtimeType == double) {
        print("value in _toDouble is DOUBLE");
        return value;
      }
      return -1.0;
    }
    return -1.0;
  }
}
