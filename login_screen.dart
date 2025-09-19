import 'package:flutter/material.dart';
import '../auth_service.dart';
import 'home_screen.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  String _error = '';

  void _login() async {
    final username = _usernameController.text.trim();
    final password = _passwordController.text;
    final userId = await AuthService.login(username, password);
    if (userId != null) {
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (_) => HomeScreen(userId: userId, username: username),
      ));
    } else {
      setState(() => _error = 'Login falhou. Verifique os dados.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(controller: _usernameController, decoration: InputDecoration(labelText: 'Usuário')),
            TextField(controller: _passwordController, obscureText: true, decoration: InputDecoration(labelText: 'Senha')),
            SizedBox(height: 10),
            ElevatedButton(onPressed: _login, child: Text("Entrar")),
            TextButton(onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => RegisterScreen()));
            }, child: Text("Criar conta")),
            if (_error.isNotEmpty) Text(_error, style: TextStyle(color: Colors.red)),
          ],
        ),
      ),
    );
  }
}