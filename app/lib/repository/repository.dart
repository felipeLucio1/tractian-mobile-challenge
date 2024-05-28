import 'package:http/http.dart' as http;

const url = "https://fake-api.tractian.com";

Future<http.Response> fetchCompanies(http.Client client) async {
  return client.get(Uri.parse("$url/companies"));
}
