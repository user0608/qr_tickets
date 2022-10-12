import 'package:flutter/cupertino.dart';

class TicketProcessProvider extends ChangeNotifier {
  bool _loading = false;
  bool get loading => _loading;
  set loading(bool value) {
    if (_loading == value) return;
    _loading = value;
    super.notifyListeners();
  }
}
