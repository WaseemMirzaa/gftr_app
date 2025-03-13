import 'package:flutter/material.dart';

class GivePage extends StatefulWidget {
  const GivePage({Key? key}) : super(key: key);

  @override
  State<GivePage> createState() => _GivePageState();
}

class _GivePageState extends State<GivePage> {
  @override
  Widget build(BuildContext context) {
    // ignore: avoid_unnecessary_containers
    return Container(
      child: const Center(
        child:  Text("Give",style: TextStyle(color: Colors.black),),
      ),
    );
  }
}
