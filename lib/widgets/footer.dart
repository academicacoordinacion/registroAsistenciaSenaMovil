import 'package:flutter/material.dart';


// ignore: camel_case_types
class footer extends StatelessWidget {
  const footer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const BottomAppBar(
      child: SizedBox(
        height: 50.0, // Altura deseada del footer
        child: Center(
          child: Text(
            'Desarrollado por: William Lopez Rebellon',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
