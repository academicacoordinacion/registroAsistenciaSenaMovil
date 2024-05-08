import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:registro_asistencia_sena_movil/models/login_response.dart';
import 'package:registro_asistencia_sena_movil/screens/dashboard_screens.dart';
import 'package:registro_asistencia_sena_movil/utils/constantes.dart';
import 'package:fluttertoast/fluttertoast.dart';

class InicioSesion extends StatelessWidget {
  InicioSesion({super.key});

  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
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
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextField(
                  controller: _email,
                  decoration: const InputDecoration(
                    labelText: 'Correo Institucional',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _password,
                  decoration: const InputDecoration(
                    labelText: 'Contraseña',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    login(_email.text, _password.text, context);
                  },
                  child: const Text('Iniciar sesión'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void login(String email, String password, BuildContext context) async {
    final dio = Dio();
    try {

    final response = await dio.post("${Constantes.baseUrl}/authenticate/", data: {'email': email, 'password': password});
    print(response);
    if(response.statusCode == 200){
      final loginResponse = LoginResponse.fromJson(response.data);
      Navigator.push (
        context,
        MaterialPageRoute(builder: (context) => DashboardScreen(loginResponse: loginResponse ,))
      );
      print(loginResponse);


    Fluttertoast.showToast(
      msg: "Usuario autenticado",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
    );
    }
    
  } catch (e){
    print("Error en las credenciales: $e");
    
    Fluttertoast.showToast(
      msg: "Credenciales incorrectas",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
    );
    
    }
  }
  
}
