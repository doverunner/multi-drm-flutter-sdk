class UninitializedException implements Exception {
  const UninitializedException(this.message);

  final String? message;

  @override
  String toString() {
    var returnString = message;

    returnString ??= "You have to check argument";
    return returnString;
  }
}
