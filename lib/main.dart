import 'package:flutter/material.dart';

void main() {
  runApp(AreaConverterApp());
}

class AreaConverterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Area Converter',
      theme: ThemeData(primarySwatch: Colors.green),
      home: AreaConverterScreen(),
    );
  }
}

class AreaConverterScreen extends StatefulWidget {
  @override
  _AreaConverterScreenState createState() => _AreaConverterScreenState();
}

class _AreaConverterScreenState extends State<AreaConverterScreen> {
  final TextEditingController _areaController = TextEditingController();
  double _convertedArea = 0.0;

  // Area conversion rates (relative to square meters)
  final Map<String, double> areaUnits = {
    'Square Meters': 1.0,
    'Square Kilometers': 0.000001,
    'Square Feet': 10.7639,
    'Acres': 0.000247105,
    'Hectares': 0.0001,
  };

  String _fromUnit = 'Square Meters';
  String _toUnit = 'Square Kilometers';

  void _convertArea() {
    double area = double.tryParse(_areaController.text) ?? 0.0;
    double fromRate = areaUnits[_fromUnit]!;
    double toRate = areaUnits[_toUnit]!;

    setState(() {
      _convertedArea = (area / fromRate) * toRate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      appBar: AppBar(
        title: Text("Area Converter"),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Input Card
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              elevation: 5,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    TextField(
                      controller: _areaController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Enter Area",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),

                    // Dropdowns
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        DropdownButton<String>(
                          value: _fromUnit,
                          onChanged: (value) {
                            setState(() {
                              _fromUnit = value!;
                            });
                          },
                          style: TextStyle(fontSize: 18, color: Colors.black),
                          items: areaUnits.keys.map((unit) {
                            return DropdownMenuItem(
                              value: unit,
                              child: Text(unit),
                            );
                          }).toList(),
                        ),

                        Icon(Icons.arrow_forward, color: Colors.green),

                        DropdownButton<String>(
                          value: _toUnit,
                          onChanged: (value) {
                            setState(() {
                              _toUnit = value!;
                            });
                          },
                          style: TextStyle(fontSize: 18, color: Colors.black),
                          items: areaUnits.keys.map((unit) {
                            return DropdownMenuItem(
                              value: unit,
                              child: Text(unit),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 20),

            // Convert Button
            ElevatedButton(
              onPressed: _convertArea,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                "Convert",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),

            SizedBox(height: 20),

            // Converted Area Card
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              color: Colors.green,
              elevation: 5,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  "Converted Area: ${_convertedArea.toStringAsFixed(4)} $_toUnit",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
