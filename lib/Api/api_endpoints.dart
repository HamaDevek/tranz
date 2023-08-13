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
  String get feedback => "feedback";
  String get metadata => "metadata";
  String get orderProduct => "products/order";
  String get orderService => "services/order";
  String get updateProfile => "user/update-profile";
  String get phoneTaken => "phone-taken";
}

/////////ADMIN/////////
class AdminEndpoints {
  AdminEndpoints();
  String get allOrders => "employee/home";
  String get employeeMe => "employee/me";
  String get acceptDeclineOrder => "employee/order-accept-decline";
}
