import 'package:qr_tickets/src/models/collection_tags.dart';

class Collection {
  String? id;
  String? name;
  String? description;
  String? timeOut;
  String? notBefore;
  String? createdAt;
  int? numTickets;
  String? templateUuid;
  String? templateDetails;
  String? documentoUuid;
  String? documentProcess;
  String? processResult;
  List<Tags>? tags;

  Collection(
      {this.id,
      this.name,
      this.description,
      this.timeOut,
      this.notBefore,
      this.createdAt,
      this.numTickets,
      this.templateUuid,
      this.templateDetails,
      this.documentoUuid,
      this.documentProcess,
      this.processResult,
      this.tags});

  Collection.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    timeOut = json['time_out'];
    notBefore = json['not_before'];
    createdAt = json['created_at'];
    numTickets = json['num_tickets'];
    templateUuid = json['template_uuid'];
    templateDetails = json['template_details'];
    documentoUuid = json['documento_uuid'];
    documentProcess = json['document_process'];
    processResult = json['process_result'];
    if (json['tags'] != null) {
      tags = <Tags>[];
      json['tags'].forEach((v) {
        tags!.add(Tags.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['time_out'] = timeOut;
    data['not_before'] = notBefore;
    data['created_at'] = createdAt;
    data['num_tickets'] = numTickets;
    data['template_uuid'] = templateUuid;
    data['template_details'] = templateDetails;
    data['documento_uuid'] = documentoUuid;
    data['document_process'] = documentProcess;
    data['process_result'] = processResult;
    if (tags != null) {
      data['tags'] = tags!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
