import 'package:flutter/material.dart';


class ConfigureAccessPointPage extends StatefulWidget {
  const ConfigureAccessPointPage({super.key});

  @override
  State<ConfigureAccessPointPage> createState() =>
      _ConfigureAccessPointPageState();
}

class _ConfigureAccessPointPageState extends State<ConfigureAccessPointPage> {
  final _formKey = GlobalKey<FormState>();

  String? ssid;

  String? password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Configure Wifi")),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                validator: (value) {
                  if (value?.isEmpty ?? false) {
                    return "ssid can't be empty";
                  } else {
                    return null;
                  }
                },
                onSaved: (value) {
                  ssid = value;
                },
                decoration: const InputDecoration(
                    hintText: "Enter ssid", border: OutlineInputBorder()),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                validator: (value) {
                  if ((value?.length ?? 0) < 8) {
                    return "Password must be at least 8 character long";
                  } else {
                    return null;
                  }
                },
                onSaved: (value) {
                  password = value;
                },
                decoration: const InputDecoration(
                    hintText: "Enter password", border: OutlineInputBorder()),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    _formKey.currentState?.save();
                    // configureAccessPoint(ssid!, password!);
                  }
                },
                child: const Text("Configure Access Point"))
          ],
        ),
      ),
    );
  }
}
