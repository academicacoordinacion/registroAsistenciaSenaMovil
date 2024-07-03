import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:registro_asistencia_sena_movil/models/login_response.dart';
import 'package:registro_asistencia_sena_movil/screens/dashboard_screens.dart';
import 'package:registro_asistencia_sena_movil/utils/constantes.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class InicioSesion extends StatelessWidget {
  InicioSesion({Key? key}) : super(key: key);

  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Text(
                      "Bienvenido a la aplicación beta para el registro de asistencia de aprendices SENA.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Image.asset('assets/images/LogoSena.jpeg', height: 150),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: TextField(
                        controller: _email,
                        decoration: const InputDecoration(
                          labelText: 'Correo Institucional',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: TextField(
                        controller: _password,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: 'Contraseña',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: ElevatedButton(
                        onPressed: () {
                          login(_email.text, _password.text, context);
                        },
                        child: const Text('Iniciar sesión'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void login(String email, String password, BuildContext context) async {
    final dio = Dio();
    try {
      final response = await dio.post("${Constantes.baseUrl}/authenticate",
          data: {'email': email, 'password': password});
      if (response.statusCode == 200) {
        final loginResponse = LoginResponse.fromJson(response.data);

        // Guardar LoginResponse en SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String loginResponseJson = jsonEncode(loginResponse.toJson());
        await prefs.setString('loginResponse', loginResponseJson);
        
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  DashboardScreen(loginResponse: loginResponse)),
        );

        Fluttertoast.showToast(
          msg: "Usuario autenticado",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
        );

      }
    } catch (e) {
      print(e);
      Fluttertoast.showToast(
        msg: "Credenciales incorrectas",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
      );
    }
  }

  static Future<LoginResponse?> getLoginResponse() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? loginResponseJson = prefs.getString('loginResponse');
    if (loginResponseJson != null) {
      Map<String, dynamic> loginResponseMap = jsonDecode(loginResponseJson);
      return LoginResponse.fromJson(loginResponseMap);
    }
    return null;
  }
}
