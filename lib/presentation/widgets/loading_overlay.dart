import 'package:flutter/material.dart';
import 'dart:ui';

class LoadingOverlay extends StatelessWidget {
  final bool isLoading;
  final Widget child;
  final String? loadingText;
  final double blurAmount;
  final Color overlayColor;

  const LoadingOverlay({
    Key? key,
    required this.isLoading,
    required this.child,
    this.loadingText,
    this.blurAmount = 5.0,
    this.overlayColor = const Color(0x88000000), 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: blurAmount, sigmaY: blurAmount),
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: overlayColor,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      "assets/m_logo.png",
                      height: 50,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: 20),
                    
                    const SizedBox(
                      width: 35,
                      height: 35,
                      child: CircularProgressIndicator(
                        strokeWidth: 3,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
                    
                    if (loadingText != null) ...[
                      const SizedBox(height: 16),
                      Text(
                        loadingText!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}
