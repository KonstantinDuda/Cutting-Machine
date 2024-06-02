import 'package:flutter/material.dart';
import 'package:work_calculator/equipment.dart';
import 'package:work_calculator/result.dart';

import 'object.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  Equipment myEquipment = Equipment(width: 38, bladeCount: 8, extremeCut: 0.1);

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
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('mylist == result'),
        ),
      ),
    );
  }

  calculator() {
    var extraRes = extra(mainObj, oneObj);
    mylistRes = mylist;
    print('extraRes == $extraRes');
    print('myListRes.length == ${mylistRes.length}');
    mylist.clear();
    print('myList after clear myList.length == ${mylist.length}');
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
    if (main.width < rect.width + myEquipment.extremeCut) {
      return Result(usefull: 0, trash: main.square());
    }
    if (mylist.length == oneObj.count) {
      return Result(usefull: main.square(), trash: 0);
    }

    var cutResult = myEquipment.cutWidth(main, rect.width);

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
    if (strip.height < rect.height + myEquipment.extremeCut) {
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
/*
  newCalculate() {
    mylist.add(oneObj);

    for (var i = 0; i < mylist.length; i++) {
      findRemainder(mainObj.width, mylist[i]);
    }
  }

  findRemainder(double main, MyObject obj) {
    // TODO Потрібна коректніша назва і окремі функції які будуть рахувати по ширині і по висоті обьєкта
    objCount = main ~/
        obj.height; // Скільки приблизно поміститься одиниць обьєктів на ширину головного листа
    var nededStripCount = obj.count /
        objCount; // кількість необхідних полос щоб зрозуміти чи мені вистачить одного головного листа на всі
    print(
        "Вам потрібно $nededStripCount смуг щоб зробити необхідну кількість обьєктів");
    var extremeCuts =
        objCount ~/ // Рахуємо скільки зріже залишкових полосок в залежності від обладнання Кількість смуг за один прохід
            calculateEquipment(main,
                obj.height) * // Ділимо кількість обьєктів на кількість полос за прохід, без залишка (17:5=3)*0,1=0,3
            myEquipment.extremeCut; //  Ширина зрізаних залишкових полос разом
    if (extremeCuts != // TODO doubles краще не порівнювати на рівність між собою, краще на більше менше або відняти від одного інше
        objCount / // Якщо ширина залишків не дорівнює кількості обьєктів ділених на
            calculateEquipment(main,
                obj.height) * // Кількість смуг за один прохід помножених на Ширину залишкової полоси
            myEquipment.extremeCut) {
      // (17:5=3,4)*0,1=0,34 != 0,3 Отже ми зробимо більше ніж 3 проходи,
      extremeCuts = extremeCuts +
          myEquipment
              .extremeCut; // За додатковий прохід, не залежно від кількості полос що ми відріжемо ми зріжемо ще залишкову полосу
    }
    var extremeCutsCorrect = double.parse(extremeCuts.toStringAsFixed(3));
    double rem = remainder(main, obj.height,
        extremeCutsCorrect); // Порахуємо ширину що залишиться від ширини чи висоти головного листа

    print(
        "mainX~/objCount == $objCount. Залишиться $rem см"); // TODO Тепер треба порахувати скільки залишиться з іншої сторони цього листа

    if (objCount < nededStripCount) {
      // TODO Шукати найменшу ширину залишків
    } else {
      // TODO Шукати найбільшу ширину залишків
    }
  }

  calculateEquipment(double mainX, double objX) {
    double oneOperation = (myEquipment.width ~/ objX).toDouble();
    if (oneOperation > myEquipment.bladeCount) {
      oneOperation = myEquipment.bladeCount - 1;
    }
    print("За один прохід ми можемо відрізати $oneOperation смуг");
    return oneOperation;
  }

  remainder(double mainX, double objHeight, double extremeCuts) {
    var rem = mainX - ((objCount.toDouble()) * objHeight + extremeCuts);

    //print(" func remainder, rem == $result");
    if (rem < 0.0) {
      objCount -= 1;
      //print("Now objCount == $objCount");
      rem = remainder(mainX, /* objCount,*/ objHeight, extremeCuts);
      //var result = double.parse(rem.toStringAsFixed(3));
      //print("func remainder, if(rem < 0,0) == $newRem");
      //return result;
    }
    var result = double.parse(rem.toStringAsFixed(3));
    return result;
  }

  myCompare(double pOne, double pTwo) {
    if (pOne < pTwo) {
      return pOne;
    } else {
      return pTwo;
    }
  }*/
}
