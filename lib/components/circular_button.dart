import 'package:flutter/material.dart';

class CircularButton extends StatelessWidget {
  const CircularButton({required this.onPressed, required this.icon, this.label = '', Key? key}) : super(key: key);
  final String label;
  final Function() onPressed;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 4),
              shape: BoxShape.circle),
          child: IconButton(
            icon: icon,
            color: Colors.white,
            onPressed: onPressed,
          ),
        ),
        Text(
          label,
          style: const TextStyle(color: Colors.white, height: 2),
        ),
      ],
    );
  }
}
