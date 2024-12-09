class DataResponse<T> {
  final bool success;
  final String? message;
  final T? data;

  DataResponse({
    required this.success,
    this.message,
    this.data,
  });
}
