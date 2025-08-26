class MenuData {
  final String id;
  final String name;
  final String? icon;
  final String? route;
  final String? module;
  final int order;
  final bool isActive;
  final List<MenuData>? subMenus;

  MenuData({
    required this.id,
    required this.name,
    this.icon,
    this.route,
    this.module,
    required this.order,
    this.isActive = true,
    this.subMenus,
  });

  factory MenuData.fromJson(Map<String, dynamic> json) {
    return MenuData(
      id: json['id'] ?? json['_id'] ?? '',
      name: json['name'] ?? '',
      icon: json['icon'],
      route: json['route'],
      module: json['module'],
      order: json['order'] ?? 0,
      isActive: json['isActive'] ?? true,
      subMenus: (json['subMenus'] as List<dynamic>?)
          ?.map((item) => MenuData.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}