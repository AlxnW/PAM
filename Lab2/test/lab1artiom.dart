
import 'dart:math' as math;
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: AnglePage(),
  ));
}

class AnglePage extends StatefulWidget {
  const AnglePage({super.key});

  @override
  State<AnglePage> createState() => _AnglePageState();
}

class _AnglePageState extends State<AnglePage> {
  final _controller = TextEditingController();
  bool _isDegToRad = true; // true = Grade -> Radiani, false = Radiani -> Grade
  String _result = '';

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _convert() {
    final raw = _controller.text.trim();
    if (raw.isEmpty) {
      _showSnack('Introduceți o valoare.');
      return;
    }

    // acceptă și „,” ca separator zecimal
    final value = double.tryParse(raw.replaceAll(',', '.'));
    if (value == null) {
      _showSnack('Valoare invalidă. Folosiți cifre și . sau , pentru zecimale.');
      return;
    }

    final out = _isDegToRad ? value * math.pi / 180.0 : value * 180.0 / math.pi;
    final inUnit = _isDegToRad ? '°' : 'rad';
    final outUnit = _isDegToRad ? 'rad' : '°';

    setState(() {
      _result = '${_fmt(value)} $inUnit → ${_fmt(out)} $outUnit';
    });
  }

  String _fmt(double v) {
    // până la 6 zecimale, fără zerouri de la final
    return v.toStringAsFixed(6).replaceFirst(RegExp(r'\.?0+$'), '');
  }

  void _showSnack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Grade ↔️ Radiani')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            TextField(
              controller: _controller,
              keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: true),
              decoration: InputDecoration(
                labelText: _isDegToRad ? 'Valoare în grade (°)' : 'Valoare în radiani (rad)',
                border: const OutlineInputBorder(),
                helperText: 'Exemple: 180   3.14   12,5',
                prefixIcon: const Icon(Icons.straighten),
              ),
              onSubmitted: (_) => _convert(),
            ),
            const SizedBox(height: 12),
            SwitchListTile(
              value: _isDegToRad,
              onChanged: (v) => setState(() => _isDegToRad = v),
              title: Text(_isDegToRad ? 'Grade → Radiani' : 'Radiani → Grade'),
              subtitle: Text(_isDegToRad ? 'rad = grade × π / 180' : 'grade = rad × 180 / π'),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 48,
              child: ElevatedButton.icon(
                onPressed: _convert,
                icon: const Icon(Icons.calculate),
                label: const Text('Convertește'),
              ),
            ),
            const SizedBox(height: 16),
            if (_result.isNotEmpty)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    _result,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
