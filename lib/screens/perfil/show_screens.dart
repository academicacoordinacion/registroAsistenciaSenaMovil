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
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        "Mi perfil",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildProfileRow(
                            Icons.person,
                            "Primer Nombre",
                            widget.loginResponse.persona?.primerNombre ?? "",
                          ),
                          const Divider(),
                          _buildProfileRow(
                            Icons.person,
                            "Segundo Nombre",
                            widget.loginResponse.persona?.segundoNombre ?? "",
                          ),
                          const Divider(),
                          _buildProfileRow(
                            Icons.person,
                            "Primer Apellido",
                            widget.loginResponse.persona?.primerApellido ?? "",
                          ),
                          const Divider(),
                          _buildProfileRow(
                            Icons.person,
                            "Segundo Apellido",
                            widget.loginResponse.persona?.segundoApellido ?? "",
                          ),
                          const Divider(),
                          _buildProfileRow(
                            Icons.assignment_ind,
                            "Tipo de documento",
                            widget.loginResponse.persona?.tipoDocumento ?? "",
                          ),
                          const Divider(),
                          _buildProfileRow(
                            Icons.assignment,
                            "Número de documento",
                            widget.loginResponse.persona?.numeroDocumento ?? "",
                          ),
                          const Divider(),
                          _buildProfileRow(
                            Icons.cake,
                            "Fecha de Nacimiento",
                            widget.loginResponse.persona?.fechaDeNacimiento
                                    ?.toString() ??
                                "",
                          ),
                          const Divider(),
                          _buildProfileRow(
                            Icons.wc,
                            "Genero",
                            widget.loginResponse.persona?.genero ?? "",
                          ),
                          const Divider(),
                          _buildProfileRow(
                            Icons.email,
                            "Correo Institucional",
                            widget.loginResponse.persona?.email ?? "",
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
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

  Widget _buildProfileRow(IconData icon, String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: Colors.blueAccent),
            const SizedBox(width: 10),
            Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Text(
          value,
          style: const TextStyle(color: Colors.grey),
        ),
      ],
    );
  }
}
