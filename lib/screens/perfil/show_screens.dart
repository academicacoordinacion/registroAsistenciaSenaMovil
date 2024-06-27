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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Text(
                      "Mi perfil",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              child: Container(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                              "Primer Nombre: ${widget.loginResponse.persona.primerNombre}"),
                        ),
                      ),
                    ),
                    Divider(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                              "Segundo Nombre: ${widget.loginResponse.persona.segundoNombre}"),
                        ),
                      ),
                    ),
                    Divider(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                              "Primer Apellido: ${widget.loginResponse.persona.primerApellido}"),
                        ),
                      ),
                    ),
                    Divider(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                              "Segundo Apellido: ${widget.loginResponse.persona.segundoApellido}"),
                        ),
                      ),
                    ),
                    Divider(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                              "Tipo de documento: ${widget.loginResponse.persona.tipoDocumento}"),
                        ),
                      ),
                    ),
                    Divider(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                              "Número de documento: ${widget.loginResponse.persona.numeroDocumento}"),
                        ),
                      ),
                    ),
                    Divider(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                              "Fecha de Nacimiento: ${widget.loginResponse.persona.fechaDeNacimiento}"),
                        ),
                      ),
                    ),
                    Divider(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                              "Genero: ${widget.loginResponse.persona.genero}"),
                        ),
                      ),
                    ),
                    Divider(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                              "Correo Institucional: ${widget.loginResponse.persona.email}"),
                        ),
                      ),
                    ),
                    Divider(),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text("ya veremos como hacemos esto"),
                    ],
                  ),
                ),
              ),
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
                onPressed: () {
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
