import 'package:flutter/material.dart';

class BmiCategories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categorias de IMC'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Categorias de IMC',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Menos de 18.5\nVocê está abaixo do peso.',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Text(
              '18.5 a 24.9\nVocê está com peso normal.',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Text(
              '25 a 29.9\nVocê está com sobrepeso.',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Text(
              '30 ou mais\nObesidade.',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
