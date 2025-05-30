
import 'package:flutter/material.dart';

class TodoScreen extends StatelessWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
            child: Text(
                "Todo Screen Works" ,
              style: Theme.of(context).textTheme.displayLarge
            ),
          )
      ),
    );
  }
}
