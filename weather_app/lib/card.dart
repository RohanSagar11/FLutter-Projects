import 'package:flutter/material.dart';

class MyWidget extends StatefulWidget {
  final IconData icon;
  final String time;
  final String temp;
  const MyWidget(
      {super.key, required this.time, required this.temp, required this.icon});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Card(
        elevation: 6,
        child: Container(
          width: 100,
          padding: const EdgeInsets.all(18.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Text(
                widget.time,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 4,
              ),
              Icon(
                widget.icon,
                size: 32,
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                widget.temp,
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
