// import 'package:flutter/cupertino.dart';
// import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
import 'package:registro_asistencia_sena_movil/models/ficha_caracterizacion_response.dart';
import 'package:registro_asistencia_sena_movil/models/login_response.dart';
// import 'package:registro_asistencia_sena_movil/utils/constantes.dart';
import 'package:registro_asistencia_sena_movil/widgets/footer.dart';
import 'package:registro_asistencia_sena_movil/widgets/header.dart';

class IndexEntradaSalida extends StatefulWidget {
  const IndexEntradaSalida(
      {super.key,
      required this.loginResponse,
      required this.ficha});
  final LoginResponse loginResponse;
  final Ficha ficha;

  @override
  State<IndexEntradaSalida> createState() =>
      _IndexEntradaSalidaState();
}
class _IndexEntradaSalidaState extends State<IndexEntradaSalida> {
  @override
  Widget build(BuildContext context) {
    Ficha ficha = widget.ficha; // Obtener la ficha del widget

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
                // Agrega más widgets Text para mostrar otras propiedades de la ficha según sea necesario
              ],
            ),
          ),
          ElevatedButton(
              onPressed: () {}, child: const Icon(Icons.list_outlined))
        ],
      ),
      bottomNavigationBar: const footer(),
    );
  }
}
//   Widget getList(List<Ficha> fichas) {
//   return ListView.builder(
//     itemCount: fichas.length,
//     itemBuilder: (context, index) {
//       return
//       _getItem(fichas[index])
//       // DropdownMenuItem(child: _getItem(fichas[index]))
//       ;
//     },
//   );
// }

// Widget _getItem(Ficha ficha) {
//   return Card(
//     child: ListTile(
//       // title: Text(ficha.nombreCurso),
//       // subtitle: Text(ficha.ficha),
//       trailing: DropdownButton<Ficha>(
//               value: null,
//               onChanged: (Ficha? newValue) {
//                 // Implementa la lógica para manejar el cambio de selección
//               },
//               items: fichas.map<DropdownMenuItem<Ficha>>((Ficha ficha) {
//                 return DropdownMenuItem<Ficha>(
//                   value: ficha,
//                   child: Text('${ficha.nombreCurso} - ${ficha.ficha}'),
//                 );
//               }).toList(),
//     ),
//   );
// }
  

