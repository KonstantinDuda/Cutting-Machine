class Result {
  double usefull;
  double trash;

  Result({required this.usefull, required this.trash});

  @override
  String toString() {
    return "Result: usefull == $usefull, trash == $trash. Sum == ${usefull + trash}";
  }
}
