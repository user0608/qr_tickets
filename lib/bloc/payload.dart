class Payload<T> {
  bool _isLoading = false;
  T? _payload;
  T? get payload => _payload;
  bool get isLoading => _isLoading;
  Payload(this._payload);
  Payload.loading() {
    _isLoading = true;
  }
}
