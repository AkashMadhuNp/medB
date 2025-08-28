import 'package:flutter/material.dart';

class SessionExpiredDialog extends StatelessWidget {
  final VoidCallback? onOkPressed;

  const SessionExpiredDialog({
    Key? key,
    this.onOkPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      contentPadding: const EdgeInsets.all(24),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.orange.withOpacity(0.1),
              border: Border.all(
                color: Colors.orange,
                width: 3,
              ),
            ),
            child: const Icon(
              Icons.warning_rounded,
              color: Colors.orange,
              size: 40,
            ),
          ),
          const SizedBox(height: 24),
          
          const Text(
            'Session Expired !',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          
          const Text(
            'Session has expired due to inactivity or timeout. Please log in again.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black54,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 32),
          
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                if (onOkPressed != null) {
                  onOkPressed!();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 0,
              ),
              child: const Text(
                'OK',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Future<void> show(
    BuildContext context, {
    VoidCallback? onOkPressed,
  }) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, 
      builder: (BuildContext context) {
        return SessionExpiredDialog(
          onOkPressed: onOkPressed,
        );
      },
    );
  }
}