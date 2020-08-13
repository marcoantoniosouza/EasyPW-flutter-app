import '../env.dart' as env;

String url = env.apiBaseUrl;

Map<String, String> headers = {
  "Content-Type": "application/json",
  "Authorization": env.apiBasicAuth
};
