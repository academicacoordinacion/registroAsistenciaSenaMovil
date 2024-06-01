import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:registro_asistencia_sena_movil/models/ambiente_response.dart';
import 'package:registro_asistencia_sena_movil/models/ficha_caracterizacion_response.dart';
import 'package:registro_asistencia_sena_movil/models/login_response.dart';
import 'package:registro_asistencia_sena_movil/screens/entradaSalida/index_screens.dart';
import 'package:registro_asistencia_sena_movil/services/app_services.dart';
import 'package:registro_asistencia_sena_movil/widgets/footer.dart';
import 'package:registro_asistencia_sena_movil/widgets/header.dart';

class IndexFichaCaracterizacion extends StatefulWidget {
  const IndexFichaCaracterizacion({
    super.key,
    required this.loginResponse,
    required this.fichasCaracterizacion,
    required this.ambientes,
  });

  final LoginResponse loginResponse;
  final List<FichaCaracterizacion> fichasCaracterizacion;
  final List<Ambiente> ambientes;

  @override
  State<IndexFichaCaracterizacion> createState() =>
      _IndexFichaCaracterizacionState();
}

class _IndexFichaCaracterizacionState extends State<IndexFichaCaracterizacion> {
  FichaCaracterizacion? selectedFicha;
  Ambiente? selectedAmbiente;

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
      body: ListView(
        children: [
          seleccionarFicha(widget.fichasCaracterizacion),
          seleccionarAmbiente(widget.ambientes),
          botonRegistros(context),
        ],
      ),
      bottomNavigationBar: const footer(),
    );
  }

  ElevatedButton botonRegistros(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (selectedFicha != null && selectedAmbiente != null) {
          screenIndexEntradaSalida(
              selectedFicha!, widget.loginResponse, selectedAmbiente!, context);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                  'Seleccione una ficha y un ambiente antes de continuar.'),
            ),
          );
        }
      },
      child: const Icon(Icons.navigate_next),
    );
  }

  Widget seleccionarFicha(List<FichaCaracterizacion> fichas) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: DropdownSearch<FichaCaracterizacion>(
          items: fichas,
          itemAsString: (FichaCaracterizacion f) =>
              '${f.ficha} ${f.nombreCurso}',
          dropdownBuilder: _customDropDownExampleFicha,
          popupProps: PopupProps.menu(
            showSearchBox: true,
            itemBuilder: _customPopupItemBuilderExampleFicha,
          ),
          onChanged: (FichaCaracterizacion? newValue) {
            setState(() {
              selectedFicha = newValue;
            });
          },
          dropdownDecoratorProps: const DropDownDecoratorProps(
            dropdownSearchDecoration: InputDecoration(
              labelText: 'Seleccione la ficha de caracterización',
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ),
    );
  }

  Widget seleccionarAmbiente(List<Ambiente> ambientes) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: DropdownSearch<Ambiente>(
          items: ambientes,
          itemAsString: (Ambiente a) => a.title,
          dropdownBuilder: _customDropDownExampleAmbiente,
          popupProps: PopupProps.menu(
            showSearchBox: true,
            itemBuilder: _customPopupItemBuilderExampleAmbiente,
          ),
          onChanged: (Ambiente? newValue) {
            setState(() {
              selectedAmbiente = newValue;
            });
          },
          dropdownDecoratorProps: const DropDownDecoratorProps(
            dropdownSearchDecoration: InputDecoration(
              labelText: 'Seleccione el ambiente',
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _customDropDownExampleFicha(
      BuildContext context, FichaCaracterizacion? item) {
    return Container(
      child: item == null
          ? const ListTile(
              contentPadding: EdgeInsets.all(0),
              title: Text("Seleccione la ficha de caracterización"),
            )
          : ListTile(
              contentPadding: EdgeInsets.all(0),
              title: Text(item.ficha),
              subtitle: Text(item.nombreCurso),
            ),
    );
  }

  Widget _customPopupItemBuilderExampleFicha(
      BuildContext context, FichaCaracterizacion item, bool isSelected) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: !isSelected
          ? null
          : BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
      child: ListTile(
        selected: isSelected,
        title: Text(item.ficha),
        subtitle: Text(item.nombreCurso),
      ),
    );
  }

  Widget _customDropDownExampleAmbiente(BuildContext context, Ambiente? item) {
    return Container(
      child: item == null
          ? const ListTile(
              contentPadding: EdgeInsets.all(0),
              title: Text("Seleccione el ambiente"),
            )
          : ListTile(
              contentPadding: EdgeInsets.all(0),
              title: Text(item.title),
            ),
    );
  }

  Widget _customPopupItemBuilderExampleAmbiente(
      BuildContext context, Ambiente item, bool isSelected) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: !isSelected
          ? null
          : BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
      child: ListTile(
        selected: isSelected,
        title: Text(item.title),
      ),
    );
  }

  void screenIndexEntradaSalida(
      FichaCaracterizacion ficha,
      LoginResponse loginResponse,
      Ambiente selectedAmbiente,
      BuildContext context) async {
    final data = await appServices.getEntradaSalida(
        loginResponse.user.id.toString(), ficha.id.toString());
    final registros = data;
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => IndexEntradaSalida(
                  loginResponse: loginResponse,
                  ficha: ficha,
                  registros: registros,
                  ambiente: selectedAmbiente,
                )));
  }
}
