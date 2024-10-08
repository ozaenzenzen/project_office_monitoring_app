class DetailLocationTopHandler {
  static final DetailLocationTopHandler _instance = DetailLocationTopHandler._internal();

  factory DetailLocationTopHandler() {
    return _instance;
  }

  DetailLocationTopHandler._internal();

  String data = "Initial Data";
}
