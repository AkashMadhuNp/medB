class MenuItem {
  final int menuId;
  final String menuName;
  final int sortOrder;
  final String? menuIcon;
  final String? actionName;
  final String? controllerName;
  final Map<String, dynamic> rights;

  MenuItem({
    required this.menuId,
    required this.menuName,
    required this.sortOrder,
    this.menuIcon,
    this.actionName,
    this.controllerName,
    required this.rights,
  });

  factory MenuItem.fromJson(Map<String, dynamic> json) {
    return MenuItem(
      menuId: json['menuId'] ?? 0,
      menuName: json['menuName'] ?? '',
      sortOrder: json['sortOrder'] ?? 0,
      menuIcon: json['menuIcon'],
      actionName: json['actionName'],
      controllerName: json['controllerName'],
      rights: json['rights'] ?? {},
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'menuId': menuId,
      'menuName': menuName,
      'sortOrder': sortOrder,
      'menuIcon': menuIcon,
      'actionName': actionName,
      'controllerName': controllerName,
      'rights': rights,
    };
  }

  // Helper method to get route from controllerName
  String? get route {
    if (controllerName != null && controllerName!.isNotEmpty) {
      return '/${controllerName!.replaceAll('app/', '')}';
    }
    return null;
  }

  @override
  String toString() {
    return 'MenuItem(id: $menuId, name: $menuName, order: $sortOrder)';
  }
}
