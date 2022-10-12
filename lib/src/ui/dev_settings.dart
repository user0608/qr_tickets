import 'package:flutter/material.dart';
import 'package:qr_tickets/routes.dart';
import 'package:qr_tickets/services/bases/services.dart';
import 'package:qr_tickets/storage_application.dart';

class DevSettingsScreen extends StatefulWidget {
  const DevSettingsScreen({super.key});

  @override
  State<DevSettingsScreen> createState() => _DevSettingsScreenState();
}

class _DevSettingsScreenState extends State<DevSettingsScreen> {
  final storage = StorageApplication();
  bool ishttps = false;
  String host = '';
  bool testingConnection = false;
  TextEditingController? textontroller;
  @override
  void initState() {
    super.initState();
    ishttps = storage.isHttps;
    host = storage.apiHost;
    textontroller = TextEditingController(text: storage.apiHost);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: TextButton.icon(
                  onPressed: () {
                    storage.loadDefaultApiHost();
                    storage.loadDefaultIsHttp();
                    setState(() {
                      ishttps = storage.isHttps;
                      host = storage.apiHost;
                      if (textontroller == null) return;
                      textontroller?.value = TextEditingValue(text: host);
                    });
                  },
                  icon: const Icon(Icons.settings),
                  label: const Text("Default Settings"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextField(
                  controller: textontroller,
                  decoration: const InputDecoration(
                    labelText: 'Nombre',
                  ),
                  onChanged: (value) {
                    host = value;
                  },
                ),
              ),
              const SizedBox(height: 10.0),
              SwitchListTile(
                value: ishttps,
                title: const Text('Usar https'),
                onChanged: (state) {
                  setState(() {
                    ishttps = state;
                  });
                },
              ),
              const SizedBox(height: 20.0),
              Center(
                child: ElevatedButton.icon(
                  onPressed: !testingConnection ? () => _testConnection(context, host, ishttps) : null,
                  icon: const Icon(Icons.network_check),
                  label: const Text('Test Connection!!!'),
                ),
              ),
              Center(
                child: SizedBox(
                  height: 40.0,
                  width: 40.0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Visibility(
                      visible: testingConnection,
                      child: const CircularProgressIndicator(),
                    ),
                  ),
                ),
              ),
              TextButton.icon(
                onPressed: () {
                  storage.isHttps = ishttps;
                  storage.apiHost = host;
                  Navigator.pushReplacementNamed(context, Routes.scanner);
                },
                icon: const Icon(Icons.save),
                label: const Text("Salir y guardar"),
              ),
              TextButton.icon(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, Routes.scanner);
                },
                icon: const Icon(Icons.cancel, color: Colors.red),
                label: const Text("Salir sin Guardar", style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _testConnection(BuildContext context, String host, bool isHttps) {
    setState(() => testingConnection = true);
    _connectionHealth(
      host,
      isHttps,
      onSuccess: () {
        setState(() => testingConnection = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.green,
            content: Text("Success!!!", style: TextStyle(color: Colors.white)),
          ),
        );
      },
      onError: (error) {
        setState(() => testingConnection = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text(error.toString(), style: const TextStyle(color: Colors.white)),
          ),
        );
      },
    );
  }

  void _connectionHealth(
    String host,
    bool isHttps, {
    required void Function() onSuccess,
    required void Function(Object error) onError,
  }) async {
    try {
      await ApiService.testHealty(host, isHttps);
      onSuccess();
    } catch (e) {
      onError(e);
    }
  }
}
