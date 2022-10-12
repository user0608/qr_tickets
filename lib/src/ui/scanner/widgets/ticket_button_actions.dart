import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_tickets/services/ticket_service.dart';
import 'package:qr_tickets/src/ui/scanner/providers/ticket_proccess_provider.dart';
import 'package:qr_tickets/src/ui/scanner/providers/ticket_provider.dart';
import 'package:qr_tickets/src/ui/scanner/ticket_state_auxiliar.dart';
import 'package:qr_tickets/src/ui/widgets/confirm_dialog.dart';

class TicketButtonActions extends StatelessWidget {
  const TicketButtonActions({super.key});

  @override
  Widget build(BuildContext context) {
    // final ticket = Provider.of<TicketProvider>(context).tiket;
    return ChangeNotifierProvider(
      create: (_) => TicketProcessProvider(),
      child: Column(
        children: [
          const _ProcessingAction(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              _AnularButton(),
              _AceptarTicket(),
            ],
          ),
        ],
      ),
    );
  }
}

class _AceptarTicket extends StatelessWidget {
  final auxiliar = const TicketStateAuxiliar();
  final service = const TicketApiService();
  const _AceptarTicket();

  @override
  Widget build(BuildContext context) {
    final ticket = Provider.of<TicketProvider>(context).ticket;
    return ElevatedButton.icon(
      onPressed: auxiliar.isClaimable(ticket) ? () => _showDialog(context) : null,
      icon: const Icon(Icons.check),
      label: const Text('Reclamar'),
    );
  }

  void _showDialog(BuildContext globalcontext) {
    final process = Provider.of<TicketProcessProvider>(globalcontext, listen: false);
    final ticketProvider = Provider.of<TicketProvider>(globalcontext, listen: false);
    showDialog(
      context: globalcontext,
      builder: (context) => ConfirmDialog(
        'Reclamar Ticket',
        onTabOK: () {
          process.loading = true;
          _reaclamarTicket(
            ticketProvider.ticket.id ?? '',
            onSuccess: () {
              process.loading = false;
              ticketProvider.ticketClaimedAt();
              ScaffoldMessenger.of(globalcontext).showSnackBar(
                const SnackBar(
                  backgroundColor: Colors.green,
                  content: Text("Ticket Reclamado!!!", style: TextStyle(color: Colors.white)),
                ),
              );
            },
            onError: (error) {
              process.loading = false;
              ScaffoldMessenger.of(globalcontext).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.red,
                  content: Text(error.toString(), style: const TextStyle(color: Colors.white)),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _reaclamarTicket(String uuid, {required Function onSuccess, required Function(Object e) onError}) async {
    try {
      await service.claimTicket(uuid);
      onSuccess();
    } catch (e) {
      onError(e);
    }
  }
}

class _AnularButton extends StatelessWidget {
  final auxiliar = const TicketStateAuxiliar();
  final service = const TicketApiService();
  const _AnularButton();

  @override
  Widget build(BuildContext context) {
    final ticket = Provider.of<TicketProvider>(context).ticket;
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(primary: Colors.red),
      onPressed: auxiliar.isNullable(ticket) ? () => _showDialog(context) : null,
      icon: const Icon(Icons.cancel),
      label: const Text('Anular'),
    );
  }

  void _showDialog(BuildContext globaContext) {
    final process = Provider.of<TicketProcessProvider>(globaContext, listen: false);
    final ticketProvider = Provider.of<TicketProvider>(globaContext, listen: false);
    showDialog(
      context: globaContext,
      builder: (context) => ConfirmDialog(
        'Está seguro de anular este ticket?',
        onTabOK: () {
          process.loading = true;
          _invalidarTicket(
            ticketProvider.ticket.id ?? '',
            () {
              ScaffoldMessenger.of(globaContext).showSnackBar(
                const SnackBar(
                  backgroundColor: Colors.green,
                  content: Text("Ticket Anulado!!!", style: TextStyle(color: Colors.white)),
                ),
              );
              ticketProvider.ticketNulledAt();
              process.loading = false;
            },
            (error) {
              ScaffoldMessenger.of(globaContext).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.red,
                  content: Text(error.toString(), style: const TextStyle(color: Colors.white)),
                ),
              );
              process.loading = false;
            },
          );
        },
      ),
    );
  }

  void _invalidarTicket(String uuid, Function onSuccess, Function(Object e) onError) async {
    try {
      await service.invalidTicket(uuid);
      onSuccess();
    } catch (e) {
      onError(e);
    }
  }
}

class _ProcessingAction extends StatelessWidget {
  const _ProcessingAction();

  @override
  Widget build(BuildContext context) {
    final process = Provider.of<TicketProcessProvider>(context);
    if (process.loading) {
      return const Center(
        child: SizedBox(
          height: 30.0,
          width: 30.0,
          child: CircularProgressIndicator(),
        ),
      );
    }
    return const SizedBox(height: 30.0);
  }
}
