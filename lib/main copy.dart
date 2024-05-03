import 'package:flutter/material.dart';
import 'package:registro_asistencia_sena_movil/screens/home_screens.dart';
// import 'package:registro_asistencia_sena_movil/screens/inicio_sesion_screens.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key}); // Corrected constructor

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // Removed const keyword
      debugShowCheckedModeBanner: false,
      home: Home(), 
      // InicioSesion(),
    );
  }
}

