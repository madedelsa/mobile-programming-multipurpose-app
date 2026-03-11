import 'dart:math';
import 'package:flutter/material.dart';

class PiramidScreen extends StatefulWidget {
  const PiramidScreen({super.key});

  @override
  State<PiramidScreen> createState() => _PiramidScreenState();
}

class _PiramidScreenState extends State<PiramidScreen> {
  final _formKey = GlobalKey<FormState>();
  final _sisiAlasController = TextEditingController();
  final _tinggiController = TextEditingController();
  String _luas = '0.00';
  String _volume = '0.00';

  void _hitungPiramid() {
    if (_formKey.currentState!.validate()) {
      double s = double.tryParse(_sisiAlasController.text) ?? 0;
      double t = double.tryParse(_tinggiController.text) ?? 0;

      if (s > 0 && t > 0) {
        double volumePiramid = (1 / 3) * (s * s) * t;
        double tinggiSegitiga = sqrt(pow((s / 2), 2) + pow(t, 2));
        double luasPermukaan = (s * s) + (4 * (0.5 * s * tinggiSegitiga));

        setState(() {
          _volume = volumePiramid.toStringAsFixed(2);
          _luas = luasPermukaan.toStringAsFixed(2);
        });
      }
    }
  }

  @override
  void dispose() {
    _sisiAlasController.dispose();
    _tinggiController.dispose();
    super.dispose();
  }

  InputDecoration _inputDecoration({
    required String label,
    required String hint,
    required IconData icon,
  }) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Color(0xFF1976D2)),
      hintText: hint,
      hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
      prefixIcon: Icon(icon, color: const Color(0xFF1976D2), size: 20),
      filled: true,
      fillColor: const Color(0xFFF0F6FF),
      contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFBBDEFB), width: 1.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF1976D2), width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFE53935), width: 1.5),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFE53935), width: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool hasResult = _volume != '0.00' || _luas != '0.00';

    return Scaffold(
      backgroundColor: const Color(0xFFF0F6FF),
      appBar: AppBar(
        title: const Text(
          'Luas & Volume Piramid',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 18,
            letterSpacing: 0.3,
            color: Colors.white,
          ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF0D47A1), Color(0xFF1E88E5)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header banner
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF0D47A1), Color(0xFF1E88E5)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                ),
              ),
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 28),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Icon(
                      Icons.change_history_rounded,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Piramid',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        'Hitung luas & volume piramida',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.75),
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Info card
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFBBDEFB),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: const Color(0xFF90CAF9),
                          width: 1,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 14,
                        horizontal: 16,
                      ),
                      child: const Row(
                        children: [
                          Icon(
                            Icons.change_history_rounded,
                            color: Color(0xFF1565C0),
                            size: 22,
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'Hitungan berdasarkan Piramida Alas Persegi (Square Pyramid)',
                              style: TextStyle(
                                color: Color(0xFF1565C0),
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 28),

                    // Input sisi alas
                    const Text(
                      'Panjang Sisi Alas (s)',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF37474F),
                      ),
                    ),
                    const SizedBox(height: 6),
                    TextFormField(
                      controller: _sisiAlasController,
                      decoration: _inputDecoration(
                        label: 'Masukkan sisi alas',
                        hint: 'Contoh: 5.0',
                        icon: Icons.straighten_rounded,
                      ),
                      keyboardType: TextInputType.number,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Color(0xFF1A1A2E),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Sisi alas tidak boleh kosong';
                        }
                        if (double.tryParse(value) == null ||
                            double.parse(value) <= 0) {
                          return 'Input harus angka lebih besar dari 0';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 20),

                    // Input tinggi
                    const Text(
                      'Tinggi Piramida (t)',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF37474F),
                      ),
                    ),
                    const SizedBox(height: 6),
                    TextFormField(
                      controller: _tinggiController,
                      decoration: _inputDecoration(
                        label: 'Masukkan tinggi piramida',
                        hint: 'Contoh: 8.0',
                        icon: Icons.height_rounded,
                      ),
                      keyboardType: TextInputType.number,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Color(0xFF1A1A2E),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Tinggi tidak boleh kosong';
                        }
                        if (double.tryParse(value) == null ||
                            double.parse(value) <= 0) {
                          return 'Input harus angka lebih besar dari 0';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 24),

                    // Tombol hitung
                    SizedBox(
                      height: 52,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF1565C0), Color(0xFF1E88E5)],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius: BorderRadius.circular(14),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF1565C0).withOpacity(0.35),
                              blurRadius: 12,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: ElevatedButton.icon(
                          onPressed: _hitungPiramid,
                          icon: const Icon(
                            Icons.calculate_rounded,
                            color: Colors.white,
                          ),
                          label: const Text(
                            'Hitung',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 32),

                    // Result cards
                    Row(
                      children: [
                        Expanded(
                          child: _buildResultCard(
                            title: 'Volume',
                            value: _volume,
                            icon: Icons.view_in_ar_rounded,
                            hasResult: hasResult,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildResultCard(
                            title: 'Luas Permukaan',
                            value: _luas,
                            icon: Icons.layers_rounded,
                            hasResult: hasResult,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultCard({
    required String title,
    required String value,
    required IconData icon,
    required bool hasResult,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1565C0).withOpacity(0.1),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: hasResult
                  ? const Color(0xFFBBDEFB)
                  : const Color(0xFFF5F5F5),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: 26,
              color: hasResult ? const Color(0xFF1565C0) : Colors.grey.shade400,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey.shade500,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: hasResult ? const Color(0xFF0D47A1) : Colors.grey.shade400,
            ),
          ),
        ],
      ),
    );
  }
}
