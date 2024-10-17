import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:work_calculator/bloc/calculate_bloc.dart';
import 'package:work_calculator/bloc/observer.dart';
import 'package:work_calculator/bloc/provider_bloc.dart';
//import 'package:work_calculator/equipment.dart';
//import 'package:work_calculator/result.dart';
import 'package:work_calculator/view/instrument.dart';

//import 'object.dart';
import 'view/loading.dart';
import 'view/result.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();
  runApp(BlocProvider(
    create: (context) => ProviderBloc(),
    child: App(),
  ));

  //runApp(MainApp());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CalculateBloc(),
      child: MaterialApp(
        home: BlocBuilder<ProviderBloc, ProviderState>(builder: (_, state) {
          if (state is InstrumentState) {
            print('InstrumentState');
            return const InstrumentView();
          } else if (state is LoadingState) {
            print('Loading State');
            return const LoadingView(/*state.data*/);
          } else if (state is ResultState) {
            print('Result State');
            return const ResultView();
          } else {
            print('else');
            return const InstrumentView();
          }
        }),
      ),
    );
  }
}

/*class MainApp extends StatelessWidget {
  MainApp({super.key});

  Equipment myEquipment = Equipment(width: 38, bladeCount: 8, extremeCutWidth: 0.1);

  MyObject mainObj = MyObject(width: 120, height: 100, count: 1);

  var objCount = 100;

  var oneObj = MyObject(width: 9, height: 10, count: 30);

  List<MyObject> mylist = [];
  List<MyObject> mylistRes = [];

  @override
  Widget build(BuildContext context) {
    //newCalculate();
    /*var result = extra(mainObj, oneObj);
    print('extra == $result');
    print('myList.length == ${mylist.length}');*/
    calculator();
    return InstrumentView(); /*const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('mylist == result'),
        ),
      ),
    );*/
  }

  calculator() {
    myEquipment.extraCutCount(oneObj.width);
    var extraRes = extra(mainObj, oneObj);
    mylistRes = mylist;
    print('extraRes == $extraRes');
    print('myListRes.length == ${mylistRes.length}');
    mylist.clear();
    print('myList after clear myList.length == ${mylist.length}');
    myEquipment.extraCutCount(oneObj.height);
    var extraRotateRes = extra(mainObj.rotate(), oneObj);
    print('extraRotateRes == $extraRotateRes');
    print('myListRotateRes.length == ${mylist.length}');
    if (extraRes.trash < extraRotateRes.trash) {
      print("extra res is better than extra res rotate. return mylistRes");
    } else {
      print("extra res is worst than extra res rotate. return mylist");
    }
  }

  Result extra(MyObject main, MyObject rect) {
    //print('extra cut');
    if (main.width < rect.width + myEquipment.extremeCutWidth) {
      return Result(usefull: 0, trash: main.square());
    }
    if (mylist.length == oneObj.count) {
      return Result(usefull: main.square(), trash: 0);
    }

    var cutResult = myEquipment.cutWidth(main, rect.width);

    myEquipment.extraForStripCutCount(oneObj.height);
    var eFS = extraForStrip(
      cutResult.strip,
      rect,
    );
    var a = extra(cutResult.mainRest, rect);
    return Result(
        usefull: eFS.usefull + a.usefull,
        trash: eFS.trash + a.trash + cutResult.trash);
  }

  Result extraForStrip(MyObject strip, MyObject rect) {
    //print('     extra for strip');
    if (strip.height < rect.height + myEquipment.extremeCutWidth) {
      return Result(usefull: 0, trash: strip.square());
    }
    if (mylist.length == oneObj.count) {
      return Result(usefull: strip.square(), trash: 0);
    }

    var cutResult = myEquipment.cutHeight(strip, rect.height);
    mylist.add(cutResult.strip);

    var a = extraForStrip(cutResult.mainRest, rect);
    return Result(usefull: a.usefull, trash: a.trash + cutResult.trash);
  }

//
//
}*/
