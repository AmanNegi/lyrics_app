import 'package:flutter/material.dart';

//* No Internet available
class ErrorPage extends StatelessWidget {
  const ErrorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("No Internet Available")),
    );
  }
}
