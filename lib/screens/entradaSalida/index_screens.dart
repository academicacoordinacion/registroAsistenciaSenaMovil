// import 'package:flutter/cupertino.dart';
// import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:registro_asistencia_sena_movil/models/ambiente_response.dart';
import 'package:registro_asistencia_sena_movil/models/entrada_salida_response.dart';
// import 'package:flutter/widgets.dart';
import 'package:registro_asistencia_sena_movil/models/ficha_caracterizacion_response.dart';
import 'package:registro_asistencia_sena_movil/models/login_response.dart';
// import 'package:registro_asistencia_sena_movil/utils/constantes.dart';
import 'package:registro_asistencia_sena_movil/widgets/footer.dart';
import 'package:registro_asistencia_sena_movil/widgets/header.dart';
// import 'package:intl/intl.dart';

class IndexEntradaSalida extends StatefulWidget {
  const IndexEntradaSalida(
      {super.key,
      required this.loginResponse,
      required this.ficha,
      required this.registros,
      required this.ambiente});
  final LoginResponse loginResponse;
  final Ficha ficha;
  final Ambiente ambiente;
  final List<EntradaSalida?> registros;

  @override
  State<IndexEntradaSalida> createState() => _IndexEntradaSalidaState();
}

class _IndexEntradaSalidaState extends State<IndexEntradaSalida> {
  // final ambiente = widget.ambiente;
  late List<EntradaSalida?> registros;
  @override
  Widget build(BuildContext context) {
    Ficha ficha = widget.ficha; // Obtener la ficha del widget
    DateTime fecha = DateTime.now();
    registros = widget.registros;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(MediaQuery.of(context).size.height *
            0.1), // Establecer la altura del AppBar como el 10% del alto de la pantalla
        child: Header(loginResponse: widget.loginResponse),
      ),
      body: ListView(
        children: [
          Card(
            child: Column(
              children: [
                Text('ID: ${ficha.id}'),
                Text('Ficha: ${ficha.ficha}'),
                Text('Nombre del curso: ${ficha.nombreCurso}'),
                Text('Ambiente:  ${widget.ambiente.title}'),
                Text('fecha $fecha'),
                // Agrega más widgets Text para mostrar otras propiedades de la ficha según sea necesario
              ],
            ),
          ),
          getListadoRegistros(),
          ElevatedButton(
              onPressed: () {}, child: const Icon(Icons.list_outlined))
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
                  ],
                ),
              );
            },
          ),
        );
  }
}
