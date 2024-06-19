import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora de IMC',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BmiCalculator(),
    );
  }
}

class BmiCalculator extends StatefulWidget {
  @override
  _BmiCalculatorState createState() => _BmiCalculatorState();
}

class _BmiCalculatorState extends State<BmiCalculator> {
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  double _bmi = 0;
  String _bmiCategory = '';
  String _selectedGender = 'male';

  void _calculateBmi() {
    final double weight = double.tryParse(_weightController.text) ?? 0;
    final double height = double.tryParse(_heightController.text) ?? 0;

    if (weight > 0 && height > 0) {
      setState(() {
        _bmi = weight / (height / 100 * height / 100);
        if (_bmi < 18.5) {
          _bmiCategory = 'Abaixo do peso';
        } else if (_bmi < 25) {
          _bmiCategory = 'Peso normal';
        } else if (_bmi < 30) {
          _bmiCategory = 'Sobrepeso';
        } else {
          _bmiCategory = 'Obesidade';
        }
      });
    }
  }

  void _showBmiCategories(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return FractionallySizedBox(
          heightFactor: 0.7,
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    width: 40,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    'Categorias de IMC',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 20),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Menos de 18.5\n',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      TextSpan(
                        text: 'Você está abaixo do peso.\n',
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '18.5 a 24.9\n',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      TextSpan(
                        text: 'Você está com peso normal.\n',
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '25 a 29.9\n',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      TextSpan(
                        text: 'Você está com sobrepeso.\n',
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '30 ou mais\n',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      TextSpan(
                        text: 'Obesidade.',
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora de IMC'),
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: () => _showBmiCategories(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Text(
                  'Seu corpo',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedGender = 'male';
                          });
                        },
                        child: CircleAvatar(
                          radius: 30,
                          backgroundImage: AssetImage('assets/male_avatar.png'),
                          backgroundColor: _selectedGender == 'male' ? Colors.blue : Colors.grey,
                        ),
                      ),
                      Radio<String>(
                        value: 'male',
                        groupValue: _selectedGender,
                        onChanged: (value) {
                          setState(() {
                            _selectedGender = value!;
                          });
                        },
                      ),
                      Text('Masculino'),
                    ],
                  ),
                  SizedBox(width: 20),
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedGender = 'female';
                          });
                        },
                        child: CircleAvatar(
                          radius: 30,
                          backgroundImage: AssetImage('assets/female_avatar.png'),
                          backgroundColor: _selectedGender == 'female' ? Colors.pink : Colors.grey,
                        ),
                      ),
                      Radio<String>(
                        value: 'female',
                        groupValue: _selectedGender,
                        onChanged: (value) {
                          setState(() {
                            _selectedGender = value!;
                          });
                        },
                      ),
                      Text('Feminino'),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Seu peso (kg)',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(width: 10),
                  Container(
                    width: 60,
                    child: TextField(
                      controller: _weightController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Sua altura (cm)',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(width: 10),
                  Container(
                    width: 60,
                    child: TextField(
                      controller: _heightController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              if (_bmi == 0)
                ElevatedButton(
                  onPressed: _calculateBmi,
                  child: Text('Calcular seu IMC'),
                ),
              SizedBox(height: 20),
              if (_bmi > 0)
                Column(
                  children: [
                    Text(
                      'Seu IMC',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      _bmi.toStringAsFixed(1),
                      style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      _bmiCategory,
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _weightController.clear();
                          _heightController.clear();
                          _bmi = 0;
                          _bmiCategory = '';
                        });
                      },
                      child: Text('Calcular IMC novamente'),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
