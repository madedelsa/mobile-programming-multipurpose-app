import 'package:flutter/material.dart';

class SakaScreen extends StatefulWidget {
  const SakaScreen({super.key});

  @override
  State<SakaScreen> createState() => _SakaScreenState();
}

class _SakaScreenState extends State<SakaScreen> {
  final List<String> _sasihMonths = [
    '', 'Kasa', 'Karo', 'Katiga', 'Kapat', 'Kalima', 'Kanem', 
    'Kapitu', 'Kawalu', 'Kasanga', 'Kadasa', 'Jiyestha', 'Sadha',
  ];

  // Data Nyepi (1 Kadasa) sebagai titik acuan perhitungan
  final Map<int, DateTime> _nyepiDates = {
    2023: DateTime(2023, 3, 22),
    2024: DateTime(2024, 3, 11),
    2025: DateTime(2025, 3, 29),
    2026: DateTime(2026, 3, 19), // 19 Maret 2026 = 1 Kadasa 1948
    2027: DateTime(2027, 3, 8),
    2028: DateTime(2028, 3, 26),
  };

  DateTime _selectedDate = DateTime.now();

  // Menentukan Nyepi terdekat (titik balik sasih Kadasa)
  DateTime get _currentYearNyepi {
    return _nyepiDates[_selectedDate.year] ?? DateTime(_selectedDate.year, 3, 21);
  }

  // 1. Logika Tahun Saka
  int get _sakaYear {
    if (_selectedDate.isBefore(_currentYearNyepi)) {
      return _selectedDate.year - 79;
    }
    return _selectedDate.year - 78;
  }

  // 2. Logika Tanggal Saka (Hari dalam Sasih)
  // Menghitung selisih hari dari awal sasih terdekat (asumsi siklus lunar 30 hari)
  int get _sakaDay {
    // Selisih hari dari Nyepi (Nyepi adalah tanggal 1)
    int diffDays = _selectedDate.difference(_currentYearNyepi).inDays;
    
    // Jika sesudah nyepi
    if (diffDays >= 0) {
      return (diffDays % 30) + 1;
    } else {
      // Jika sebelum nyepi (mundur dari tanggal 1 sasih kadasa)
      return 30 + ((diffDays + 1) % 30);
    }
  }

  // 3. Logika Sasih (Bulan)
  int get _sasihIndex {
    int diffDays = _selectedDate.difference(_currentYearNyepi).inDays;
    // Berapa bulan dari Kadasa (Index 10)
    int monthOffset = (diffDays / 30).floor();
    int index = 10 + monthOffset;

    while (index > 12) index -= 12;
    while (index < 1) index += 12;
    
    return index;
  }

  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2023),
      lastDate: DateTime(2028),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(primary: Color(0xFF0D47A1)),
        ),
        child: child!,
      ),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  String _formatMasehi(DateTime dt) {
    const List<String> bulan = [
      '', 'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
      'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember',
    ];
    const List<String> hari = ['Minggu', 'Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu'];
    return '${hari[dt.weekday % 7]}, ${dt.day} ${bulan[dt.month]} ${dt.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F6FF),
      appBar: AppBar(
        title: const Text('Konversi Saka', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18, color: Colors.white)),
        flexibleSpace: Container(decoration: const BoxDecoration(gradient: LinearGradient(colors: [Color(0xFF0D47A1), Color(0xFF1E88E5)]))),
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [Color(0xFF0D47A1), Color(0xFF1E88E5)]),
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(32), bottomRight: Radius.circular(32)),
            ),
            padding: const EdgeInsets.fromLTRB(24, 8, 24, 28),
            child: const Row(
              children: [
                Icon(Icons.calendar_today_rounded, color: Colors.white, size: 28),
                SizedBox(width: 14),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Kalender Saka', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700)),
                    Text('Konversi Masehi ke Saka Bali', style: TextStyle(color: Colors.white70, fontSize: 13)),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Pilih Tanggal Masehi', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF37474F))),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () => _selectDate(context),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white, borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFFBBDEFB)),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.edit_calendar, color: Color(0xFF1976D2)),
                          const SizedBox(width: 14),
                          Text(_formatMasehi(_selectedDate), style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Color(0xFF1A237E))),
                          const Spacer(),
                          const Icon(Icons.chevron_right, color: Color(0xFF90CAF9)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(28),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(colors: [Color(0xFF0D47A1), Color(0xFF1E88E5)]),
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [BoxShadow(color: const Color(0xFF1565C0).withOpacity(0.3), blurRadius: 20, offset: const Offset(0, 8))],
                    ),
                    child: Column(
                      children: [
                        const Icon(Icons.brightness_5_rounded, color: Colors.white, size: 40),
                        const SizedBox(height: 12),
                        const Text('Tanggal Saka', style: TextStyle(color: Colors.white70, fontSize: 14)),
                        const SizedBox(height: 8),
                        Text(
                          '$_sakaDay ${_sasihMonths[_sasihIndex]} $_sakaYear Saka',
                          style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w800),
                          textAlign: TextAlign.center,
                        ),
                        const Divider(color: Colors.white24, height: 24),
                        Text(_formatMasehi(_selectedDate), style: const TextStyle(color: Colors.white60, fontSize: 13)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text('Rincian', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Color(0xFF37474F))),
                  const SizedBox(height: 12),
                  _buildInfoRow('Tanggal', '$_sakaDay', Icons.tag),
                  _buildInfoRow('Sasih (Bulan)', _sasihMonths[_sasihIndex], Icons.calendar_view_month),
                  _buildInfoRow('Tahun Saka', '$_sakaYear', Icons.history_edu),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14)),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF1565C0), size: 20),
          const SizedBox(width: 14),
          Text(label, style: const TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF37474F))),
          const Spacer(),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w800, color: Color(0xFF0D47A1))),
        ],
      ),
    );
  }
}