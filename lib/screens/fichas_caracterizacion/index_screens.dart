// import 'package:flutter/cupertino.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:registro_asistencia_sena_movil/models/departamento_response.dart';
// import 'package:flutter/widgets.dart';
import 'package:registro_asistencia_sena_movil/models/ficha_caracterizacion_response.dart';
import 'package:registro_asistencia_sena_movil/models/login_response.dart';
import 'package:registro_asistencia_sena_movil/models/municipio_response.dart';
import 'package:registro_asistencia_sena_movil/screens/entradaSalida/index_screens.dart';
import 'package:registro_asistencia_sena_movil/utils/constantes.dart';
import 'package:registro_asistencia_sena_movil/widgets/footer.dart';
import 'package:registro_asistencia_sena_movil/widgets/header.dart';

class IndexFichaCaracterizacion extends StatefulWidget {
  const IndexFichaCaracterizacion(
      {super.key,
      required this.loginResponse,
      required this.fichaCaracterizacion, required this.departamento});
  final LoginResponse loginResponse;
  final FichaCaracterizacion fichaCaracterizacion;
  final Departamento departamento;
  @override
  State<IndexFichaCaracterizacion> createState() =>
      _IndexFichaCaracterizacionState();
}

class _IndexFichaCaracterizacionState extends State<IndexFichaCaracterizacion> {
  Ficha? selectedFicha;
  DepartamentoModel? selectedDepartamento;

  @override
  Widget build(BuildContext context) {
    List<Ficha> fichas = widget.fichaCaracterizacion.fichas;
    List<DepartamentoModel> departamentos = widget.departamento.departamentos;
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
          // Card(
          //  child: Text(
          //     selectedDepartamento == null
          //         ? "No hay departamento seleccionado"
          //         : selectedDepartamento!.id.toString(),
          //   ),
          // ),
          botonRegistros(context)

        ],
      ),
      // getList(fichas),
      bottomNavigationBar: const footer(),
    );
  }

  Card seleccionarDepartamento(List<DepartamentoModel> departamentos) {
    return Card(
      child: DropdownButton<DepartamentoModel>(
    padding: const EdgeInsets.all(15),
    hint: const Text('Seleccione la ficha de caracterización'),
    value: selectedDepartamento,
    onChanged: (DepartamentoModel? newValue) {
      setState(() {
        selectedDepartamento = newValue;
      });
      apiCargarMunicipios(selectedDepartamento!);
    },
    items: [
      const DropdownMenuItem<DepartamentoModel>(
        value: null,
        child: Text('Seleccione el departamento'),
      ),
      for (final departamento in departamentos)
        DropdownMenuItem<DepartamentoModel>(
          value: departamento,
          child: Text('${departamento.departamento} '),
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
              apiIndex(
                  selectedFicha!,
                  widget.loginResponse.user.id.toString(),
                  widget.loginResponse,
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
          child: const Icon(Icons.list_outlined),
        );
  }

  Card seleccionarFicha(List<Ficha> fichas) {
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
  void apiCargarMunicipios(DepartamentoModel selectedDepartamento) async {
    final dio = Dio();
      try {
        final response = await dio.get(
          "${Constantes.baseUrl}/api/apiCargarMunicipios",
          data: {'departamento_id': selectedDepartamento.id });
          if (response.statusCode == 200) {
          final municipiosResponse =
            Municipio.fromJson(response.data);
          print(municipiosResponse);
          }
      }catch(e){

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
