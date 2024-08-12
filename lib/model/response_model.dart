class ResponseModel{
  bool _isSuccess;
  String _msg;

  ResponseModel(
     this._isSuccess,
     this._msg
      );

  String get message => _msg;
  bool get isSuccess => _isSuccess;

}