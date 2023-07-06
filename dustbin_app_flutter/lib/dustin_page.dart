
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'server.dart';

class DustbinControlPage extends ConsumerWidget {
  const DustbinControlPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch<ApiTemplate>(apiProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dustbin Control"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            child: Image.asset(
                "assets/dustbin_${provider.isOpen ? "opened" : "closed"}_rebg.png",
                height: 150),
            onTap: () {
              ref.read(apiProvider.notifier).controlDustbin();
            },
          ),
          const SizedBox(height: 35),
          Center(
            child: Text(
              textAlign: TextAlign.center,
              "Dustbin is ${provider.isOpen ? "Opened" : "Closed"}",
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontSize: 20, color: Theme.of(context).primaryColor),
            ),
          )
        ],
      ),
    );
  }
}