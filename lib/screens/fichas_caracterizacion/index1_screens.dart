// import 'package:flutter/cupertino.dart';
// import 'dart:math';

// import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:registro_asistencia_sena_movil/models/ambiente_response.dart';
import 'package:registro_asistencia_sena_movil/models/bloque_response.dart';
import 'package:registro_asistencia_sena_movil/models/departamento_response.dart';
// import 'package:flutter/widgets.dart';
import 'package:registro_asistencia_sena_movil/models/ficha_caracterizacion_response.dart';
import 'package:registro_asistencia_sena_movil/models/login_response.dart';
import 'package:registro_asistencia_sena_movil/models/municipio_response.dart';
import 'package:registro_asistencia_sena_movil/models/piso_response.dart';
import 'package:registro_asistencia_sena_movil/models/sede_response.dart';
import 'package:registro_asistencia_sena_movil/screens/entradaSalida/index_screens.dart';
// import 'package:registro_asistencia_sena_movil/screens/entradaSalida/index_screens.dart';
import 'package:registro_asistencia_sena_movil/screens/fichas_caracterizacion/index2_screens.dart';
import 'package:registro_asistencia_sena_movil/services/app_services.dart';
// import 'package:registro_asistencia_sena_movil/utils/constantes.dart';
import 'package:registro_asistencia_sena_movil/widgets/footer.dart';
import 'package:registro_asistencia_sena_movil/widgets/header.dart';

class IndexFichaCaracterizacion extends StatefulWidget {
  const IndexFichaCaracterizacion(
      {super.key,
      required this.loginResponse,
      required this.fichasCaracterizacion,
      required this.ambientes,
      // required this.departamentos
      });
  final LoginResponse loginResponse;
  final List<FichaCaracterizacion> fichasCaracterizacion;
  // final List<Departamento> departamentos;
  final List<Ambiente> ambientes;
  @override
  State<IndexFichaCaracterizacion> createState() =>
      _IndexFichaCaracterizacionState();

      
}
class _IndexFichaCaracterizacionState extends State<IndexFichaCaracterizacion> {
  FichaCaracterizacion? selectedFicha;
  Ambiente? selectedAmbiente;
  String searchFichaQuery = "";
  String searchAmbienteQuery = "";
  List<FichaCaracterizacion> filteredFichas = [];
  List<Ambiente> filteredAmbientes = [];

  final AppServices appServices = AppServices();

  @override
  void initState() {
    super.initState();
    filteredFichas = widget.fichasCaracterizacion;
    filteredAmbientes = widget.ambientes;
  }

  void filterFichas(String query) {
    setState(() {
      searchFichaQuery = query;
      filteredFichas = widget.fichasCaracterizacion
          .where((ficha) =>
              ficha.ficha.toLowerCase().contains(query.toLowerCase()) ||
              ficha.nombreCurso.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void filterAmbientes(String query) {
    setState(() {
      searchAmbienteQuery = query;
      filteredAmbientes = widget.ambientes
          .where((ambiente) =>
              ambiente.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.1),
        child: Header(loginResponse: widget.loginResponse),
      ),
      body: ListView(
        children: [
          TextField(
            decoration: InputDecoration(
              labelText: 'Buscar ficha o nombre de curso',
              border: OutlineInputBorder(),
            ),
            onChanged: (text) {
              filterFichas(text);
            },
          ),
          seleccionarFicha(filteredFichas),
          TextField(
            decoration: InputDecoration(
              labelText: 'Buscar ambiente',
              border: OutlineInputBorder(),
            ),
            onChanged: (text) {
              filterAmbientes(text);
            },
          ),
          seleccionarAmbiente(filteredAmbientes),
          botonRegistros(context)
        ],
      ),
      bottomNavigationBar: const footer(),
    );
  }

  ElevatedButton botonRegistros(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (selectedFicha != null && selectedAmbiente != null) {
          screenIndexEntradaSalida(
              selectedFicha!, widget.loginResponse, selectedAmbiente!, context);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                  'Seleccione una ficha y un ambiente antes de continuar.'),
            ),
          );
        }
      },
      child: const Icon(Icons.navigate_next),
    );
  }

  Widget seleccionarFicha(List<FichaCaracterizacion> fichas) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: DropdownButton<FichaCaracterizacion>(
          hint: const Text('Seleccione la ficha de caracterización'),
          value: selectedFicha,
          onChanged: (FichaCaracterizacion? newValue) {
            setState(() {
              selectedFicha = newValue;
            });
          },
          items: [
            const DropdownMenuItem<FichaCaracterizacion>(
              value: null,
              child: Text('Seleccione la ficha de caracterización'),
            ),
            for (final ficha in fichas)
              DropdownMenuItem<FichaCaracterizacion>(
                value: ficha,
                child: Text('${ficha.ficha} ${ficha.nombreCurso}'),
              ),
          ],
        ),
      ),
    );
  }

  Widget seleccionarAmbiente(List<Ambiente> ambientes) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: DropdownButton<Ambiente>(
          hint: const Text('Seleccione el ambiente'),
          value: selectedAmbiente,
          onChanged: (Ambiente? newValue) {
            setState(() {
              selectedAmbiente = newValue;
            });
          },
          items: [
            const DropdownMenuItem<Ambiente>(
              value: null,
              child: Text('Seleccione el ambiente'),
            ),
            for (final ambiente in ambientes)
              DropdownMenuItem<Ambiente>(
                value: ambiente,
                child: Text(ambiente.title),
              ),
          ],
        ),
      ),
    );
  }

  void screenIndexEntradaSalida(
      FichaCaracterizacion ficha,
      LoginResponse loginResponse,
      Ambiente selectedAmbiente,
      BuildContext context) async {
    final data = await appServices.getEntradaSalida(
        loginResponse.user.id.toString(), ficha.id.toString());
    final registros = data;
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => IndexEntradaSalida(
                  loginResponse: loginResponse,
                  ficha: ficha,
                  registros: registros,
                  ambiente: selectedAmbiente,
                )));
  }
}
