// import 'package:flutter/cupertino.dart';
// import 'dart:math';

import 'package:dio/dio.dart';
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
import 'package:registro_asistencia_sena_movil/screens/fichas_caracterizacion/index2_screens.dart';
import 'package:registro_asistencia_sena_movil/services/app_services.dart';
import 'package:registro_asistencia_sena_movil/utils/constantes.dart';
import 'package:registro_asistencia_sena_movil/widgets/footer.dart';
import 'package:registro_asistencia_sena_movil/widgets/header.dart';

class IndexFichaCaracterizacion extends StatefulWidget {
  const IndexFichaCaracterizacion(
      {super.key,
      required this.loginResponse,
      required this.fichaCaracterizacion,
      required this.departamentos});
  final LoginResponse loginResponse;
  final FichaCaracterizacion fichaCaracterizacion;
  final List<Departamento> departamentos;
  @override
  State<IndexFichaCaracterizacion> createState() =>
      _IndexFichaCaracterizacionState();
}

class _IndexFichaCaracterizacionState extends State<IndexFichaCaracterizacion> {
  @override
  void initState() {
    super.initState();
    municipiosResponse = null;
    sedesResponse = null;
    bloquesResponse = null;
    pisoResponse = null;
    ambienteResponse = null;
  }

  Ficha? selectedFicha;
  Departamento? selectedDepartamento;
  late List<Municipio>? municipiosResponse;
  late List<Sede>? sedesResponse;
  late List<Bloque>? bloquesResponse;
  late List<Piso>? pisoResponse;
  late List<Ambiente>? ambienteResponse;
  Municipio? selectedMunicipio;
  Sede? selectedSede;
  Bloque? selectedBloque;
  Piso? selectedPiso;
  Ambiente? selecAmbiente;

  final AppServices appServices = AppServices();

  @override
  Widget build(BuildContext context) {
    List<Ficha> fichas = widget.fichaCaracterizacion.fichas;
    List<Departamento> departamentos = widget.departamentos;

    // String dropdwonValue = Ficha fichas.first;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(MediaQuery.of(context).size.height *
            0.1), // Establecer la altura del AppBar como el 10% del alto de la pantalla
        child: Header(loginResponse: widget.loginResponse),
      ),
      body: ListView(
        children: [
          seleccionarFicha(fichas),
          seleccionarDepartamento(departamentos),
          seleccionarMunicipio(),
          botonRegistros(context)
        ],
      ),
      // getList(fichas),
      bottomNavigationBar: const footer(),
    );
  }

  Widget seleccionarDepartamento(List<Departamento> departamentos) {
    return Card(
        child: DropdownButton<Departamento>(
      padding: const EdgeInsets.all(15),
      hint: const Text('Seleccione la ficha de caracterización'),
      value: selectedDepartamento,
      onChanged: (Departamento? newValue) {
        setState(() {
          selectedDepartamento = newValue;
          selectedMunicipio = null;
          selectedSede = null;
        });
        apiCargarMunicipios(selectedDepartamento!);
      },
      items: [
        const DropdownMenuItem<Departamento>(
          value: null,
          child: Text('Seleccione el departamento'),
        ),
        for (final departamento in departamentos)
          DropdownMenuItem<Departamento>(
            value: departamento,
            child: Text('${departamento.departamento} '),
          ),
      ],
    ));
  }

  Widget seleccionarMunicipio() {
    if (municipiosResponse == null) {
      return const Text("");
    }
    return Card(
        child: DropdownButton<Municipio>(
      padding: const EdgeInsets.all(15),
      hint: const Text('Seleccione el departamento'),
      value: selectedMunicipio,
      onChanged: (Municipio? newValue) {
        setState(() {
          selectedMunicipio = newValue;
          selectedSede = null;
        });
        apiCargarSedes(selectedMunicipio!);
      },
      items: [
        const DropdownMenuItem<Municipio>(
          value: null,
          child: Text('Seleccione el municipio'),
        ),
        for (final municipio in municipiosResponse!)
          DropdownMenuItem<Municipio>(
            value: municipio,
            child: Text('${municipio.municipio} '),
          ),
      ],
    ));
  }

  ElevatedButton botonRegistros(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Verifica si se ha seleccionado una ficha antes de llamar a apiIndex
        if (selectedFicha != null) {
          // Llama a la función apiIndex con los parámetros necesarios
          nextScreeenIndexFichaCaracterizacion(
              selectedFicha!,
              widget.loginResponse,
              sedesResponse!,
              context);
        } else {
          // Si no se ha seleccionado ninguna ficha, muestra un mensaje o toma alguna otra acción
          // Por ejemplo, podrías mostrar un SnackBar para notificar al usuario que debe seleccionar una ficha
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Seleccione una ficha antes de continuar.'),
            ),
          );
        }
      },
      child: const Icon(Icons.navigate_next),
    );
  }

  Widget seleccionarFicha(List<Ficha> fichas) {
    return Card(
        child: DropdownButton<Ficha>(
      padding: const EdgeInsets.all(15),
      hint: const Text('Seleccione la ficha de caracterización'),
      value: selectedFicha,
      onChanged: (Ficha? newValue) {
        setState(() {
          selectedFicha = newValue;
        });
      },
      items: [
        const DropdownMenuItem<Ficha>(
          value: null,
          child: Text('Seleccione la ficha de caracterización'),
        ),
        for (final ficha in fichas)
          DropdownMenuItem<Ficha>(
            value: ficha,
            child: Text('${ficha.ficha} ${ficha.nombreCurso} '),
          ),
      ],
    ));
  }

  apiCargarMunicipios(Departamento selectedDepartamento) async {
    final data = await appServices.getMunicipios(selectedDepartamento);
    // print(data);
    if (data.isNotEmpty) {
      setState(() {
        municipiosResponse = data;
      });
    }
  }

  apiCargarSedes(Municipio selectedMunicipio) async {
    final data = await appServices.getSedes(selectedMunicipio);
    if (data.isNotEmpty) {
      setState(() {
        sedesResponse = data;
      });
    }
  }

  void nextScreeenIndexFichaCaracterizacion(
      Ficha selectedFicha,
      LoginResponse loginResponse,
      List<Sede> sedesResponse,
      BuildContext context) async {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Index2FichaCaracterizacion(
                  loginResponse: loginResponse,
                  ficha: selectedFicha, sedesResponse: sedesResponse,
                )));
  }
}
