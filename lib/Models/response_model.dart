class ResponseModel<T> {
  bool isSuccess;
  T? data;
  String? message;
  int? responseCode;
  int? received;
  int? total;
  ResponseModel(
      {this.data,
      required this.isSuccess,
      this.responseCode,
      this.message,
      this.received,
      this.total});
}
