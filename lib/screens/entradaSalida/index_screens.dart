import 'dart:async';

import 'package:flutter/material.dart';
// import 'package:intl/date_symbol_data_local.dart';
// import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:registro_asistencia_sena_movil/models/ambiente_response.dart';
import 'package:registro_asistencia_sena_movil/models/entrada_salida_response.dart';
import 'package:registro_asistencia_sena_movil/models/ficha_caracterizacion_response.dart';
import 'package:registro_asistencia_sena_movil/models/login_response.dart';
import 'package:registro_asistencia_sena_movil/screens/entradaSalida/create_screens.dart';
import 'package:registro_asistencia_sena_movil/services/app_services.dart';
import 'package:registro_asistencia_sena_movil/widgets/footer.dart';
import 'package:registro_asistencia_sena_movil/widgets/header.dart';

class IndexEntradaSalida extends StatefulWidget {
  const IndexEntradaSalida({
    super.key,
    required this.loginResponse,
    required this.ficha,
    required this.registros,
    required this.ambiente,
  });

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
      body: ListView(
        children: [
          Card(
            child: Column(
              children: [
                Text('Ficha: ${ficha.ficha}'),
                Text('Nombre del curso: ${ficha.nombreCurso}'),
                Text('Ambiente:  ${widget.ambiente.title}'),
                Text('Fecha: $fecha'),
              ],
            ),
          ),
          getListadoRegistros(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
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
                ElevatedButton(
                  onPressed: _scanQRCode,
                  child: const Icon(Icons.qr_code),
                ),
              ],
            ),
          ),
        ],
      ),
      
      bottomNavigationBar: const footer(),
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

  Future<void> _scanQRCode() async {
    // Llamar a la función para escanear QR
    // Obtener el resultado del escaneo
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => QRViewExample()),
    );
    print("parada 1");
    print(result);
    if (result != null) {
      // Llamar a la API para insertar el nuevo registro
      final success = await apiStoreEntradaSalida(widget.ficha.id.toString(),
          result, widget.loginResponse.user.id.toString());
      print("parada 3");
      print(success);

      if (success) {
        await apiIndex(widget.ficha, widget.loginResponse);
      } else {
        // Manejar el caso de que la inserción falló
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

  // Future<List>
  Future<void> apiIndex(
    FichaCaracterizacion ficha,
    LoginResponse loginResponse,
  ) async {
    final data = await appServices.getEntradaSalida(
        loginResponse.user.id.toString(), ficha.id.toString());
    if (data.isNotEmpty) {
      setState(() {
        registros = data;
      });
    }
  }

  Future<bool> apiStoreEntradaSalida(
      String fichaId, String aprendiz, String instructorId) async {
    final data = await appServices.apiStoreEntradaSalida(
        fichaId, aprendiz, instructorId);
    if (data) {
      return true;
    }
    return false;
  }
}
