import 'package:work_calculator/object.dart';
import 'package:work_calculator/cut_result.dart';

class Equipment {
  double width;
  double bladeCount;
  double extremeCut;

  Equipment(
      {required this.width,
      required this.bladeCount,
      required this.extremeCut});

  CutResult cutWidth(MyObject obj, double rectWidth) {
    /*var objCount = obj.width ~/ width;
    List<MyObject> list = [];
    for (var i = 0; i < objCount; i++) {
      list.add(
          MyObject(width: rectWidth, height: obj.height, count: obj.count));
    }
    var mainMO = MyObject(
        width: obj.width - (rectWidth * objCount) - extremeCut,
        height: obj.height,
        count: obj.count);
    return CutResult(strip: list, mainRest: mainMO);*/
    return CutResult(
      mainRest: MyObject(
        width: obj.width -
            rectWidth -
            extremeCut, // TODO відрізає на кожну корисну полоску
        height: obj.height,
        count: obj.count,
      ),
      strip: MyObject(
        width: rectWidth,
        height: obj.height,
        count: obj.count,
      ),
      trash: extremeCut * obj.height,
    );
  }

  CutResult cutHeight(MyObject obj, double rectHeight) {
    /*var objCount = obj.height ~/ width;
    List<MyObject> list = [];
    for (var i = 0; i < objCount; i++) {
      list.add(
          MyObject(width: obj.width, height: rectHeight, count: obj.count));
    }
    var mainMO = MyObject(
        width: obj.width,
        height: obj.height - (rectHeight * objCount) - extremeCut,
        count: obj.count);
    return CutResult(strip: list, mainRest: mainMO);*/

    return CutResult(
      mainRest: MyObject(
        width: obj.width,
        height: obj.height -
            rectHeight -
            extremeCut, // TODO відрізає на кожну корисну полоску
        count: obj.count,
      ),
      strip: MyObject(
        width: obj.width,
        height: rectHeight,
        count: obj.count,
      ),
      trash: extremeCut * obj.width,
    );
  }
}
