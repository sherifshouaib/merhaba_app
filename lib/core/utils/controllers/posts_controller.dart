import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:supabase_flutter/supabase_flutter.dart';

class PostsController {
  static Future<Map<String, dynamic>> uploadPostMedia(File file) async {
    try {
      String fileName =
          "${DateTime.now().toIso8601String().replaceAll(" ", "").replaceAll(".", "").replaceAll(":", "")}_${p.basename(file.path).replaceAll(" ", "")}";

      final String fullPath = await Supabase.instance.client.storage
          .from('Posts')
          .upload(
            fileName,
            file,
            fileOptions: const FileOptions(cacheControl: '3600', upsert: false),
          );

      final String publicUrl = await Supabase.instance.client.storage
          .from("Posts")
          .getPublicUrl(fileName);

      return {
        "result": true,
        "message": "Uploaded successfully ... ",
        "url": publicUrl,
        "fileName": fileName,
        "fullPath": fullPath,
      };
    } catch (e) {
      print(e.toString());
      return {"result": false, "message": e.toString()};
    }
  }
}
