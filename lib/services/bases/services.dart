import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'package:qr_tickets/services/bases/exceptions.dart';
import 'package:qr_tickets/storage_application.dart';

class ApiService {
  static Uri _url(String path, {Map<String, String> queryparams = const {}}) {
    final storage = StorageApplication();
    if (storage.isHttps) {
      return Uri.https(storage.apiHost, path, {...queryparams});
    }
    return Uri.http(storage.apiHost, path, {...queryparams});
  }

  static Future testHealty(String host, bool isHttps) async {
    Uri url;
    if (isHttps) {
      url = Uri.https(host, 'health');
    } else {
      url = Uri.http(host, 'health');
    }
    final response = await http.get(url).timeout(const Duration(seconds: 10));
    final decoded = json.decode(response.body);
    if ((response.statusCode / 100).truncate() != 2) {
      throw ApiErrorResponse(decoded["message"]);
    }
  }

  static Future get(String path, [Map<String, String> qparams = const {}]) async {
    var client = http.Client();
    try {
      final response = await client.get(
        ApiService._url(path, queryparams: qparams),
        headers: {
          "Content-Type": "application/json",
          "Authorization": StorageApplication().token,
        },
      );
      final decoded = json.decode(response.body);
      if ((response.statusCode / 100).truncate() != 2) {
        throw ApiErrorResponse(decoded["message"]);
      }
      return decoded;
    } catch (e) {
      if (e is SocketException) throw NoInternet();
      if (e is HttpException) {
        throw ApiErrorResponse("Couldn't find the post 😱");
      }
      if (e is FormatException) throw RespuestaInvalida();
      rethrow;
    } finally {
      client.close();
    }
  }

  static Future post(String path, Object payload, [Map<String, String> qparams = const {}]) async {
    var client = http.Client();
    try {
      final response = await client.post(
        ApiService._url(path, queryparams: qparams),
        body: jsonEncode(payload),
        headers: {
          "Content-Type": "application/json",
          "Authorization": StorageApplication().token,
        },
      );
      final decoded = json.decode(response.body);
      if ((response.statusCode / 100).truncate() != 2) {
        throw ApiErrorResponse(decoded["message"]);
      }
      return decoded;
    } catch (e) {
      if (e is SocketException) throw NoInternet();
      if (e is HttpException) {
        throw ApiErrorResponse("Couldn't find the post 😱");
      }
      if (e is FormatException) throw RespuestaInvalida();
      rethrow;
    } finally {
      client.close();
    }
  }

  static Future put(String path, Object? payload, [Map<String, String> qparams = const {}]) async {
    var client = http.Client();
    try {
      final response = await client.put(
        ApiService._url(path, queryparams: qparams),
        body: jsonEncode(payload),
        headers: {
          "Content-Type": "application/json",
          "Authorization": StorageApplication().token,
        },
      );
      final decoded = json.decode(response.body);
      if ((response.statusCode / 100).truncate() != 2) {
        throw ApiErrorResponse(decoded["message"]);
      }
      return decoded;
    } catch (e) {
      if (e is SocketException) throw NoInternet();
      if (e is HttpException) {
        throw ApiErrorResponse("Couldn't find the post 😱");
      }
      if (e is FormatException) throw RespuestaInvalida();
      rethrow;
    } finally {
      client.close();
    }
  }
}
