import 'package:flutter/material.dart';
import 'package:sqlite/home.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _password = TextEditingController();
  final TextEditingController _username = TextEditingController();

  bool checkValid = true;
  bool passwordHidden = true;

  void _login() {
    if (_password.text.isNotEmpty) {
      setState(() {
        if (_password.text == "admin1234" && _username.text == "admin") {
          checkValid = true;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return Home();
              },
            ),
          );
          const snackBar = SnackBar(
            content: Text('Log In Succesfully!'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else {
          checkValid = false;
          const snackBar = SnackBar(
            content: Text('check your username/password again'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      });
    } else {
      const snackBar = SnackBar(
        content: Text('Oops, something went wrong!'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  void _showPassword() {
    setState(() {
      passwordHidden = !passwordHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome"),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.only(right: 20.0, left: 20.0),
          child: ListView(
            children: [
              TextField(
                controller: _username,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'User Name',
                  hintText: 'Masukkan username',
                  prefixIcon: const Icon(Icons.person),
                ),
              ),
              TextField(
                controller: _password,
                obscureText: passwordHidden,
                decoration: InputDecoration(
                  labelText: "Password",
                  hintText: 'Masukkan password',
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    onPressed: () {
                      _showPassword();
                    },
                    icon: (passwordHidden)
                        ? const Icon(Icons.visibility)
                        : const Icon(Icons.visibility_off),
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Container(
                child: ElevatedButton(
                    onPressed: () => _login(), child: const Text("Login")),
              )
            ],
          ),
        ),
      ),
    );
  }
}
