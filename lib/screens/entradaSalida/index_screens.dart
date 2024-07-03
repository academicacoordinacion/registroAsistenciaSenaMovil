import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:intl/date_symbol_data_local.dart';
// import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:registro_asistencia_sena_movil/models/ambiente_response.dart';
import 'package:registro_asistencia_sena_movil/models/entrada_salida_response.dart';
import 'package:registro_asistencia_sena_movil/models/ficha_caracterizacion_response.dart';
import 'package:registro_asistencia_sena_movil/models/login_response.dart';
import 'package:registro_asistencia_sena_movil/screens/entradaSalida/create_screens.dart';
import 'package:registro_asistencia_sena_movil/services/app_services.dart';
import 'package:registro_asistencia_sena_movil/widgets/header.dart';

class IndexEntradaSalida extends StatefulWidget {
  const IndexEntradaSalida({
    Key? key,
    required this.loginResponse,
    required this.ficha,
    required this.registros,
    required this.ambiente,
  }) : super(key: key);

  final LoginResponse loginResponse;
  final FichaCaracterizacion ficha;
  final Ambiente ambiente;
  final List<EntradaSalida?> registros;

  @override
  State<IndexEntradaSalida> createState() => _IndexEntradaSalidaState();
}

class _IndexEntradaSalidaState extends State<IndexEntradaSalida> {
  late List<EntradaSalida?> registros;
  final AppServices appServices = AppServices();
  String? eventoSeleccionado;

  @override
  void initState() {
    super.initState();
    registros = widget.registros;
    eventoSeleccionado = 'entrada';
  }
@override
  Widget build(BuildContext context) {
    FichaCaracterizacion ficha = widget.ficha;
    DateTime fecha = DateTime.now();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.1),
        child: Header(loginResponse: widget.loginResponse),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Ficha: ${ficha.ficha}'),
                    Text('Nombre del curso: ${ficha.nombreCurso}'),
                    Text('Ambiente:  ${widget.ambiente.title}'),
                    Text('Fecha: $fecha'),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: getListadoRegistros(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.grey.shade200,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Radio<String>(
                        value: 'entrada',
                        groupValue: eventoSeleccionado,
                        onChanged: (value) {
                          setState(() {
                            eventoSeleccionado = value;
                          });
                        },
                      ),
                      const Text('Entrada'),
                    ],
                  ),
                  Row(
                    children: [
                      Radio<String>(
                        value: 'salida',
                        groupValue: eventoSeleccionado,
                        onChanged: (value) {
                          setState(() {
                            eventoSeleccionado = value;
                          });
                        },
                      ),
                      const Text('Salida'),
                    ],
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: scanQRCode,
                child: const Icon(Icons.qr_code),
              ),
         ElevatedButton(
                onPressed: () {
                  // Acción del botón de enviar asistencia
                  Fluttertoast.showToast(
                    msg: "Aún en desarróllo...",
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.TOP,
                  );
                },
                child: const Icon(Icons.checklist),
              ),



            ],
          ),
        ),
      ),
    );
  }


  Widget getListadoRegistros() {
    return Card(
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: registros.length,
        itemBuilder: (BuildContext context, int index) {
          final registro = registros[index];
          if (registro == null) return Container();
          return ListTile(
            title: Text('Aprendiz: ${registro.aprendiz}'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Entrada: ${registro.entrada}'),
                Text('Salida: ${registro.salida ?? 'N/A'}'),
                const Divider(
                  color: Colors.grey,
                  thickness: 2,
                  indent: 20,
                  endIndent: 20,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> scanQRCode() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => QRViewExample()),
    );

    if (result != null) {
      bool success = false;

      if (eventoSeleccionado == 'entrada') {
        success = await apiStoreEntradaSalida(
          widget.ficha.id.toString(),
          result,
          widget.loginResponse.user.id.toString(),
          widget.loginResponse.token
        );
      } else if (eventoSeleccionado == 'salida') {
        success = await apiUpdateEntradaSalida(
          result,
          widget.loginResponse.token
        );
      }

      if (success) {
        await apiIndex(widget.ficha, widget.loginResponse);
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Error'),
            content: const Text('No se pudo insertar el registro.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    }
  }

  Future<void> apiIndex(
    FichaCaracterizacion ficha,
    LoginResponse loginResponse,
  ) async {
    final data = await appServices.getEntradaSalida(
      loginResponse.user.id.toString(),
      ficha.id.toString(),
    );
    if (data.isNotEmpty) {
      setState(() {
        registros = data;
      });
    }
  }

  Future<bool> apiStoreEntradaSalida(
      String fichaId, String aprendiz, String instructorId, String authToken) async {
    final data = await appServices.apiStoreEntradaSalida(
        fichaId, aprendiz, instructorId, authToken);
    if (data) {
      return true;
    }
    return false;
  }

  Future<bool> apiUpdateEntradaSalida(String aprendiz, String authToken) async {
    final data = await appServices.apiUpdateEntradaSalida(aprendiz, authToken);
    if (data) {
      return true;
    }
    return false;
  }
}
