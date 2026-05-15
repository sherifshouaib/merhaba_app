import 'dart:io';
import 'package:flutter/material.dart';
import 'package:merhaba/core/utils/controllers/auth_controller.dart';
import 'package:merhaba/main_development.dart';
import 'package:path/path.dart' as p;
import 'package:supabase_flutter/supabase_flutter.dart';

class PostsController {
  static Future<List<Map<String, dynamic>>> getAllPosts() async {
    try {
      var res = await Supabase.instance.client.from("posts").select();

      return res;
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }

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
      debugPrint(e.toString());
      return {"result": false, "message": e.toString()};
    }
  }





  static Future<Map<String, dynamic>> addPost(Map<String, dynamic> data) async {
    try {
      var uid = await secureStorage.read(key: "uid");

      if (uid == null) {
        return {"result": false, "message": "Please login again!!"};
      }

      var currentUserDataRes = await AuthController.getCurrentUserData();

      if (currentUserDataRes["result"] == false) {
        return currentUserDataRes;
      }

      Map<String, dynamic> currentUserData = Map<String, dynamic>.from(
        currentUserDataRes["data"] as Map,
      );

      var userData = currentUserData["user_metadata"] as Map<String, dynamic>;

      var username = userData["fullName"];
      var photoUrl = userData["picUrl"] == null
          ? ""
          : userData["picUrl"].toString();

      data["username"] = username;
      data["user_photo"] = photoUrl;
      data["user_id"] = uid;
      data["added_by"] = uid;
      data["updated_by"] = uid;
      data["date_added"] = DateTime.now().toIso8601String();
      data["date_updated"] = DateTime.now().toIso8601String();
      data["user_photo_updated_at"] = DateTime.now().toIso8601String();

      
      await Supabase.instance.client.from("posts").insert(data);

      return {"result": true, "message": "Posted successfully ... "};
    } catch (e) {
      debugPrint(e.toString());
      return {"result": false, "message": e.toString()};
    }
  }
}
