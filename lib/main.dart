import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vibration/vibration.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Sounds and vibrations'),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: IntrinsicWidth(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                child: const Text("Vibration - Haptic feedback"),
                onPressed: () async {
                  HapticFeedback.vibrate();
                  /** does not work
                   HapticFeedback.lightImpact();
                  HapticFeedback.mediumImpact();
                  HapticFeedback.heavyImpact();
                  HapticFeedback.selectionClick();
                   */
                },
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                child: const Text("Vibration plugin"),
                onPressed: () async {
                  _vibrate();
                },
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                child: const Text("Sound"),
                onPressed: () {
                  _playSound();
                },
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                child: const Text("Sound and Vibrate"),
                onPressed: () {
                  _playSound();
                  _vibrate();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  _vibrate() async {
    log("Vibrate Button tapped");
    // HapticFeedback.vibrate();
    if (await Vibration.hasVibrator() ?? false) {
      if (await Vibration.hasCustomVibrationsSupport() ?? false) {
        Vibration.vibrate(pattern: [0, 500, 200, 500]);
      } else {
        Vibration.vibrate();
      }
    }
    log("Vibrating...");
  }

  _playSound() {
    log("Sound Button tapped");
    AudioCache.instance = AudioCache(prefix: "");
    final player = AudioPlayer();
    player.play(AssetSource("assets/alerts/error-2-126514.mp3"));
    log("Playing sound...");
  }
}

/**
 * Works -
 * vibrate()
 * 
 * does not work - 
 * selection click()
 * mediumImpact()
 */