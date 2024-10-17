import 'package:work_calculator/data/data.dart';
import 'package:work_calculator/object.dart';
import 'package:work_calculator/cut_result.dart';

class Equipment {
  /*double width;
  double bladeCount;
  double extremeCutWidth;*/
  EquipmentData equipmentData;
  int _extraCutCount = 0;
  int _eCC = 0;
  int _extraForStripCutCount = 0;
  int _eFSCC = 0;

  Equipment(
      {/*required this.width,
      required this.bladeCount,
      required this.extremeCutWidth*/
      required this.equipmentData});

  void extraCutCount(double objWidth) {
    _extraCutCount = equipmentData.width ~/ objWidth;
    //print('_extraCutCount == $_extraCutCount');
    _eCC = _extraCutCount;
  }

  void extraForStripCutCount(double objWidth) {
    _extraForStripCutCount = equipmentData.width ~/ objWidth;
    //print('_extraForStripCutCount == $_extraForStripCutCount');
    _eFSCC = _extraForStripCutCount;
  }

  CutResult cutWidth(MyObject obj, double rectWidth) {
    var newWidth = 0.0;

    if (_extraCutCount > 0) {
      _extraCutCount--;
      //print("_extraCutCount == $_extraCutCount");
      newWidth = obj.width - rectWidth;
    } else {
      _extraCutCount = _eCC;
      newWidth = obj.width - rectWidth - equipmentData.extremeCutWidth;
    }

    print(
        'objWidth == ${obj.height}, rectWidth == $rectWidth, cutCount in newLength == $newWidth');

    var cutRes = CutResult(
      mainRest: MyObject(
        width: newWidth,
        height: obj.height,
        count: obj.count,
      ),
      strip: MyObject(
        width: rectWidth,
        height: obj.height,
        count: obj.count,
      ),
      trash: equipmentData.extremeCutWidth * obj.height,
    );

    return cutRes;
  }

  CutResult cutHeight(MyObject obj, double rectHeight) {
    var newHeight = 0.0; // newLength(obj.height, rectHeight);

    if (_extraForStripCutCount > 0) {
      _extraForStripCutCount--;
      //print("_extraForStripCutCount == $_extraForStripCutCount");
      newHeight = obj.height - rectHeight;
    } else {
      _extraForStripCutCount = _eFSCC;
      newHeight = obj.height - rectHeight - equipmentData.extremeCutWidth;
    }

    print(
        'objHeight == ${obj.height}, rectHeight == $rectHeight, cutCount in newLength == $newHeight');

    var cutRes = CutResult(
      mainRest: MyObject(
        width: obj.width,
        height: newHeight,
        count: obj.count,
      ),
      strip: MyObject(
        width: obj.width,
        height: rectHeight,
        count: obj.count,
      ),
      trash: equipmentData.extremeCutWidth * obj.width,
    );

    return cutRes;
  }
}
