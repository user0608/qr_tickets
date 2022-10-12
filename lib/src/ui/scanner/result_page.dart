import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_tickets/routes.dart';
import 'package:qr_tickets/services/ticket_service.dart';
import 'package:qr_tickets/src/models/ticket.dart';
import 'package:qr_tickets/src/ui/scanner/providers/scanned_code.dart';
import 'package:qr_tickets/src/ui/scanner/providers/ticket_provider.dart';
import 'package:qr_tickets/src/ui/scanner/widgets/ticket_actions.dart';
import 'package:qr_tickets/src/ui/scanner/widgets/ticket_button_actions.dart';
import 'package:qr_tickets/src/ui/scanner/widgets/ticket_tags_view.dart';
import 'package:qr_tickets/src/ui/scanner/widgets/title_ticket_view.dart';
import 'package:qr_tickets/storage_application.dart';

class QrResultPage extends StatelessWidget {
  final TicketApiService service = const TicketApiService();
  const QrResultPage({super.key});
  @override
  Widget build(BuildContext context) {
    final session = StorageApplication();
    if (session.token == '') {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: Image(image: AssetImage('assets/depressed.png')),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
            child: Text(
              'No podemos consultar los códigos escaneados, si no hay una sesión activa',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w400),
            ),
          ),
          ElevatedButton.icon(
            onPressed: () => Navigator.pushReplacementNamed(context, Routes.loggin),
            icon: const Icon(Icons.login),
            label: const Text('Iniciar session'),
          ),
        ],
      );
    }
    final scanned = Provider.of<ScannedCodePrivider>(context, listen: false);
    return FutureBuilder(
      future: service.consultTicket(scanned.code),
      builder: (context, AsyncSnapshot<Ticket> snapshot) {
        if (snapshot.hasError) {
          final message = snapshot.error?.toString() ?? 'Error';
          return Center(child: Text(message));
        }
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.data == null) {
          return const Center(child: Text("No se encontro los datos"));
        }
        final ticket = snapshot.data!;
        return ChangeNotifierProvider(
          create: (_) => TicketProvider(ticket),
          child: const ResultadoView(),
        );
      },
    );
  }
}

class ResultadoView extends StatelessWidget {
  const ResultadoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        TitleTicketView(),
        SizedBox(height: 10.0),
        TicketActions(),
        TicketButtonActions(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: Text("Collection Tags", style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold)),
        ),
        TicketTagsView()
      ],
    );
  }
}
