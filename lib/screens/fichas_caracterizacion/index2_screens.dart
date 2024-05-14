// import 'package:flutter/cupertino.dart';
// import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:registro_asistencia_sena_movil/models/ambiente_response.dart';
import 'package:registro_asistencia_sena_movil/models/bloque_response.dart';
// import 'package:registro_asistencia_sena_movil/models/departamento_response.dart';
// import 'package:flutter/widgets.dart';
import 'package:registro_asistencia_sena_movil/models/ficha_caracterizacion_response.dart';
import 'package:registro_asistencia_sena_movil/models/login_response.dart';
import 'package:registro_asistencia_sena_movil/models/municipio_response.dart';
import 'package:registro_asistencia_sena_movil/models/piso_response.dart';
import 'package:registro_asistencia_sena_movil/models/sede_response.dart';
import 'package:registro_asistencia_sena_movil/screens/entradaSalida/index_screens.dart';
import 'package:registro_asistencia_sena_movil/services/app_services.dart';
import 'package:registro_asistencia_sena_movil/utils/constantes.dart';
import 'package:registro_asistencia_sena_movil/widgets/footer.dart';
import 'package:registro_asistencia_sena_movil/widgets/header.dart';

class Index2FichaCaracterizacion extends StatefulWidget {
  const Index2FichaCaracterizacion(
      {super.key,
      required this.loginResponse,
      required this.ficha, required this.sedesResponse});
  final LoginResponse loginResponse;
  final Ficha ficha;
  final List<Sede> sedesResponse;
  @override
  State<Index2FichaCaracterizacion> createState() =>
      _Index2FichaCaracterizacionState();
}

class _Index2FichaCaracterizacionState extends State<Index2FichaCaracterizacion> {

@override
  void initState() {
    super.initState();
    // sedesResponse = null;
    bloquesResponse = null;
    pisoResponse = null;
    ambienteResponse = null;
  }


  // late List<Municipio>? municipiosResponse;
  late List<Sede> sedesResponse;
  late List<Bloque>? bloquesResponse;
  late List<Piso>? pisoResponse;
  late List<Ambiente>? ambienteResponse;
  Sede? selectedSede;
  Bloque? selectedBloque;
  Piso? selectedPiso;
  Ambiente? selecAmbiente;

  final AppServices appServices = AppServices();

