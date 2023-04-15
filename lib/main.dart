import 'dart:math';

import 'package:flutter/material.dart';

import 'custom_text_field.dart';
import 'package:flutter_slot_machine/slot_machine.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'สุ่มเลข',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'สุ่มเลข'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _randomResult = 0;
  late SlotMachineController _controller;
  bool isStart = false;

  onButtonTap() async {
    for (int i = 2; i >= 0; i--) {
      await Future.delayed(Duration(seconds: Random().nextInt(5) + 1));
      _controller.stop(reelIndex: i);
    }

    setState(() {
      isStart = false;
    });
  }

  onStart() async {
    setState(() {
      isStart = true;
    });

    final index = Random().nextInt(20);
    _controller.start(hitRollItemIndex: index < 5 ? index : null);

    await Future.delayed(
      const Duration(seconds: 2),
      () {
        onButtonTap();
      },
    );
  }

  void _random() {
    setState(() {
      _randomResult = Random().nextInt(999);
    });
  }

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
            const Text(
              'You have pushed the button this many times:',
            ),
            const SizedBox(height: 20),
            // Text(
            //   _randomResult.toString().padLeft(3, '0'),
            //   style: Theme.of(context).textTheme.headlineMedium,
            // ),
            _buildResultSlot(),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _random,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.refresh),
      // ),
    );
  }

  Widget _buildResultSlot() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SlotMachine(
            height: 55,
            rollItems: [
              RollItem(index: 0, child: Image.asset('assets/images/0.PNG')),
              RollItem(index: 1, child: Image.asset('assets/images/1.PNG')),
              RollItem(index: 2, child: Image.asset('assets/images/2.PNG')),
              RollItem(index: 3, child: Image.asset('assets/images/3.PNG')),
              RollItem(index: 4, child: Image.asset('assets/images/4.PNG')),
              RollItem(index: 5, child: Image.asset('assets/images/5.PNG')),
              RollItem(index: 6, child: Image.asset('assets/images/6.PNG')),
              RollItem(index: 7, child: Image.asset('assets/images/7.PNG')),
              RollItem(index: 8, child: Image.asset('assets/images/8.PNG')),
              RollItem(index: 9, child: Image.asset('assets/images/9.PNG')),
            ],
            onCreated: (controller) {
              _controller = controller;
            },
            onFinished: (resultIndexes) {
              print('Result: $resultIndexes');
            },
          ),
          Padding(
            padding: const EdgeInsets.only(top: 24),
            child: isStart
                ? const Text(
                    'Waiting...',
                  )
                : TextButton(
                    onPressed: () => onStart(),
                    child: const Text('กดที่นี่เพื่อเริ่มสุ่มเลข'),
                  ),
          ),
        ],
      ),
    );
  }
}
