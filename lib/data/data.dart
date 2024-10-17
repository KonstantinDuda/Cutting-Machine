class EquipmentData {
  final double width;
  final int bladeCount;
  final double extremeCutWidth;

  EquipmentData({
    required this.width,
    required this.bladeCount,
    required this.extremeCutWidth,
  });

  @override
  String toString() {
    return 'EquipmentData: width == $width, bladeCount == $bladeCount, extremeCutWidth == $extremeCutWidth';
  }
}

class Data {
  //final double instrumentWidth;
  //final double instrumentNumberOfBlades;
  //final double extremeCutWidth;
  final EquipmentData equipmentData;
  final double mainPlasticHeight;
  final double mainPlasticWidth;
  final double plasticHeight; // TODO change these three things on MyObject
  final double plasticWidth;
  final int plasticCount;

  Data(
      {/*required this.instrumentWidth,
      required this.instrumentNumberOfBlades,
      required this.extremeCutWidth,*/
      required this.equipmentData,
      required this.mainPlasticHeight,
      required this.mainPlasticWidth,
      required this.plasticHeight,
      required this.plasticWidth,
      required this.plasticCount});

  @override
  String toString() {
    var text = 'instrumentWidth == $equipmentData. '
        'mainPlasticHeight == $mainPlasticHeight. '
        'mainPlasticWidth == $mainPlasticWidth. '
        'plasticHeight == $plasticHeight. plasticWidth == $plasticWidth. '
        'plasticCount == $plasticCount.';
    return text;
  }
}

class ResultData {
  // Main Rectangle and Instrument Data
  final Data myData;
  // Strips Data for first screen
  final int stripCount;
  //final double stripWidth;
  //late double stripHeight;
  late double stripRemainderWidth; //
  late double stripRemainderHeight; //
  late int stripForOneCutCount;
  // Rectangle Data for second screen
  late double rectangleRemainderWidth; //
  late double rectangleRemainderHeight; //
  late int rectangleForOneCutCount;
  // ExtremeCut Data
  late int extremeCutStripCount; //
  late int extremeCutRectangleCount;

  ResultData({
    required this.myData,
    required this.stripCount,
    required this.rectangleRemainderHeight,
  }) {
    stripRemainderWidth =
        myData.mainPlasticWidth - stripCount * myData.plasticWidth;
    stripRemainderHeight = myData.mainPlasticHeight;
    //stripHeight = myData.mainPlasticHeight;
    rectangleRemainderWidth = stripRemainderWidth;
    rectangleRemainderHeight = myData.mainPlasticWidth;
    stripForOneCutCount =
        (myData.equipmentData.width / myData.plasticWidth).toInt();
    extremeCutStripCount = (stripCount / stripForOneCutCount).toInt();
    rectangleForOneCutCount =
        (myData.equipmentData.width / myData.plasticHeight).toInt();
    extremeCutRectangleCount =
        ((myData.mainPlasticHeight / myData.plasticHeight).toInt() /
                rectangleForOneCutCount)
            .toInt();
  }
}
  /// Важливо передавати значення коректно:
  /// myData.equipmentData Значення не змінюються і не залежать від
  /// попередніх розрахунків
  /// myData.mainPlasticWidth myData.mainPlasticHeight Залежать від того як
  /// корисніше розмістити перед нарізанням великий лист пластику
  /// myData.plasticHeight myData.plasticWidth Також залежать від розрахунків
  /// як саме будуть нарізатись полоски і квадратики тож:
  ///
  /// myData.mainPlasticHeight - Висота полосок на які буде нарізатись лист
  /// myData.plasticWidth - Це також ширина полосок на які спершу буде
  /// нарізатись великий лист. Відповідно
  /// myData.plasticHeight висота прямокутників на які
  /// будуть нарізатись полоски
  ///