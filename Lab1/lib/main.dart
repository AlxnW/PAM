import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator TVA',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: TvaCalculatorScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class TvaCalculatorScreen extends StatefulWidget {
  @override
  _TvaCalculatorScreenState createState() => _TvaCalculatorScreenState();
}

class _TvaCalculatorScreenState extends State<TvaCalculatorScreen> {
  final TextEditingController _priceController = TextEditingController();
  double _selectedTvaRate = 20.0;
  double _finalPrice = 0.0;
  double _tvaAmount = 0.0;

//Functia pentru a calcula TVA

  void _calculateTva() {
    double basePrice = double.tryParse(_priceController.text) ?? 0.0;

    if (basePrice > 0) {
      setState(() {
        _tvaAmount = basePrice * (_selectedTvaRate / 100);
        _finalPrice = basePrice + _tvaAmount;
      });
    } else {
      setState(() {
        _tvaAmount = 0.0;
        _finalPrice = 0.0;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Te rog introdu un preț valid'),
          backgroundColor: Colors.orange,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          'Calculator TVA',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue[600],
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Card pentru input-ul prețului
              Card(
                elevation: 8,
                shadowColor: Colors.blue.withOpacity(0.3),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Preț fără TVA',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.blue[800],
                        ),
                      ),
                      SizedBox(height: 12),
                      TextField(
                        controller: _priceController,
                        keyboardType: TextInputType.numberWithOptions(decimal: true),
                        decoration: InputDecoration(
                          hintText: 'Introdu prețul...',
                          prefixIcon: Icon(Icons.euro, color: Colors.blue[600]),
                          suffixText: 'Lei',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.blue[600]!, width: 2),
                          ),
                          filled: true,
                          fillColor: Colors.grey[50],
                        ),
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 20),

              // Card pentru selectarea cotei TVA
              Card(
                elevation: 8,
                shadowColor: Colors.blue.withOpacity(0.3),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Selectează cota TVA',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.blue[800],
                        ),
                      ),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildTvaButton(5.0),
                          _buildTvaButton(8.0),
                          _buildTvaButton(20.0),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 20),

              // Butonul de calcul
              ElevatedButton(
                onPressed: _calculateTva,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[600],
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 4,
                ),
                child: Text(
                  'CALCULEAZĂ TVA',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              SizedBox(height: 20),

              // Card pentru rezultate
              if (_finalPrice > 0) ...[
                Card(
                  elevation: 8,
                  shadowColor: Colors.green.withOpacity(0.3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      gradient: LinearGradient(
                        colors: [Colors.green[50]!, Colors.green[100]!],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(Icons.calculate, color: Colors.green[700], size: 24),
                              SizedBox(width: 8),
                              Text(
                                'Rezultate',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green[800],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16),

                          _buildResultRow('Preț fără TVA:', '${double.parse(_priceController.text).toStringAsFixed(2)} Lei'),
                          SizedBox(height: 8),
                          _buildResultRow('TVA ($_selectedTvaRate%):', '${_tvaAmount.toStringAsFixed(2)} Lei'),
                          SizedBox(height: 8),
                          Divider(color: Colors.green[300]),
                          SizedBox(height: 8),
                          _buildResultRow(
                            'Preț final:',
                            '${_finalPrice.toStringAsFixed(2)} Lei',
                            isTotal: true,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTvaButton(double rate) {
    bool isSelected = _selectedTvaRate == rate;
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: ElevatedButton(
          onPressed: () {
            setState(() {
              _selectedTvaRate = rate;
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: isSelected ? Colors.blue[600] : Colors.grey[200],
            foregroundColor: isSelected ? Colors.white : Colors.grey[700],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            elevation: isSelected ? 4 : 2,
            padding: EdgeInsets.symmetric(vertical: 12),
          ),
          child: Text(
            '${rate.toInt()}%',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildResultRow(String label, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 18 : 16,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w500,
            color: isTotal ? Colors.green[800] : Colors.green[700],
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 18 : 16,
            fontWeight: FontWeight.bold,
            color: isTotal ? Colors.green[800] : Colors.green[600],
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _priceController.dispose();
    super.dispose();
  }
}


//