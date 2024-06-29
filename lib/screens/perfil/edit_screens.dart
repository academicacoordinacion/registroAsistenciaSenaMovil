import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:registro_asistencia_sena_movil/models/entrada_salida_response.dart';
import 'package:registro_asistencia_sena_movil/models/login_response.dart';
import 'package:registro_asistencia_sena_movil/services/app_services.dart';
import 'package:registro_asistencia_sena_movil/widgets/header.dart';

class EditPerfil extends StatefulWidget {
  const EditPerfil({
    Key? key,
    required this.loginResponse,
  }) : super(key: key);

  final LoginResponse loginResponse;

  @override
  State<EditPerfil> createState() => _EditPerfilState();
}

class _EditPerfilState extends State<EditPerfil> {
  late List<EntradaSalida?> registros;
  final AppServices appServices = AppServices();

  late TextEditingController _primerNombreController;
  late TextEditingController _segundoNombreController;
  late TextEditingController _primerApellidoController;
  late TextEditingController _segundoApellidoController;
  late TextEditingController _tipoDocumentoController;
  late TextEditingController _numeroDocumentoController;
  late TextEditingController _fechaDeNacimientoController;
  late TextEditingController _generoController;
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _primerNombreController = TextEditingController(
        text: widget.loginResponse.persona?.primerNombre ?? "");
    _segundoNombreController = TextEditingController(
        text: widget.loginResponse.persona?.segundoNombre ?? "");
    _primerApellidoController = TextEditingController(
        text: widget.loginResponse.persona?.primerApellido ?? "");
    _segundoApellidoController = TextEditingController(
        text: widget.loginResponse.persona?.segundoApellido ?? "");
    _tipoDocumentoController = TextEditingController(
        text: widget.loginResponse.persona?.tipoDocumento ?? "");
    _numeroDocumentoController = TextEditingController(
        text: widget.loginResponse.persona?.numeroDocumento ?? "");
    _fechaDeNacimientoController = TextEditingController(
        text: widget.loginResponse.persona?.fechaDeNacimiento != null
            ? DateFormat('yyyy-MM-dd')
                .format(widget.loginResponse.persona!.fechaDeNacimiento!)
            : "");
    _generoController =
        TextEditingController(text: widget.loginResponse.persona?.genero ?? "");
    _emailController =
        TextEditingController(text: widget.loginResponse.persona?.email ?? "");
  }

  @override
  void dispose() {
    _primerNombreController.dispose();
    _segundoNombreController.dispose();
    _primerApellidoController.dispose();
    _segundoApellidoController.dispose();
    _tipoDocumentoController.dispose();
    _numeroDocumentoController.dispose();
    _fechaDeNacimientoController.dispose();
    _generoController.dispose();
    _emailController.dispose();
    super.dispose();
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
                            _primerNombreController,
                          ),
                          const Divider(),
                          _buildProfileRow(
                            Icons.person,
                            "Segundo Nombre",
                            _segundoNombreController,
                          ),
                          const Divider(),
                          _buildProfileRow(
                            Icons.person,
                            "Primer Apellido",
                            _primerApellidoController,
                          ),
                          const Divider(),
                          _buildProfileRow(
                            Icons.person,
                            "Segundo Apellido",
                            _segundoApellidoController,
                          ),
                          const Divider(),
                          _buildProfileRow(
                            Icons.assignment_ind,
                            "Tipo de documento",
                            _tipoDocumentoController,
                          ),
                          const Divider(),
                          _buildProfileRow(
                            Icons.assignment,
                            "Número de documento",
                            _numeroDocumentoController,
                          ),
                          const Divider(),
                          _buildDatePickerRow(
                            Icons.cake,
                            "Fecha de Nacimiento",
                            _fechaDeNacimientoController,
                          ),
                          const Divider(),
                          _buildProfileRow(
                            Icons.wc,
                            "Genero",
                            _generoController,
                          ),
                          const Divider(),
                          _buildProfileRow(
                            Icons.email,
                            "Correo Institucional",
                            _emailController,
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
                  // guardar cambios
                },
                child: const Icon(Icons.save),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileRow(
      IconData icon, String label, TextEditingController controller,
      {bool isDate = false}) {
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
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: label,
          ),
        ),
      ],
    );
  }

  Widget _buildDatePickerRow(
      IconData icon, String label, TextEditingController controller) {
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
        GestureDetector(
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime(2100),
            );
            if (pickedDate != null) {
              setState(() {
                controller.text = DateFormat('yyyy-MM-dd').format(pickedDate);
              });
            }
          },
          child: AbsorbPointer(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: label,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
