import 'dart:async';
import 'package:flutter/material.dart';

class StopwatchScreen extends StatefulWidget {
  const StopwatchScreen({super.key});

  @override
  State<StopwatchScreen> createState() => _StopwatchScreenState();
}

class _StopwatchScreenState extends State<StopwatchScreen> {
  final Stopwatch _stopwatch = Stopwatch();
  Timer? _timer;

  void _start() {
    _stopwatch.start();
    _timer = Timer.periodic(const Duration(milliseconds: 30), (Timer t) {
      setState(() {});
    });
  }

  void _stop() {
    _stopwatch.stop();
    _timer?.cancel();
    setState(() {});
  }

  void _reset() {
    _stopwatch.reset();
    setState(() {});
  }

  String _formatTime() {
    final ms = _stopwatch.elapsedMilliseconds;
    int hundreds = (ms / 10).truncate() % 100;
    int seconds = (ms / 1000).truncate() % 60;
    int minutes = (ms / (1000 * 60)).truncate();
    return "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}.${hundreds.toString().padLeft(2, '0')}";
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isRunning = _stopwatch.isRunning;

    return Scaffold(
      backgroundColor: const Color(0xFFF0F6FF),
      appBar: AppBar(
        title: const Text(
          'Stopwatch',
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
      body: Column(
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
                    Icons.timer_rounded,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 14),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Stopwatch',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      isRunning ? 'Sedang berjalan...' : 'Siap digunakan',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.75),
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                // Status indicator
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isRunning
                        ? const Color(0xFF69F0AE)
                        : Colors.white.withOpacity(0.4),
                    boxShadow: isRunning
                        ? [
                            BoxShadow(
                              color: const Color(0xFF69F0AE).withOpacity(0.7),
                              blurRadius: 6,
                              spreadRadius: 2,
                            ),
                          ]
                        : [],
                  ),
                ),
              ],
            ),
          ),

          // Main content
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Clock display
                  Container(
                    width: 290,
                    height: 290,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF1565C0).withOpacity(0.15),
                          blurRadius: 48,
                          spreadRadius: 12,
                        ),
                      ],
                      border: Border.all(
                        color: isRunning
                            ? const Color(0xFF1976D2).withOpacity(0.5)
                            : const Color(0xFFBBDEFB),
                        width: 8,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        _formatTime(),
                        style: TextStyle(
                          fontSize: 38,
                          fontWeight: FontWeight.w300,
                          color: isRunning
                              ? const Color(0xFF0D47A1)
                              : const Color(0xFF90A4AE),
                          fontFeatures: const [FontFeature.tabularFigures()],
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 56),

                  // Control buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Start button
                      _buildCircularButton(
                        icon: Icons.play_arrow_rounded,
                        activeGradient: const LinearGradient(
                          colors: [Color(0xFF1565C0), Color(0xFF1E88E5)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        onPressed: isRunning ? null : _start,
                        tooltip: 'Start',
                        size: 64,
                      ),
                      const SizedBox(width: 20),
                      // Stop button
                      _buildCircularButton(
                        icon: Icons.pause_rounded,
                        activeGradient: const LinearGradient(
                          colors: [Color(0xFF0277BD), Color(0xFF0288D1)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        onPressed: isRunning ? _stop : null,
                        tooltip: 'Stop',
                        size: 64,
                      ),
                      const SizedBox(width: 20),
                      // Reset button
                      _buildCircularButton(
                        icon: Icons.refresh_rounded,
                        activeGradient: const LinearGradient(
                          colors: [Color(0xFF01579B), Color(0xFF0277BD)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        onPressed: _reset,
                        tooltip: 'Reset',
                        size: 64,
                      ),
                    ],
                  ),

                  const SizedBox(height: 32),

                  // Button labels
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildButtonLabel('Start', isRunning ? false : true),
                      const SizedBox(width: 52),
                      _buildButtonLabel('Stop', isRunning),
                      const SizedBox(width: 52),
                      _buildButtonLabel('Reset', true),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButtonLabel(String label, bool active) {
    return Text(
      label,
      style: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: active ? const Color(0xFF1565C0) : Colors.grey.shade400,
        letterSpacing: 0.5,
      ),
    );
  }

  Widget _buildCircularButton({
    required IconData icon,
    required LinearGradient activeGradient,
    required VoidCallback? onPressed,
    required String tooltip,
    required double size,
  }) {
    final bool isActive = onPressed != null;

    return Tooltip(
      message: tooltip,
      child: GestureDetector(
        onTap: onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: isActive ? activeGradient : null,
            color: isActive ? null : const Color(0xFFECEFF1),
            boxShadow: isActive
                ? [
                    BoxShadow(
                      color: const Color(0xFF1565C0).withOpacity(0.35),
                      blurRadius: 14,
                      offset: const Offset(0, 5),
                    ),
                  ]
                : [],
          ),
          child: Icon(
            icon,
            size: 30,
            color: isActive ? Colors.white : Colors.grey.shade400,
          ),
        ),
      ),
    );
  }
}
