class NoInternet implements Exception {
  @override
  String toString() {
    return "No hay conexión de internet 😑";
  }
}

class RespuestaInvalida implements Exception {
  @override
  String toString() {
    return "Formato de respuesta inválido 👎";
  }
}

class ApiErrorResponse implements Exception {
  final String _message;
  ApiErrorResponse(this._message);
  @override
  String toString() {
    return _message;
  }
}
