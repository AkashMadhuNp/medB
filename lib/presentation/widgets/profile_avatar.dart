import 'package:flutter/material.dart';
import 'package:medb/core/colors/colors.dart';
import 'package:medb/core/service/auth_service.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final menuModules = AuthService.sortedModules;
    String? moduleIconUrl;

    if (menuModules.isNotEmpty) {
      moduleIconUrl = menuModules.first.moduleIcon;
    }

    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColors.grey,
          width: 3,
        ),
      ),
      child: CircleAvatar(
        radius: 80,
        backgroundColor: AppColors.surface,
        child: _buildModuleIcon(moduleIconUrl),
      ),
    );
  }

  Widget _buildModuleIcon(String? iconUrl) {
    if (iconUrl != null && iconUrl.isNotEmpty && iconUrl.startsWith('http')) {
      return ClipOval(
        child: Image.network(
          iconUrl,
          width: 140,
          height: 140,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            print('🔴 Failed to load module icon: $iconUrl');
            print('🔴 Error Type: ${error.runtimeType}');
            print('🔴 Error Details: $error');
            if (stackTrace != null) {
              print('🔴 Stack Trace: ${stackTrace.toString().split('\n').take(3).join('\n')}');
            }
            
            return Icon(
              _getFallbackIcon(iconUrl),
              size: 80,
              color: Colors.grey[600],
            );
          },
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return SizedBox(
              width: 140,
              height: 140,
              child: Center(
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded / 
                        loadingProgress.expectedTotalBytes!
                      : null,
                ),
              ),
            );
          },
        ),
      );
    }
    
    return Icon(
      _getFallbackIcon(null),
      size: 80,
      color: Colors.grey[600],
    );
  }

  IconData _getFallbackIcon(String? iconUrl) {
    if (iconUrl != null) {
      if (iconUrl.contains('appointment') || iconUrl.contains('calendar')) {
        return Icons.calendar_today;
      } else if (iconUrl.contains('health') || iconUrl.contains('record')) {
        return Icons.medical_information;
      } else if (iconUrl.contains('account') || iconUrl.contains('profile')) {
        return Icons.person;
      }
    }
    return Icons.person;
  }
}