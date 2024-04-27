class ServerException implements Exception {
  ServerException({required this.message});
  final String message;
}

class CacheException implements Exception {
  CacheException({required this.message});
  final String message;
}

class InternetException implements Exception {}

class EnvironmentException implements Exception {
  EnvironmentException({required this.message});
  final String message;
}

class MusicCancelException implements Exception {
  MusicCancelException({required this.message});
  final String message;
}

class MusicConvertException implements Exception {
  MusicConvertException({required this.message});
  final String message;
}
