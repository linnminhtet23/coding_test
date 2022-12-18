import 'package:flutter/material.dart';

class FullScreenPreloader extends StatelessWidget {
  const FullScreenPreloader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration:const BoxDecoration(color: Colors.white),
      child: const Center(
        child: CircularProgressIndicator(color: Colors.blueGrey,),
      ),
    );
  }
}