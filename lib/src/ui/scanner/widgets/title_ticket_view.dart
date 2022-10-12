import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_tickets/src/models/collection.dart';
import 'package:qr_tickets/src/ui/scanner/providers/ticket_provider.dart';
import 'package:qr_tickets/src/ui/scanner/widgets/title_top_buttons.dart';

class TitleTicketView extends StatelessWidget {
  const TitleTicketView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    final collection = Provider.of<TicketProvider>(context, listen: false).ticket.collection ?? Collection();
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(20.0),
        bottomRight: Radius.circular(20.0),
      ),
      child: Container(
        width: size.width,
        color: theme.primaryColor,
        child: SafeArea(
          bottom: false,
          left: false,
          right: false,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TitleTopButtons(),
                const SizedBox(height: 10.0),
                Text(
                  collection.name ?? 'Titulo',
                  style: TextStyle(
                    fontSize: 22.0,
                    color: theme.primaryTextTheme.titleLarge?.color ?? Colors.white,
                  ),
                ),
                const SizedBox(height: 10.0),
                Text(
                  collection.description ?? 'descripcion',
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
