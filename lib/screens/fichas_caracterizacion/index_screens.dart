// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
import 'package:registro_asistencia_sena_movil/models/ficha_caracterizacion.dart';
import 'package:registro_asistencia_sena_movil/models/login_response.dart';
import 'package:registro_asistencia_sena_movil/widgets/footer.dart';
import 'package:registro_asistencia_sena_movil/widgets/header.dart';

class IndexFichaCaracterizacion extends StatefulWidget {
  const IndexFichaCaracterizacion({super.key, required this.loginResponse, required this.fichaCaracterizacion});
  final LoginResponse loginResponse;
  final FichaCaracterizacion fichaCaracterizacion;

  @override
  State<IndexFichaCaracterizacion> createState() => _IndexFichaCaracterizacionState();
}

class _IndexFichaCaracterizacionState extends State<IndexFichaCaracterizacion> {

  int? idDepartamento = null;

  @override
  Widget build(BuildContext context) {
    List<Ficha> fichas = widget.fichaCaracterizacion.fichas;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(MediaQuery.of(context).size.height *
            0.1), // Establecer la altura del AppBar como el 10% del alto de la pantalla
        child: Header(loginResponse: widget.loginResponse),
      ),
      body: getList(fichas),
      bottomNavigationBar: const footer(),
    );

  }
  Widget getList(List<Ficha> fichas) {
  return ListView.builder(
    itemCount: fichas.length,
    itemBuilder: (context, index) {
      return _getItem(fichas[index]);
    },
  );
}

Widget _getItem(Ficha ficha) {
  return Card(
    child: ListTile(
      title: Text(ficha.nombreCurso),
      subtitle: Text(ficha.ficha),
    ),
  );
}

}