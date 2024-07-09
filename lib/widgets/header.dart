import 'package:flutter/material.dart';
import 'package:registro_asistencia_sena_movil/controllers/login_controller.dart';
import 'package:registro_asistencia_sena_movil/models/login_response.dart';
import 'package:registro_asistencia_sena_movil/screens/dashboard_screens.dart';
import 'package:registro_asistencia_sena_movil/screens/inicio_sesion_screens.dart';
import 'package:registro_asistencia_sena_movil/screens/perfil/show_screens.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:registro_asistencia_sena_movil/utils/constantes.dart';

class Header extends StatelessWidget {
  const Header({
    super.key,
    required this.loginResponse,
  });

  final LoginResponse loginResponse;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: [
        IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => DashboardScreen(
                    loginResponse: loginResponse,
                  ),
                ),
              );
            },
            icon: const Icon(Icons.home)),
        PopupMenuButton<String>(
          onSelected: (String value) {
            if (value == 'perfil') {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ShowPerfil(loginResponse: loginResponse)),
                (Route<dynamic> route) => false,
              );
            } else if (value == 'logout') {
              logout(context);
            }
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            const PopupMenuItem<String>(
              value: 'perfil',
              child: ListTile(
                leading: Icon(Icons.person),
                title: Text('Perfil'),
              ),
            ),
            const PopupMenuItem<String>(
              value: 'logout',
              child: ListTile(
                leading: Icon(Icons.logout),
                title: Text('Cerrar sesión'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

Future<void> logout(BuildContext context) async {
  
  final LoginController logincontroller = LoginController();

  try {
    final response = await logincontroller.logout(context);
    if (response) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => InicioSesion()),
        (Route<dynamic> route) => false,
      );
      Fluttertoast.showToast(
        msg: "Sesión cerrada.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
      );
    } else {
      print("Error al cerrar sesión: Código de estado ${response}");
    }
  } catch (e) {
    // Manejo de errores
    print("No es posible cerrar sesión. Error: $e");
  }
}
