// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
import 'package:registro_asistencia_sena_movil/models/ficha_caracterizacion_response.dart';
import 'package:registro_asistencia_sena_movil/models/login_response.dart';
import 'package:registro_asistencia_sena_movil/widgets/footer.dart';
import 'package:registro_asistencia_sena_movil/widgets/header.dart';

class ShowFichaCaracterizacion extends StatelessWidget {
  const ShowFichaCaracterizacion({super.key, required this.loginResponse, required this.fichaCaracterizacion});
  final LoginResponse loginResponse;
  final List<FichaCaracterizacion> fichaCaracterizacion;
  @override
  Widget build(BuildContext context) {
    List<FichaCaracterizacion> fichas = fichaCaracterizacion;
    // int no = 1;
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
            ElevatedButton(onPressed: () {}, child: const Icon(Icons.library_add_sharp)),
            SingleChildScrollView(
              child: Card(
                child: Container(
                  padding: const EdgeInsets.all(15),
                  child: Table(
                    border: TableBorder.all(),
                    columnWidths: const <int, TableColumnWidth>{
                      0: FlexColumnWidth(),
                      1: FlexColumnWidth(),
                      2: FlexColumnWidth(),
                      3: FlexColumnWidth(),
                      4: FlexColumnWidth(),
                      5: FixedColumnWidth(100), // Ancho fijo para los botones
                    },
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    children: [
                      const TableRow(
                        children: <Widget>[
                          Text("No. ficha",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Text("Nombre curso",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Text("Ambiente",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Text("Municipio",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Text(" ",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                      for (final ficha in fichas)
                        TableRow(
                          children: <Widget>[
                            Text(ficha.ficha),
                            Text(ficha.nombreCurso),
                            Text(ficha.regional),
                            // Text(ficha.),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ElevatedButton(
                                  onPressed: () {},
                                  child:
                                      const Icon(Icons.remove_red_eye_outlined),
                                ),
                                const SizedBox(
                                    width: 8), // Espacio entre los botones
                                ElevatedButton(
                                  onPressed: () {},
                                  child: const Icon(Icons.list_alt),
                                ),
                              ],
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
      bottomNavigationBar: const footer(),
    );
  }





//   // Show ficha caracterizacion
//   void apiShow( Ficha ficha ,BuildContext context) async {
   
//         Navigator.push(
//             context,
//             MaterialPageRoute(
//                 builder: (context) => ShowFichaCaracterizacion(
//                       loginResponse: loginResponse, fichaCaracterizacion: fichaCaracterizacion,
//                     )));
//         print(fichaCaracterizacion);

        
//       }
//     } catch (e) {
//       print("Error en las credenciales: $e");

      
//     }
//   }


}