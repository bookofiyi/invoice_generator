import 'package:flutter/material.dart';
import 'package:invoice_generator/constants.dart';

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
                width: 200,
                height: 200,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            MaterialButton(
              onPressed: () {},
              child: const Text(
                'Set New Logo',
                style: TextStyle(
                  color: kwhite,
                ),
              ),
              color: kred,
            ),
            MaterialButton(
              onPressed: () {},
              child: const Text(
                'Remove Logo',
                style: TextStyle(
                  color: kwhite,
                ),
              ),
              color: kred,
            ),
          ],
        ),
      ),
    );
  }
}
