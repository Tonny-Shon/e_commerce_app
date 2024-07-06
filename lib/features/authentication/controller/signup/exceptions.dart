class EFirebaseAuthException implements Exception {
  final String? code;
  final String? message;

  EFirebaseAuthException({required this.code, required this.message});

  @override
  String toString() => 'EFirebaseAuthException(code: $code, message: $message)';
}

class EFirebaseException implements Exception {
  final String code;
  final String message;

  EFirebaseException({required this.code, required this.message});

  @override
  String toString() => 'EFirebaseException(code: $code, message: $message)';
}

class EFormatException implements Exception {
  final String message;

  EFormatException({this.message = 'Format error'});

  @override
  String toString() => 'EFormatException(message: $message)';
}

class EPlatformException implements Exception {
  final String message;

  EPlatformException(code, {this.message = 'Platform error occurred'});

  @override
  String toString() => 'EPlatformException(message: $message)';
}
