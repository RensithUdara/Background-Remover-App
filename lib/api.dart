import 'dart:typed_data';

import 'package:http/http.dart' as http;

class Api {
  static Future<Uint8List?> removeBackground(String image) async {
    final apiKey = "aS4Fxq6Ru1XGFX81rJjGcPg4";
    final uri = Uri.parse('https://api.remove.bg/v1.0/removebg');

    try {
      var request =
          http.MultipartRequest('POST', uri)
            ..headers['X-Api-Key'] = apiKey
            ..files.add(await http.MultipartFile.fromPath('image_file', image));

      var response = await request.send();

      if (response.statusCode == 200) {
        Uint8List transparentImage = await response.stream.toBytes();
        return transparentImage;
      } else {
        print('Failed: ${response.statusCode}');
        print(await response.stream.bytesToString());
      }
    } catch (e) {
      print(e.toString());
    }
    return null;
  }
}
