import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_tickets/src/ui/scanner/providers/ticket_provider.dart';
import 'package:qr_tickets/src/ui/scanner/ticket_state_auxiliar.dart';

class TicketState extends StatelessWidget {
  final auxiliar = const TicketStateAuxiliar();
  const TicketState({super.key});
  @override
  Widget build(BuildContext context) {
    final ticket = Provider.of<TicketProvider>(context).ticket;
    final imagepath = auxiliar.image(ticket);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
      width: 300.0,
      child: Column(
        children: [
          Image(
            image: AssetImage(imagepath),
            width: 80.0,
            height: 80.0,
          ),
          const SizedBox(height: 20.0),
          Text(
            auxiliar.message(ticket),
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 5.0),
          Text(
            ticket.id ?? '',
            style: const TextStyle(
              color: Colors.black54,
              fontSize: 10.0,
            ),
          )
        ],
      ),
    );
  }
}
