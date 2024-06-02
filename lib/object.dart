class MyObject {
  double width;
  double height;
  int count;

  MyObject({required this.width, required this.height, required this.count});
  //: P = width * height;

  square() {
    return height * width;
  }

  fromSquare(double square) {
    return square / width;
  }

  rotate() {
    return MyObject(width: height, height: width, count: count);
  }
}
