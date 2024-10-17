import 'package:flutter/material.dart';
import 'package:work_calculator/data/data.dart';

class ResultPaint extends CustomPainter {
  late Paint _paint;
  ResultData resData;

  ResultPaint(this.resData) {
    _paint = Paint()
      ..color = Colors.blue
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 10;
  }

  @override
  void paint(Canvas canvas, Size size) {
    List<Rect> rects = [];
    var stripIndexes = [];
    var extremeCutIndexes = [];
    var remainderStripIndex = 0;
    var remainderRectangleIndex = 0;

    var paintStripCount = 0.0;
    var top = 25.0;

    var oneCutCount =
        (resData.myData.equipmentData.width / resData.myData.plasticWidth)
            .toInt();
    if (oneCutCount >= resData.myData.equipmentData.bladeCount) {
      oneCutCount = resData.myData.equipmentData.bladeCount - 1;
    }
    var cutCounter = oneCutCount;
    print('resData.stripCount + resData.extremeCutStripCount + 1 == '
        '${resData.stripCount + resData.extremeCutStripCount + 1}');

    if (resData.myData.plasticWidth > 0.0 &&
        resData.myData.plasticHeight > 0.0) {
      for (var i = 0;
          i < resData.stripCount + resData.extremeCutStripCount + 1;
          i++) {
        print('i == $i');
        if (rects.isEmpty) {
          print('rect.isEmpty');
          rects.add(Rect.fromLTWH(
              resData.myData.mainPlasticWidth -
                  resData.myData.equipmentData.extremeCutWidth,
              top,
              resData.myData.equipmentData.extremeCutWidth,
              resData.myData.mainPlasticHeight));
          _paint.style = PaintingStyle.fill;
          canvas.drawRect(rects[i], _paint);

          extremeCutIndexes.add(i);
        }
        if (cutCounter <= oneCutCount &&
            cutCounter > 0 &&
            paintStripCount < resData.stripCount) {
          print(' paintStripCount == $paintStripCount <?');
          print('resData.stripCount == ${resData.stripCount}');
          var rectsWidth = _widthCalculate(rects);
          rects.add(Rect.fromLTWH(
              resData.myData.mainPlasticWidth -
                  rectsWidth -
                  resData.myData.plasticWidth,
              top,
              resData.myData.plasticWidth,
              resData.myData.mainPlasticHeight));

          _paint.style = PaintingStyle.fill;
          canvas.drawRect(rects[i], _paint);

          paintStripCount = paintStripCount + 1.0;
          cutCounter--;
          print('cutCounter == $cutCounter');

          stripIndexes.add(i);
        } else if (cutCounter == 0) {
          // TODO add якщо полосок менше ніж має бути
          print('cutCounter == 0');
          var rectsWidth = _widthCalculate(rects);
          rects.add(Rect.fromLTWH(
              resData.myData.mainPlasticWidth -
                  rectsWidth -
                  resData.myData.equipmentData.extremeCutWidth,
              top,
              resData.myData.equipmentData.extremeCutWidth,
              resData.myData.mainPlasticHeight));

          _paint.style = PaintingStyle.fill;
          canvas.drawRect(rects[i], _paint);

          cutCounter = oneCutCount;

          extremeCutIndexes.add(i);
        } else if (_widthCalculate(rects) < resData.myData.mainPlasticWidth) {
          var remainder =
              resData.myData.mainPlasticWidth - _widthCalculate(rects);
          var newRect = Rect.fromLTWH(
              0, top, remainder, resData.myData.mainPlasticHeight);
          var newPaint = Paint()
            ..color = Colors.black
            ..strokeCap = StrokeCap.round
            ..strokeWidth = 30;
          canvas.drawRect(newRect, newPaint);
          print('Something else in for. remainder == $remainder');
        }

        // rects.add(Rect.fromLTWH(
        //   25, 25, resData.stripRemainderWidth, resData.stripRemainderHeight));
      }
      print('var stripIndexes length == ${stripIndexes.length}');
      print('var extremeCutIndexes length == ${extremeCutIndexes.length}');
    } else {
      print('Перевірте розміри необхідної деталі!');
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    throw UnimplementedError();
  }
  /*var rect = Rect.fromLTWH(25, 25, resData.myData.mainPlasticWidth * 3,
        resData.myData.mainPlasticHeight * 3);
    _paint.style = PaintingStyle.fill;
    canvas.drawRect(rect, _paint);*/

  _widthCalculate(List<Rect> list) {
    var width = 0.0;
    for (var i = 0; i < list.length; i++) {
      width += list[i].size.width;
    }
    return width;
  }
}
