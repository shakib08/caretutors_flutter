import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/care_tutors.dart';

class ApiService {
  final String apiKey = '18QBwoiRpbFgeYBSl3PxFHi2aoJjrt7lIindJfng';

  Future<CareTutors> fetchNasaImage(String date) async {
    final response = await http.get(Uri.parse(
        'https://api.nasa.gov/planetary/apod?api_key=$apiKey&date=$date'));

    if (response.statusCode == 200) {
      return CareTutors.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load image');
    }
  }
}
