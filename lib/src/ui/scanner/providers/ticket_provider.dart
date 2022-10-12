import 'package:flutter/cupertino.dart';
import 'package:qr_tickets/src/models/ticket.dart';

class TicketProvider extends ChangeNotifier {
  Ticket _ticket;
  TicketProvider(this._ticket);

  Ticket get ticket => _ticket;
  set ticket(Ticket value) {
    _ticket = value;
    super.notifyListeners();
  }

  void ticketClaimedAt() {
    final now = DateTime.now();
    _ticket.reclamed = now.toIso8601String();
    super.notifyListeners();
  }

  void ticketNulledAt() {
    final now = DateTime.now();
    _ticket.annulled = now.toIso8601String();
    super.notifyListeners();
  }
}
