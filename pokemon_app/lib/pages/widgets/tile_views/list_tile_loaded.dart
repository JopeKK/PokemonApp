import 'package:flutter/material.dart';

class PokeTileLoaded extends StatelessWidget {
  final String name;
  final String type;

  const PokeTileLoaded({
    super.key,
    required this.name,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: colorPicker(type),
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 30),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                type,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Color colorPicker(String type) {
  Color endColor = Colors.white;

  if (type == 'water') {
    endColor = Colors.blue;
  } else if (type == 'grass') {
    endColor = Colors.green;
  } else if (type == 'fire') {
    endColor = Colors.red;
  } else if (type == 'normal') {
    endColor = Colors.deepOrange;
  } else if (type == 'bug') {
    endColor = Colors.orange;
  } else if (type == 'poison') {
    endColor = Colors.purple;
  } else if (type == 'ground') {
    endColor = Colors.brown;
  } else if (type == 'fairy') {
    endColor = Colors.green;
  } else if (type == 'electric') {
    endColor = Colors.yellow;
  } else if (type == 'rock') {
    endColor = Colors.grey;
  } else if (type == 'fighting') {
    endColor = Colors.amber;
  } else if (type == 'psychic') {
    endColor = Colors.cyan;
  } else if (type == 'ghost') {
    endColor = Colors.transparent;
  } else if (type == 'ice') {
    endColor = Colors.deepPurpleAccent;
  } else if (type == 'dragon') {
    endColor = Colors.pink;
  } else if (type == 'dark') {
    endColor = Colors.indigo;
  }else if (type == 'steel') {
    endColor = Colors.lightGreen;
  }

  return endColor;
}
