import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:registro_asistencia_sena_movil/models/ambiente_response.dart';
import 'package:registro_asistencia_sena_movil/models/departamento_response.dart';
import 'package:registro_asistencia_sena_movil/models/ficha_caracterizacion_response.dart';
import 'package:registro_asistencia_sena_movil/models/login_response.dart';
import 'package:registro_asistencia_sena_movil/screens/fichas_caracterizacion/index1_screens.dart';
import 'package:registro_asistencia_sena_movil/services/app_services.dart';
import 'package:registro_asistencia_sena_movil/utils/constantes.dart';
import 'package:registro_asistencia_sena_movil/widgets/footer.dart';
import 'package:registro_asistencia_sena_movil/widgets/header.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key, required this.loginResponse});
  final LoginResponse loginResponse;

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final AppServices appServices = AppServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(MediaQuery.of(context).size.height *
            0.1), // Establecer la altura del AppBar como el 10% del alto de la pantalla
        child: Header(loginResponse: widget.loginResponse),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Card(
              child: Container(
                padding: const EdgeInsets.all(20),
                // width: 350,
                // height: 300,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Padding(padding: EdgeInsets.all(10)),
                      Text(
                        "Bienvenido nuevamente, ${widget.loginResponse.persona.primerNombre} ${widget.loginResponse.persona.primerApellido}!",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                          "Aquí podras tomar la asistencia de los aprendices en los días de formacón ."),
                      const Divider(
                        color: Colors.grey,
                        thickness: 2,
                        indent: 20,
                        endIndent: 20,
                      ),
                      const Text(
                          "Recuerda que primero debes ingresar la ficha de caracterización y luego escanear el código QR para tomar la asistencia a la hora de la entrada y de la salida."),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          apiIndex(widget.loginResponse.persona.instructorId,
                              widget.loginResponse.persona.regionalId, context);
                        },
                        child: const Text('Comencemos'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const footer(),
    );
  }

  // index ficha caracterizacion
  void apiIndex(int instructorId, int regionalID, BuildContext context) async {
    try {
      final ambientes = await apiCargarAmbientes(regionalID);
      // print("estos son los ambientes");
      // print(ambientes);
      final fichasCaracterizacion =
          await apiCargarFichasCaracterizacion(instructorId);
        //   print("estas son las fichas");
        // print(fichasCaracterizacion);
      if (ambientes != null && fichasCaracterizacion != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => IndexFichaCaracterizacion(
              loginResponse: widget.loginResponse,
              fichasCaracterizacion: fichasCaracterizacion,
              ambientes: ambientes,
            ),
          ),
        );
      } else {
        Fluttertoast.showToast(
          msg: "Error al cargar los datos",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
        );
      }
    } catch (e) {
      print("Error al buscar las fichas: $e");

      Fluttertoast.showToast(
        msg: "Fichas no encontradas",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
      );
    }
  }


  Future<List<Ambiente>?> apiCargarAmbientes(int regionalID) async {
    final data = await appServices.getAmbientes(regionalID);
    return data.isNotEmpty ? data : null;
  }

  Future<List<FichaCaracterizacion>?> apiCargarFichasCaracterizacion(
      int instructorId) async {
    final data = await appServices.getFichasCaracterizacion(instructorId);
    return data.isNotEmpty ? data : null;
  }
}
