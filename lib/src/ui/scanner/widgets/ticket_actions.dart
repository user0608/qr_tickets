import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:qr_tickets/src/models/collection.dart';
import 'package:qr_tickets/src/ui/scanner/providers/ticket_provider.dart';
import 'package:qr_tickets/src/ui/scanner/widgets/ticket_state.dart';

class TicketActions extends StatelessWidget {
  const TicketActions({super.key});

  @override
  Widget build(BuildContext context) {
    final collection = Provider.of<TicketProvider>(context, listen: false).ticket.collection ?? Collection();
    return SizedBox(     
      width: double.infinity,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 5.0, left: 12.0, right: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(_notBefore(collection.notBefore ?? '')),
                Expanded(
                  child: Container(
                    color: Colors.black,
                    margin: const EdgeInsets.symmetric(horizontal: 30.0),
                    height: 1.0,
                  ),
                ),
                Text(_notAfter(collection.timeOut ?? '')),
              ],
            ),
          ),
          const TicketState(),
        ],
      ),
    );
  }

  String _notBefore(String date) {
    if (date.isEmpty) {
      return "-infinite";
    }
    final dt = DateTime.parse(date).toLocal();
    return dt.toString().substring(0, 10);
  }

  String _notAfter(String date) {
    if (date.isEmpty) {
      return "+infinite";
    }
    final dt = DateTime.parse(date).toLocal();
    return dt.toString().substring(0, 10);
    //return dt.toString().substring(0, 16);
  }
}
