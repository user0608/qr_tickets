import 'package:flutter/material.dart';
import 'package:qr_tickets/routes.dart';
import 'package:qr_tickets/services/login_service.dart';
import 'package:qr_tickets/storage_application.dart';

class LogginScreen extends StatelessWidget {
  const LogginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: size.width * 0.8,
            height: size.height,
            child: _LoginForm(),
          ),
        ),
      ),
    );
  }
}

class _LoginForm extends StatefulWidget {
  @override
  State<_LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<_LoginForm> {
  String username = '';
  String password = '';
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("LOGIN IN", style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w500)),
        const SizedBox(height: 50.0),
        _UsernameInput((v) => setState(() => username = v)),
        const SizedBox(height: 20.0),
        _PasswordInput((v) => setState(() => password = v)),
        _IniciarButton(
          () {
            if (loading) return;
            setState(() => loading = true);
            FocusManager.instance.primaryFocus?.unfocus();
            _iniciarSession(
              username,
              password,
              () => Navigator.pushReplacementNamed(context, Routes.scanner),
              (error) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.red,
                    content: Text(error.toString(), style: const TextStyle(color: Colors.white)),
                  ),
                );
                setState(() => loading = false);
              },
            );
          },
        ),
        const _SkipLogin(),
        SizedBox(
          height: 30.0,
          width: 30.0,
          child: Visibility(
            visible: loading,
            child: const CircularProgressIndicator(),
          ),
        ),
      ],
    );
  }

  void _iniciarSession(
    String username,
    String password,
    void Function() onSuccess,
    void Function(Object error) onError,
  ) async {
    final service = LoginService();
    try {
      final token = await service.login(username, password);
      StorageApplication().token = token;
      onSuccess();
    } catch (error) {
      onError(error);
    }
  }
}

class _UsernameInput extends StatelessWidget {
  final void Function(String)? onChanged;
  const _UsernameInput(this.onChanged);
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: const InputDecoration(
        icon: Icon(Icons.person),
        labelText: 'Username',
      ),
      onChanged: onChanged,
    );
  }
}

class _PasswordInput extends StatelessWidget {
  final void Function(String)? onChanged;
  const _PasswordInput(this.onChanged);

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: true,
      enableSuggestions: false,
      autocorrect: false,
      decoration: const InputDecoration(
        icon: Icon(Icons.person),
        labelText: 'Password',
      ),
      onChanged: onChanged,
    );
  }
}

class _IniciarButton extends StatelessWidget {
  final void Function()? onPressed;
  const _IniciarButton(this.onPressed);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 50.0),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: onPressed,
            child: const Text('INICIAR'),
          ),
        ),
      ],
    );
  }
}

class _SkipLogin extends StatelessWidget {
  const _SkipLogin({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10.0),
        TextButton.icon(
          onPressed: () {
            Navigator.restorablePushNamed(context, Routes.scanner);
          },
          icon: const Icon(Icons.qr_code, color: Colors.grey),
          label: const Text('Escanear sin cuenta', style: TextStyle(color: Colors.grey)),
        ),
      ],
    );
  }
}
