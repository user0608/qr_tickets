import 'package:shared_preferences/shared_preferences.dart';

const _defaultApiHost = '192.16.0.10:8080';
const _defaultIsHttps = false;

class StorageApplication {
  static final _intance = StorageApplication._private();

  StorageApplication._private();
  factory StorageApplication() {
    return _intance;
  }
  SharedPreferences? _pref;
  init() async {
    _pref = await SharedPreferences.getInstance();
    _token = _pref?.getString('token') ?? '';
    _apiHost = _pref?.getString('api-host') ?? _defaultApiHost;
    _isHttps = _pref?.getBool('api-host-is-https') ?? _defaultIsHttps;
  }

  String _token = '';
  String get token => _token;
  set token(String value) {
    _pref?.setString('token', value);
    _token = value;
  }

  String _apiHost = '';
  bool _isHttps = true;

  String get apiHost {
    if (_apiHost == '') return _defaultApiHost;
    return _apiHost;
  }

  set apiHost(String value) {
    _pref?.setString('api-host', value);
    _apiHost = value;
  }

  void loadDefaultApiHost() {
    _pref?.remove('api-host');
    _apiHost = _defaultApiHost;
  }

  bool get isHttps => _isHttps;
  set isHttps(bool value) {
    _pref?.setBool('api-host-is-https', value);
    _isHttps = value;
  }

  void loadDefaultIsHttp() {
    _pref?.remove('api-host-is-https');
    _isHttps = _defaultIsHttps;
  }
}
