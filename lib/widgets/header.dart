import 'package:flutter/material.dart';
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
  final dio = Dio();
  SharedPreferences prefs = await SharedPreferences.getInstance();

  // Comprobación previa del loginResponse
  String? loginResponse = prefs.getString('loginResponse');
  print("Antes de eliminar: loginResponse = $loginResponse");

  await prefs.remove('loginResponse');

  // Comprobación posterior del loginResponse
  loginResponse = prefs.getString('loginResponse');
  print("Después de eliminar: loginResponse = $loginResponse");

  try {
    final response = await dio.post("${Constantes.baseUrl}/logout");
    if (response.statusCode == 200) {
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
      print("Error al cerrar sesión: Código de estado ${response.statusCode}");
    }
  } catch (e) {
    // Manejo de errores
    print("No es posible cerrar sesión. Error: $e");
  }
}
