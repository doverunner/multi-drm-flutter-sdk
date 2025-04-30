class IllegalArgumentException implements Exception {
  const IllegalArgumentException(this.message);

  final String? message;

  @override
  String toString() {
    var returnString = message;

    returnString ??= "You have to check argument";
    return returnString;
  }
}
