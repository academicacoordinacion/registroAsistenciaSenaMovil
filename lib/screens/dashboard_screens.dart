import 'package:flutter/material.dart';
import 'package:registro_asistencia_sena_movil/models/login_response.dart';
import 'package:registro_asistencia_sena_movil/screens/fichas_caracterizacion/index_screens.dart';
import 'package:registro_asistencia_sena_movil/widgets/footer.dart';
import 'package:registro_asistencia_sena_movil/widgets/header.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key, required this.loginResponse});
  final LoginResponse loginResponse;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(MediaQuery.of(context).size.height * 0.1), // Establecer la altura del AppBar como el 10% del alto de la pantalla
        child: Header(loginResponse: loginResponse),
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
                          "Bienvenido nuevamente, ${loginResponse.persona.primerNombre } ${loginResponse.persona.primerApellido}!",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            ),),
                        const Text("Aquí podras tomar la asistencia de los aprendices en los días de formacón ."),
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => IndexFichaCaracterizacion(loginResponse: loginResponse,)));
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
}

