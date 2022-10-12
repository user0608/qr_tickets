import 'package:qr_tickets/services/bases/services.dart';
import 'package:qr_tickets/src/models/ticket.dart';

class EmptyCodeException implements Exception {
  @override
  String toString() {
    return "Codigo Ticket Vacio";
  }
}

class EmptyTokenUUID implements Exception {
  @override
  String toString() {
    return "Codigo Ticket Vacio";
  }
}

class TicketApiService {
  final _basepath = "ticket/complete";
  final _claimpath = "ticket/claim";
  final _invalidpath = "ticket/invalid";

  const TicketApiService();

  Future<Ticket> consultTicket(String code) async {
    if (code == "") {
      throw EmptyCodeException();
    }
    final result = await ApiService.get("$_basepath/$code");
    return Ticket.fromJson(result["data"]);
  }

  Future<void> claimTicket(String uuid) async {
    if (uuid.isEmpty) {
      throw EmptyTokenUUID();
    }
    await ApiService.put('$_claimpath/$uuid', null);
  }

  Future<void> invalidTicket(String uuid) async {
    if (uuid.isEmpty) {
      throw EmptyTokenUUID();
    }
    await ApiService.put('$_invalidpath/$uuid', null);
  }
}
