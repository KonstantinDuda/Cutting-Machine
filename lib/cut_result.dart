import 'package:work_calculator/object.dart';

class CutResult {
  MyObject strip; //List<MyObject> strip; // TODO це має бути List<MyObject>
  MyObject mainRest;
  double trash;

  CutResult({required this.strip, required this.mainRest, required this.trash});
}
