
import 'package:qr_tickets/src/models/collection.dart';

class Ticket {
  String? id;
  String? reclamed;
  String? annulled;
  Collection? collection;

  Ticket({this.id, this.reclamed, this.annulled, this.collection});

  Ticket.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    reclamed = json['reclamed'];
    annulled = json['annulled'];
    collection = json['collection'] != null ? Collection.fromJson(json['collection']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['reclamed'] = reclamed;
    data['annulled'] = annulled;
    if (collection != null) {
      data['collection'] = collection!.toJson();
    }
    return data;
  }
}
