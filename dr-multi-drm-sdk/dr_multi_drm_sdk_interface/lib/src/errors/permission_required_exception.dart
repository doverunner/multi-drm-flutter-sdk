class PermissionRequiredException implements Exception {
  const PermissionRequiredException(this.message);

  final String? message;

  @override
  String toString() {
    var returnString = message;

    returnString ??= "You have to check device permission";
    // if (message == null || message == '') {
    //   return 'Access to the location of the device is denied by the user.';
    // }
    return returnString;
  }
}
