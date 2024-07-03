import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:registro_asistencia_sena_movil/models/entrada_salida_response.dart';
import 'package:registro_asistencia_sena_movil/models/genero_response.dart';
import 'package:registro_asistencia_sena_movil/models/login_response.dart';
import 'package:registro_asistencia_sena_movil/models/tipo_de_documentos_response.dart';
import 'package:registro_asistencia_sena_movil/screens/perfil/show_screens.dart';
import 'package:registro_asistencia_sena_movil/services/app_services.dart';
import 'package:registro_asistencia_sena_movil/widgets/header.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditPerfil extends StatefulWidget {
  const EditPerfil({
    Key? key,
    required this.loginResponse,
    required this.generoResponse,
    required this.tipoDocumentoResponse,
  }) : super(key: key);

  final LoginResponse loginResponse;
  final List<GeneroResponse> generoResponse;
  final List<TipoDocumentoResponse> tipoDocumentoResponse;

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
  late TextEditingController _numeroDocumentoController;
  late TextEditingController _fechaDeNacimientoController;
  late TextEditingController _emailController;

  String? _selectedTipoDocumento;
  String? _selectedGenero;

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
    _numeroDocumentoController = TextEditingController(
        text: widget.loginResponse.persona?.numeroDocumento ?? "");
    _fechaDeNacimientoController = TextEditingController(
        text: widget.loginResponse.persona?.fechaDeNacimiento != null
            ? DateFormat('yyyy-MM-dd')
                .format(widget.loginResponse.persona!.fechaDeNacimiento!)
            : "");
    _emailController =
        TextEditingController(text: widget.loginResponse.persona?.email ?? "");

    // Inicialización de los selectores
    _selectedTipoDocumento = widget.tipoDocumentoResponse
        .firstWhere(
            (tipo) => tipo.name == widget.loginResponse.persona?.tipoDocumento,
            orElse: () => widget.tipoDocumentoResponse.first)
        .id
        .toString();

    _selectedGenero = widget.generoResponse
        .firstWhere(
            (genero) => genero.name == widget.loginResponse.persona?.genero,
            orElse: () => widget.generoResponse.first)
        .id
        .toString();
  }

  @override
  void dispose() {
    _primerNombreController.dispose();
    _segundoNombreController.dispose();
    _primerApellidoController.dispose();
    _segundoApellidoController.dispose();
    _numeroDocumentoController.dispose();
    _fechaDeNacimientoController.dispose();
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
                          _buildDropdownRow(
                            Icons.assignment_ind,
                            "Tipo de documento",
                            _selectedTipoDocumento,
                            widget.tipoDocumentoResponse,
                            (String? newValue) {
                              setState(() {
                                _selectedTipoDocumento = newValue;
                              });
                            },
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
                          _buildDropdownRow(
                            Icons.wc,
                            "Genero",
                            _selectedGenero,
                            widget.generoResponse,
                            (String? newValue) {
                              setState(() {
                                _selectedGenero = newValue;
                              });
                            },
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
                  // debug(_selectedGenero.toString(), _selectedTipoDocumento.toString());
                  updatePerfil(
                    widget.loginResponse.persona.id.toString(),
                    _selectedTipoDocumento.toString(),
                    _numeroDocumentoController
                        .text, // Cambiar a text en lugar de toString
                    _primerNombreController
                        .text, // Cambiar a text en lugar de toString
                    _segundoNombreController
                        .text, // Cambiar a text en lugar de toString
                    _primerApellidoController
                        .text, // Cambiar a text en lugar de toString
                    _segundoApellidoController
                        .text, // Cambiar a text en lugar de toString
                    _fechaDeNacimientoController
                        .text, // Cambiar a text en lugar de toString
                    _selectedGenero.toString(),
                    _emailController
                        .text, // Cambiar a text en lugar de toString
                    widget.loginResponse.token,
                  );
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

  Widget _buildDropdownRow(
    IconData icon,
    String label,
    String? selectedValue,
    List<dynamic> items,
    ValueChanged<String?> onChanged,
  ) {
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
        DropdownButton<String>(
          value: selectedValue,
          onChanged: onChanged,
          items: items.map<DropdownMenuItem<String>>((dynamic item) {
            return DropdownMenuItem<String>(
              value: item.id.toString(),
              child: Text(item.name),
            );
          }).toList(),
        ),
      ],
    );
  }

  void updatePerfil(
      String personaID,
      String tipoDocumento,
      String numeroDocumento,
      String primerNombre,
      String? segundoNombre,
      String primerApellido,
      String? segundoApellido,
      String fechaDeNacimiento,
      String genero,
      String email,
      String authToken) async {
    try {
      final loginResponse = await apiUpdatePerfil(
          personaID,
          tipoDocumento,
          numeroDocumento,
          primerNombre,
          segundoNombre,
          primerApellido,
          segundoApellido,
          fechaDeNacimiento,
          genero,
          email,
          authToken);
      if (loginResponse != null) {
        // Obtener la instancia de SharedPreferences
        final prefs = await SharedPreferences.getInstance();
          debugPrint(prefs.toString());
        // Eliminar la preferencia existente (si es necesario)
        await prefs.remove('loginResponse');
        
        // Guardar la nueva respuesta en SharedPreferences
        String loginResponseJson = jsonEncode(loginResponse.toJson());
        await prefs.setString('loginResponse', loginResponseJson);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ShowPerfil(
              loginResponse: loginResponse,
            ),
          ),
        );
      }
    } catch (e) {
      print("error de actualizacion: ${e}");
    }
  }

  Future<LoginResponse?> apiUpdatePerfil(
      String personaID,
      String tipoDocumento,
      String numeroDocumento,
      String primerNombre,
      String? segundoNombre,
      String primerApellido,
      String? segundoApellido,
      String fechaDeNacimiento,
      String genero,
      String email,
      String authToken) async {
    try {
      final data = await appServices.updatePerfil(
          personaID,
          tipoDocumento,
          numeroDocumento,
          primerNombre,
          segundoNombre,
          primerApellido,
          segundoApellido,
          fechaDeNacimiento,
          genero,
          email,
          authToken);
      return data;
    } catch (e) {
      print("la otra parada ${e}");
      // return [];
    }
  }
}
