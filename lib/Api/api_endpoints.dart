class ApiEndpoint {
  ClientEndpoints client = ClientEndpoints();
  AdminEndpoints admin = AdminEndpoints();

  /////////AUTHENTICATION/////////
  String get login => "user/auth/signin";
  String get signUp => "user/auth/signup";
  String get me => "user/auth/me";
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
