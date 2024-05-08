import 'package:flutter/material.dart';
import 'package:registro_asistencia_sena_movil/models/ficha_caracterizacion.dart';
import 'package:registro_asistencia_sena_movil/models/login_response.dart';
import 'package:registro_asistencia_sena_movil/widgets/footer.dart';
import 'package:registro_asistencia_sena_movil/widgets/header.dart';

class IndexFichaCaracterizacion extends StatelessWidget {
  const IndexFichaCaracterizacion({super.key, required this.loginResponse, required this.fichaCaracterizacion});
  final LoginResponse loginResponse;
  final FichaCaracterizacion fichaCaracterizacion;

  @override
  Widget build(BuildContext context) {
    List<Ficha> fichas = fichaCaracterizacion.fichas;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(MediaQuery.of(context).size.height *
            0.1), // Establecer la altura del AppBar como el 10% del alto de la pantalla
        child: Header(loginResponse: loginResponse),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Fichas de caracterización", style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold
            ),),
            FloatingActionButton(onPressed: () {}),
            Card(
              child: Container(
                padding: const EdgeInsets.all(15),
                child: Table(
                  border: TableBorder.all(),
                  columnWidths: const <int, TableColumnWidth>{
                    0: FlexColumnWidth(),
                    1: FlexColumnWidth(),
                    2: FlexColumnWidth(),
                    3: FlexColumnWidth(),
                    // 4: FlexColumnWidth(),
                  },
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children:[
                    const TableRow(
                      children: <Widget>[
                        Text("#", style: TextStyle(fontWeight: FontWeight.bold),),
                        Text("No. ficha",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                        Text("Nombre curso",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                        Text("ambiente",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      //   Text("Municipio",
                      //   style: TextStyle(fontWeight: FontWeight.bold),
                      // )
                        // #, No ficha, nombrecurso, ambiente, municipio, boton ver, boton lista
                      ]
                    ),
                     for (final ficha in fichas)
                      TableRow(
                        children: <Widget>[
                          Text(ficha.id.toString()),
                          Text(ficha.ficha),
                          Text(ficha.nombreCurso),
                          Text(ficha.ambienteId.toString()),
                          // Text(ficha.)
                        ],
                      ),
                    
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const footer(),
    );
  }
}
