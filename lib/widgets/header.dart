import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:registro_asistencia_sena_movil/models/login_response.dart';
import 'package:registro_asistencia_sena_movil/screens/dashboard_screens.dart';
import 'package:registro_asistencia_sena_movil/screens/inicio_sesion_screens.dart';
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
      // title: const Text('Bienvenido'),
      actions: [
        IconButton(onPressed: () {
          Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DashboardScreen(
                            loginResponse: loginResponse,
                          )));
        }, icon: const Icon(Icons.home)),
    PopupMenuButton<String>(
      onSelected: (String value) {
        // Manejar la opción seleccionada aquí
        if (value == 'perfil') {
          // Realizar la navegación a la página de perfil u otra acción deseada
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

Future<void> logout (BuildContext context) async {
  final dio = Dio();
    try {

    final response = await dio.post("${Constantes.baseUrl}/logout");
  
    if(response.statusCode == 200){
      Navigator.push (
        context,
        MaterialPageRoute(builder: (context) => InicioSesion())
      );
      Fluttertoast.showToast(
        msg: "Sesión cerrada.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
      );


    }
    
  } catch (e){
    // print("Error en las credenciales: $e");
    
  
    
    }
  }