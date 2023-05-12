import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List> search(String keyword) async {
  Uri requestUri =
      Uri.parse('https://www.googleapis.com/youtube/v3/search?'
          'key=AIzaSyAqnCklYxDNeQO1Izd5-0B3ZlkIkhCVoIg'
          '&part=snippet'
          '&q=$keyword'
          '&maxResults=20');
  final response = await http.get(requestUri);
  final List body = json.decode(response.body)['items'];
  return body.where((element) => element['id']['kind'] == 'youtube#video').toList();
}