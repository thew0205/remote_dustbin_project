// ignore_for_file: use_build_context_synchronously

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'dustin_page.dart';
import 'server.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  final _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: TextField(
                keyboardType: TextInputType.number,
                controller: _textEditingController,
                decoration: InputDecoration(
                    hintText: "Enter Ip address to connect to",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                    )),
                onChanged: (value) {
                  setState(() {});
                },
              ),
            ),
            ElevatedButton(
                onPressed: () async {
                  if (_textEditingController.text.isEmpty) {
                    if (kDebugMode) {
                      print("Incorrect Ip address");
                    }
                  } else {
                    ref
                        .read(apiProvider.notifier)
                        .setIp(_textEditingController.text);
                    if (await ref.read(apiProvider.notifier).getConnection()) {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const DustbinControlPage()));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                              "Getting connection fail check the ip address: ${_textEditingController.text} again")));
                    }
                  }
                },
                child: Text(
                    "Connect to url: http://${_textEditingController.text}"))
          ],
        ),
      ),
    );
  }
}
