import 'dart:io';
import 'dart:convert';
import 'package:age_guesser/modules/name_age/model/name_age.dart';
import 'package:http/http.dart' as http;

// ignore: constant_identifier_names
const API_BASE = 'https://api.agify.io';

class NameAgeApi {
  Future<NameAge> getAgeByName(String name) async {
    final response = await http.get(Uri.parse('$API_BASE?name=$name'));
    if (response.statusCode == HttpStatus.ok) {
      final json = jsonDecode(response.body);
      return NameAge.fromJson(json);
    }

    throw 'Failed to get estimated age for $name -'
        ' Expected 200 OK but got ${response.statusCode}.';
  }
}
