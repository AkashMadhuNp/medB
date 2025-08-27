import 'package:medb/core/model/menu_model.dart';

class MenuModule {
  final int moduleId;
  final String moduleName;
  final int sortOrder;
  final String? moduleIcon;
  final List<MenuItem> menus;

  MenuModule({
    required this.moduleId,
    required this.moduleName,
    required this.sortOrder,
    this.moduleIcon,
    required this.menus,
  });

  factory MenuModule.fromJson(Map<String, dynamic> json) {
    return MenuModule(
      moduleId: json['moduleId'] ?? 0,
      moduleName: json['moduleName'] ?? '',
      sortOrder: json['sortOrder'] ?? 0,
      moduleIcon: json['moduleIcon'],
      menus: (json['menus'] as List<dynamic>?)
          ?.map((item) => MenuItem.fromJson(item as Map<String, dynamic>))
          .toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'moduleId': moduleId,
      'moduleName': moduleName,
      'sortOrder': sortOrder,
      'moduleIcon': moduleIcon,
      'menus': menus.map((menu) => menu.toJson()).toList(),
    };
  }

  @override
  String toString() {
    return 'MenuModule(id: $moduleId, name: $moduleName, menusCount: ${menus.length})';
  }
}
