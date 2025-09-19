import 'package:flutter/material.dart';
import '../auth_service.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  String _message = '';

  void _register() async {
    final username = _usernameController.text.trim();
    final password = _passwordController.text;
    final success = await AuthService.register(username, password);
    setState(() {
      _message = success ? 'Conta criada com sucesso! Volte para login.' : 'Erro: usuário já existe.';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Registro")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(controller: _usernameController, decoration: InputDecoration(labelText: 'Usuário')),
            TextField(controller: _passwordController, obscureText: true, decoration: InputDecoration(labelText: 'Senha')),
            SizedBox(height: 10),
            ElevatedButton(onPressed: _register, child: Text("Registrar")),
            if (_message.isNotEmpty) Text(_message, style: TextStyle(color: Colors.green)),
          ],
        ),
      ),
    );
  }
}