  @override
  Widget build(BuildContext context) {
    // String dropdwonValue = Ficha fichas.first;
    sedesResponse = widget.sedesResponse;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(MediaQuery.of(context).size.height *
            0.1), // Establecer la altura del AppBar como el 10% del alto de la pantalla
        child: Header(loginResponse: widget.loginResponse),
      ),
      body: ListView(
        children: [
          seleccionarSede(),
          seleccionarBloque(),
          seleccionarPiso(),
          seleccionarAmbiente(),
          botonRegistros(context)

        ],
      ),
      // getList(fichas),
      bottomNavigationBar: const footer(),
    );
  }

  
  Widget seleccionarSede() {
    // if (sedesResponse == null){
    //   return Text("");
    // }
    return Card(
        child: DropdownButton<Sede>(
      padding: const EdgeInsets.all(15),
      hint: const Text('Seleccione el municipio'),
      value: selectedSede,
      onChanged: (Sede? newValue) {
        setState(() {
          selectedSede = newValue;
        });
        apiCargarBloque(selectedSede!);
      },
      items: [
        const DropdownMenuItem<Sede>(
          value: null,
          child: Text('Seleccione la sede'),
        ),
        for (final sede in sedesResponse)
          DropdownMenuItem<Sede>(
            value: sede,
            child: Text('${sede.sede} '),
          ),
      ],
    ));
  }
  
  Widget seleccionarBloque() {
    if (bloquesResponse == null){
      return const Text("");
    }
    return Card(
        child: DropdownButton<Bloque>(
      padding: const EdgeInsets.all(15),
      hint: const Text('Seleccione la sede'),
      value: selectedBloque,
      onChanged: (Bloque? newValue) {
        setState(() {
          selectedBloque = newValue;
          selectedPiso = null; // Reset piso selection
          apiCargarPiso(newValue!);
        });
        // apiCargarPiso(selectedBloque!);
      },
      items: [
        const DropdownMenuItem<Bloque>(
          value: null,
          child: Text('Seleccione el bloque'),
        ),
        for (final bloque in bloquesResponse!)
          DropdownMenuItem<Bloque>(
            value: bloque,
            child: Text('${bloque.bloque} '),
          ),
      ],
    ));
  }

  Widget seleccionarPiso() {
    if (pisoResponse == null){
      return const Text("");
    }
    return Card(
        child: DropdownButton<Piso>(
      padding: const EdgeInsets.all(15),
      hint: const Text('Seleccione el bloque'),
      value: selectedPiso,
      onChanged: (Piso? newValue) {
        setState(() {
          selectedPiso = newValue;
        });
        apiCargarAmbientes(selectedPiso!);
      },
      items: [
        const DropdownMenuItem<Piso>(
          value: null,
          child: Text('Seleccione el piso'),
        ),
        for (final piso in pisoResponse!)
          DropdownMenuItem<Piso>(
            value: piso,
            child: Text('${piso.piso} '),
          ),
      ],
    ));
  }
  Widget seleccionarAmbiente() {
    if (ambienteResponse == null){
      return const Text("");
    }
    return Card(
        child: DropdownButton<Ambiente>(
      padding: const EdgeInsets.all(15),
      hint: const Text('Seleccione el piso'),
      value: selecAmbiente,
      onChanged: (Ambiente? newValue) {
        setState(() {
          selecAmbiente = newValue;
        });
        // apiCargarAmbientes(selectedPiso!);
      },
      items: [
        const DropdownMenuItem<Ambiente>(
          value: null,
          child: Text('Seleccione el ambiente'),
        ),
        for (final ambiente in ambienteResponse!)
          DropdownMenuItem<Ambiente>(
            value: ambiente,
            child: Text('${ambiente.title} '),
          ),
      ],
    ));
  }

  ElevatedButton botonRegistros(BuildContext context) {
    return ElevatedButton(
          onPressed: () {
            // Verifica si se ha seleccionado una ficha antes de llamar a apiIndex
            // if (ficha != null) {
            //   // Llama a la función apiIndex con los parámetros necesarios
            //   apiIndex(
            //       selectedFicha!,
            //       widget.loginResponse.user.id.toString(),
            //       widget.loginResponse,
            //       context);
            // } else {
            //   // Si no se ha seleccionado ninguna ficha, muestra un mensaje o toma alguna otra acción
            //   // Por ejemplo, podrías mostrar un SnackBar para notificar al usuario que debe seleccionar una ficha
            //   ScaffoldMessenger.of(context).showSnackBar(
            //     const SnackBar(
            //       content: Text('Seleccione una ficha antes de continuar.'),
            //     ),
            //   );
            // }
          },
          child: const Icon(Icons.list_outlined),
        );
  }


  apiCargarSedes(Municipio municipio) async {
   final data = await appServices.getSedes(municipio);
   if (data.isNotEmpty){
    setState(() {
      sedesResponse = data;
    });
   }
  }

apiCargarBloque(Sede selectedSede) async {
   final data = await appServices.getBloques(selectedSede);
   if (data.isNotEmpty) {
    setState(() {
      bloquesResponse = data;
    });
   }
    
  }

  apiCargarPiso(Bloque selectedBloque) async {
    final data = await appServices.getPisos(selectedBloque);
    if (data.isNotEmpty){
      setState(() {
        pisoResponse = data;
      });
    }
  }

  apiCargarAmbientes(Piso selectedPiso) async {
    final data = await appServices.getAmbientes(selectedPiso);
     if ( data.isNotEmpty ){
      setState(() {
        ambienteResponse = data;
      });
     }
  }

  void apiIndex(Ficha selectedFicha, String instructorId,LoginResponse loginResponse, BuildContext context) async {
    final dio = Dio();
    try {
      final response = await dio.get(
          "${Constantes.baseUrl}/fichaCaracterizacion/apiIndex/",
          data: {'instructor_id': instructorId, 'ficha_id': selectedFicha.id});
      // print(response);
      if (response.statusCode == 200) {
        final fichaCaracterizacion = FichaCaracterizacion.fromJson(response.data);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => IndexEntradaSalida(
                      loginResponse: loginResponse,
                      ficha: selectedFicha,
                    )));
        print(fichaCaracterizacion);

      }
    } catch (e) {
      // print("Error en las credenciales: $e");

    }
  }
}
