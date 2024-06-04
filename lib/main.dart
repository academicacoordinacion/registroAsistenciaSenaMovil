import 'package:flutter/material.dart';
import 'package:registro_asistencia_sena_movil/models/login_response.dart';
import 'package:registro_asistencia_sena_movil/screens/dashboard_screens.dart';
import 'package:registro_asistencia_sena_movil/screens/inicio_sesion_screens.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LoginResponse? loginResponse = await InicioSesion.getLoginResponse();

  runApp(MyApp(loginResponse: loginResponse));
}

class MyApp extends StatelessWidget {
  final LoginResponse? loginResponse;

  const MyApp({super.key, this.loginResponse});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Registro Asistencia SENA',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: loginResponse != null
          ? DashboardScreen(loginResponse: loginResponse!)
          : InicioSesion(),
    );
  }
}
