import 'package:flutter/material.dart';
import 'package:registro_asistencia_sena_movil/models/login_response.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key, required this.loginResponse});
  final LoginResponse loginResponse;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text("Hola ${loginResponse.persona.primerNombre}")),);
  }
}