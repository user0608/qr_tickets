import 'package:qr_tickets/src/models/collection.dart';
import 'package:qr_tickets/src/models/ticket.dart';

const _nulledAsset = "assets/nulled.png";
const _validAsset = "assets/check.png";
const _waitingAsset = "assets/waiting.png";
const _usedAsset = "assets/shield.png";
const _tiemdOutAsset = "assets/closed.png";

class TicketStateAuxiliar {
  const TicketStateAuxiliar();

  String image(Ticket ticket) {
    if ((ticket.annulled ?? '').isNotEmpty) {
      return _nulledAsset;
    }
    final now = DateTime.now();
    final reclamed = ticket.reclamed ?? '';
    final collection = ticket.collection ?? Collection();
    if (reclamed.isNotEmpty) {
      return _usedAsset;
    }
    final notbefore = collection.notBefore ?? '';
    if (notbefore.isNotEmpty) {
      final t = DateTime.parse(notbefore).toLocal();
      if (now.isBefore(t)) {
        return _waitingAsset;
      }
    }
    final timeout = collection.timeOut ?? '';
    if (timeout.isNotEmpty) {
      final t = DateTime.parse(timeout).toLocal();
      if (now.isAfter(t)) {
        return _tiemdOutAsset;
      }
    }
    return _validAsset;
  }

  String message(Ticket ticket) {
    final asset = image(ticket);
    if (asset == _nulledAsset) {
      return "Ticket Anulado";
    }
    if (asset == _usedAsset) {
      return "Ticket Utilizado";
    }
    if (asset == _waitingAsset) {
      return "Collection no disponible";
    }
    if (asset == _tiemdOutAsset) {
      return "Collection Caducada";
    }
    return "Ticket Válido";
  }

  bool isNullable(Ticket ticket) {
    final asset = image(ticket);
    if (asset == _nulledAsset) {
      return false;
    }
    if (asset == _usedAsset) {
      return false;
    }
    if (asset == _waitingAsset) {
      return true;
    }
    if (asset == _tiemdOutAsset) {
      return false;
    }
    return true;
  }

  bool isClaimable(Ticket ticket) {
    final asset = image(ticket);
    if (asset == _nulledAsset) {
      return false;
    }
    if (asset == _usedAsset) {
      return false;
    }
    if (asset == _waitingAsset) {
      return false;
    }
    if (asset == _tiemdOutAsset) {
      return false;
    }
    return true;
  }
}
