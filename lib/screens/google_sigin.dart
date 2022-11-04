import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class GoogleSigninSc extends StatelessWidget {
  const GoogleSigninSc({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Google Singin"),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: ElevatedButton(
              child: Text("Google Singin"),
              onPressed: () {},
            ),
          ),
        ),
      ),
    );
  }
}
