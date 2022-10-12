import 'package:flutter/cupertino.dart';

class CameraStatePrivider extends ChangeNotifier {
  final Future<bool> Function() _toggle;

  bool _flashState = false;
  bool get flashState => _flashState;

  Future<bool> toggle() async {
    final r = await _toggle();
    if (_flashState == r) {
      return r;
    }
    _flashState = r;
    super.notifyListeners();
    return r;
  }

  CameraStatePrivider(this._toggle);
}
