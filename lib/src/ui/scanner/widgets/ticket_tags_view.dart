import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_tickets/src/models/collection.dart';
import 'package:qr_tickets/src/ui/scanner/providers/ticket_provider.dart';
import 'package:qr_tickets/src/ui/scanner/widgets/tag_item_view.dart';

class TicketTagsView extends StatelessWidget {
  const TicketTagsView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        padding: const EdgeInsets.all(0.0),
        children: _tags(context),
      ),
    );
  }

  List<Widget> _tags(BuildContext context) {
    final provider = Provider.of<TicketProvider>(context, listen: false);
    final collection = provider.ticket.collection ?? Collection();
    final tags = collection.tags ?? [];
    if (tags.isNotEmpty) {
      return tags
          .map((tag) => TagItemView(
                key: Key(tag.id ?? ''),
                tagname: tag.name ?? '',
                tagvalue: tag.value ?? '',
              ))
          .toList();
    }

    return [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: Container(
            height: 40.0,
            color: Colors.grey,
            child: const Center(
                child: Text(
              "No hay tags asociados",
              style: TextStyle(color: Colors.white, fontSize: 18.0),
            )),
          ),
        ),
      )
    ];
  }
}
