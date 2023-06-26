class ApiEndpoint {
  ClientEndpoints client = ClientEndpoints();
  AdminEndpoints admin = AdminEndpoints();

  /////////AUTHENTICATION/////////
  String get auth => "login";
  String get cities => "cities";
  String get blogs => "blogs";
}
/////////CLIENT/////////

class ClientEndpoints {
  ClientEndpoints();

  String get services => "services";
  String get products => "products";
  String get productCategories => "products/category";
}

/////////ADMIN/////////
class AdminEndpoints {
  AdminEndpoints();
}
