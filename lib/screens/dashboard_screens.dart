import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:registro_asistencia_sena_movil/models/ambiente_response.dart';
import 'package:registro_asistencia_sena_movil/models/ficha_caracterizacion_response.dart';
import 'package:registro_asistencia_sena_movil/models/login_response.dart';
import 'package:registro_asistencia_sena_movil/screens/fichas_caracterizacion/index1_screens.dart';
import 'package:registro_asistencia_sena_movil/services/app_services.dart';
import 'package:registro_asistencia_sena_movil/widgets/footer.dart';
import 'package:registro_asistencia_sena_movil/widgets/header.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key, required this.loginResponse})
      : super(key: key);

  final LoginResponse loginResponse;

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final AppServices appServices = AppServices();

  @override
  void initState() {
    super.initState();
    mostrarAlertaPerfil(widget.loginResponse);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.1),
        child: Header(loginResponse: widget.loginResponse),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
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
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "Aquí podrás tomar la asistencia de los aprendices en los días de formación.",
                          textAlign: TextAlign.justify,
                        ),
                        const Divider(
                          color: Colors.grey,
                          thickness: 2,
                          indent: 20,
                          endIndent: 20,
                        ),
                        const Text(
                          "Recuerda que primero debes ingresar la ficha de caracterización y luego escanear el código QR para tomar la asistencia a la hora de la entrada y de la salida.",
                          textAlign: TextAlign.justify,
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: ElevatedButton(
                            onPressed: () {
                              apiIndex(
                                  widget.loginResponse.persona.instructorId,
                                  widget.loginResponse.persona.regionalId,
                                  widget.loginResponse.token,
                                  context);
                            },
                            child: const Text('Comencemos'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const footer(),
    );
  }

  // index ficha caracterizacion
  void apiIndex(int instructorId, int regionalID,String authToken, BuildContext context) async {
    // print("print de regional id:   ${regionalID}");
    print("print de instructor id:   ${authToken}");
    try {
      final ambientes = await apiCargarAmbientes(regionalID, authToken);
      final fichasCaracterizacion =
          await apiCargarFichasCaracterizacion(instructorId, authToken);
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
        if (ambientes == null) {
          Fluttertoast.showToast(
            msg: "No se han encontrado ambientes disponibles.",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.TOP,
          );
        }
        if (fichasCaracterizacion == null) {
          Fluttertoast.showToast(
            msg:
                "No tiene asignado fichas de caracterización, por favor comuniquese y solicite que le asignen fichas de caracterización.",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.TOP,
          );
        }
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

  Future<List<Ambiente>?> apiCargarAmbientes(int regionalID, String authToken) async {
    final data = await appServices.getAmbientes(regionalID, authToken);
    return data.isNotEmpty ? data : null;
  }

  Future<List<FichaCaracterizacion>?> apiCargarFichasCaracterizacion(
      int instructorId, String authToken) async {
    final data = await appServices.getFichasCaracterizacion(instructorId, authToken);
    return data.isNotEmpty ? data : null;
  }

  void mostrarAlertaPerfil(LoginResponse loginResponse) {
    if ((loginResponse.persona.segundoNombre == null ||
            loginResponse.persona.segundoNombre!.isEmpty) &&
        (loginResponse.persona.primerApellido == null ||
            loginResponse.persona.primerApellido!.isEmpty) &&
        (loginResponse.persona.segundoApellido == null ||
            loginResponse.persona.segundoApellido!.isEmpty) &&
            (loginResponse.persona.fechaDeNacimiento == null)) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Perfil Incompleto'),
              content: const Text(
                  'Su perfil está incompleto. Por favor, actualice su información y continue disfrutando de la aplicación.'),
              actions: <Widget>[
                TextButton(
                  child: const Text('Aceptar'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      });
    }
  }
}
