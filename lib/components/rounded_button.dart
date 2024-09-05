import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final VoidCallback tombol;
  final String text;
  final Color warna;

  const RoundedButton(
      {super.key,
      required this.text,
      required this.tombol,
      required this.warna});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: warna,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: tombol,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            text,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
