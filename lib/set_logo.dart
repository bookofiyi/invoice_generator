import 'package:flutter/material.dart';

class SetLogoScreen extends StatefulWidget {
  const SetLogoScreen({Key? key}) : super(key: key);

  @override
  State<SetLogoScreen> createState() => _SetLogoScreenState();
}

class _SetLogoScreenState extends State<SetLogoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Set Logo',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 32.0),
        child: Column(
          children: [
            Center(
              child: Image.asset(
                'assets/images/logo.png',
                width: 100,
                height: 100,
              ),
            ),
            MaterialButton(
              onPressed: () {},
              child: const Text('Set New Logo'),
            ),
            MaterialButton(
              onPressed: () {},
              child: const Text('Remove Logo'),
            ),
          ],
        ),
      ),
    );
  }
}
