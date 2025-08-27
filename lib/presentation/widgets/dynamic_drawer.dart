import 'package:flutter/material.dart';
import 'package:medb/core/model/menu_model.dart';
import 'package:medb/core/service/auth_service.dart';
import 'package:medb/core/model/menu_module_model.dart';

class DynamicDrawer extends StatefulWidget {
  final String currentScreen;
  final Function(String route, String screenName) onMenuTap;

  const DynamicDrawer({
    super.key,
    required this.currentScreen,
    required this.onMenuTap,
  });

  @override
  _DynamicDrawerState createState() => _DynamicDrawerState();
}

class _DynamicDrawerState extends State<DynamicDrawer> {
  Map<int, bool> _expandedModules = {};

  @override
  Widget build(BuildContext context) {
    final userDetails = AuthService.userDetails;
    final menuModules = AuthService.sortedModules;

    return Drawer(
      backgroundColor: Colors.grey[50],
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const SizedBox(height: 40),
                Image.asset(
                  "assets/medb_logo.png",
                  height: 60,
                  width: 60,
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: _buildMenuItems(context, menuModules, userDetails),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildMenuItems(
      BuildContext context, List<MenuModule> menuModules, dynamic userDetails) {
    List<Widget> widgets = [];

    if (menuModules.isEmpty) {
      widgets.add(const ListTile(title: Text('No menus available')));
      return widgets;
    }

    for (MenuModule module in menuModules) {
      _expandedModules.putIfAbsent(module.moduleId, () => false);

      widgets.add(
        InkWell(
          onTap: () {
            setState(() {
              bool wasExpanded = _expandedModules[module.moduleId]!;
              _expandedModules[module.moduleId] = !wasExpanded;
              
              if (wasExpanded || module.menus.isEmpty) {
                widget.onMenuTap('/home', 'Home');
              }
            });
          },
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Row(
              children: [
                _buildIcon(module.moduleIcon, size: 30),
                const SizedBox(width: 20),
                Expanded(
                  child: Text(
                    userDetails != null
                        ? '${userDetails.firstName} ${userDetails.lastName ?? ''}'
                        : module.moduleName,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[600],
                      letterSpacing: 1,
                    ),
                  ),
                ),
                if (module.menus.isNotEmpty)
                  Icon(
                    _expandedModules[module.moduleId]!
                        ? Icons.expand_less
                        : Icons.expand_more,
                    size: 20,
                    color: Colors.grey[600],
                  ),
              ],
            ),
          ),
        ),
      );

      if (_expandedModules[module.moduleId]! && module.menus.isNotEmpty) {
        for (MenuItem menu in module.menus) {
          widgets.add(_buildMenuItem(context, menu));
        }
      }
    }

    return widgets;
  }

  Widget _buildMenuItem(BuildContext context, MenuItem menu) {
    final isSelected = widget.currentScreen == menu.menuName;
    final route = menu.route ?? '/coming-soon';

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
      child: ListTile(
        selected: isSelected,
        selectedTileColor: Colors.blue[50],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        leading: _buildIcon(menu.menuIcon),
        title: Text(
          menu.menuName,
          style: TextStyle(
            color: isSelected ? Colors.blue[700] : Colors.grey[800],
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
        onTap: () => widget.onMenuTap(route, menu.menuName),
      ),
    );
  }

  Widget _buildIcon(String? iconUrl, {double size = 24}) {
    if (iconUrl != null && iconUrl.isNotEmpty && iconUrl.startsWith('http')) {
      return Image.network(
        iconUrl,
        width: size,
        height: size,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          print('🔴 Failed to load icon: $iconUrl');
          print('🔴 Error Type: ${error.runtimeType}');
          print('🔴 Error Details: $error');
          if (stackTrace != null) {
            print('🔴 Stack Trace: ${stackTrace.toString().split('\n').take(3).join('\n')}');
          }
          
          return Icon(
            _getFallbackIcon(iconUrl), 
            size: size, 
            color: Colors.grey[600]
          );
        },
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return SizedBox(
            width: size,
            height: size,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded / 
                    loadingProgress.expectedTotalBytes!
                  : null,
            ),
          );
        },
      );
    }
    return Icon(_getFallbackIcon(null), size: size, color: Colors.grey[600]);
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
    return Icons.circle_outlined;
  }
}