import 'package:flutter/material.dart';
import 'package:registro_asistencia_sena_movil/models/entrada_salida_response.dart';
import 'package:registro_asistencia_sena_movil/models/login_response.dart';
import 'package:registro_asistencia_sena_movil/services/app_services.dart';
import 'package:registro_asistencia_sena_movil/widgets/header.dart';

class ShowPerfil extends StatefulWidget {
  const ShowPerfil({
    Key? key,
    required this.loginResponse,
  }) : super(key: key);

  final LoginResponse loginResponse;

  @override
  State<ShowPerfil> createState() => _ShowPerfilState();
}

class _ShowPerfilState extends State<ShowPerfil> {
  late List<EntradaSalida?> registros;
  final AppServices appServices = AppServices();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.1),
        child: Header(loginResponse: widget.loginResponse),
      ),
      body: const SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                  Text("Aquí ira el contenido del perfil")
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: const Text("ya veremos como hacemos esto"),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.grey.shade200,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              
              ElevatedButton(
                onPressed: (){
                  // redirigir a la screen de editar perfil
                },
                child: const Icon(Icons.edit),
              ),
              
            ],
          ),
        ),
      ),
    );
  }

}
