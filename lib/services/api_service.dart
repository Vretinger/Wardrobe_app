import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class ApiService {

  static const String baseUrl =
      'http://192.168.1.137:8000/api';

  static Future<void> uploadClothing({
    required String name,
    required String category,
    required String color,
    required String style,
    required String season,
    required File image,
  }) async {

    var request = http.MultipartRequest(
      'POST',
      Uri.parse('$baseUrl/upload-clothing/'),
    );

    request.fields['name'] = name;
    request.fields['category'] = category;
    request.fields['color'] = color;
    request.fields['style'] = style;
    request.fields['season'] = season;
    request.files.add(
      await http.MultipartFile.fromPath(
        'image',
        image.path,
      ),
    );

    var response = await request.send();

    if (response.statusCode != 201) {
      throw Exception('Failed to upload clothing');
    }
  }

  static Future<List<dynamic>> getClothing() async {

    final response = await http.get(
      Uri.parse('$baseUrl/clothing/'),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }

    throw Exception('Failed to load clothing');
  }

  static Future<void> createTrip({
  required String destination,
  required String startDate,
  required String endDate,
  required String activities,
}) async {

  final response = await http.post(
    Uri.parse('$baseUrl/trips/create/'),

    headers: {
      'Content-Type': 'application/json',
    },

    body: jsonEncode({
      'destination': destination,
      'start_date': startDate,
      'end_date': endDate,
      'activities': activities,
    }),
  );

  if (response.statusCode != 201) {
    throw Exception('Failed to create trip');
  }
}


static Future<List<dynamic>> getTrips() async {

  final response = await http.get(
    Uri.parse('$baseUrl/trips/'),
  );

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  }

  throw Exception('Failed to load trips');
}

static Future<Map<String, dynamic>>
    getPackingList(int tripId) async {

  final response = await http.get(
    Uri.parse(
      '$baseUrl/trips/$tripId/packing-list/',
    ),
  );

  if (response.statusCode == 200) {

    return jsonDecode(response.body);
  }

  throw Exception(
    'Failed to generate packing list',
  );
}
}