import 'dart:io';

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../main_development.dart';
import 'auth_controller.dart';
import 'package:path/path.dart' as p;

class CommentsController {
  // Add Comment

  static Future<Map<String, dynamic>> addComment(
    Map<String, dynamic> data,
  ) async {
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

      //////////////////////////////
      ///start typing code here ,tomorrow

      Map<String, dynamic> formData = {
        "user_id": uid,
        "added_by": uid,
        "updated_by": "",
        "date_added": DateTime.now().toIso8601String(),
        "date_updated": "",
        "active": true,
        "username": username,
        "user_photo": photoUrl,
        "reply_to": -1,
        "user_photo_updated_at": DateTime.now().toIso8601String(),
        ...data,
      };

      await Supabase.instance.client.from("post_comments").insert(formData);

      return {"result": true, "message": "Uploaded successfully ... "};
    } catch (e) {
      debugPrint(e.toString());
      return <String, dynamic>{'result': false, 'message': e.toString()};
    }
  }

  //Get Comments (For Post)

  static Future<List<Map<String, dynamic>>> getCommentsForPost(
    int postId,
  ) async {
    try {
      var res = await Supabase.instance.client
          .from("post_comments")
          .select()
          .eq("post_id", postId)
          .eq("active", true);

      return res;
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }

 //Get Comments Count (For Post)

  static Future<int> getCommentsCountForPost(
    int postId,
  ) async {
    try {
      var res = await Supabase.instance.client
          .from("post_comments")
          .select()
          .eq("post_id", postId)
          .eq("active", true).count();

      return res.count;
    } catch (e) {
      debugPrint(e.toString());
      return 0;
    }
  }



  // Reply to Comment

  static Future<Map<String, dynamic>> replyToComment(
    Map<String, dynamic> data,
  ) async {
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

      var userData = currentUserData["user_metadata"];
      var username = userData["fullName"].toString();
      var photoUrl = userData["picUrl"] == null
          ? ""
          : userData["picUrl"].toString();

      Map<String, dynamic> formData = {
        "user_id": uid,
        "added_by": uid,
        "updated_by": "",
        "date_added": DateTime.now().toIso8601String(),
        "date_updated": "",
        "active": true,
        "username": username,
        "user_photo": photoUrl,
        "user_photo_updated_at": DateTime.now().toIso8601String(),

        ...data,
      };

      await Supabase.instance.client.from("post_comments").insert(formData);

      return {"result": true, "message": "Uploaded successfully ... "};
    } catch (e) {
      debugPrint(e.toString());
      return {"result": false, "message": e.toString()};
    }
  }

  // Get Comment Replies

  static Future<List<Map<String, dynamic>>> getCommentReplies(
    int commentId,
  ) async {
    try {
      var res = await Supabase.instance.client
          .from("post_comments")
          .select()
          .eq("reply_to", commentId)
          .eq("active", true);
      return res;
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }

  // Upload Comment Image

  static Future<Map<String, dynamic>> uploadCommentImage(File file) async {
    try {
      String fileName =
          "${DateTime.now().toIso8601String().replaceAll(" ", "").replaceAll(".", "").replaceAll(":", "")}_${p.basename(file.path).replaceAll(" ", "")}";

      final String fullPath = await Supabase.instance.client.storage
          .from('Comments')
          .upload(
            fileName,
            file,
            fileOptions: const FileOptions(cacheControl: '3600', upsert: false),
          );

      final String publicUrl = await Supabase.instance.client.storage
          .from("Comments")
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

  // Upload Comment Video

  static Future<Map<String, dynamic>> uploadCommentVideo(File file) async {
    try {
      String fileName =
          "${DateTime.now().toIso8601String().replaceAll(" ", "").replaceAll(".", "").replaceAll(":", "")}_${p.basename(file.path).replaceAll(" ", "")}";

      final String fullPath = await Supabase.instance.client.storage
          .from('Comments')
          .upload(
            fileName,
            file,
            fileOptions: const FileOptions(cacheControl: '3600', upsert: false),
          );

      final String publicUrl = await Supabase.instance.client.storage
          .from("Comments")
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

  // Upload Comment Voice

  static Future<Map<String, dynamic>> uploadCommentVoice(File file) async {
    try {
      String fileName =
          "${DateTime.now().toIso8601String().replaceAll(" ", "").replaceAll(".", "").replaceAll(":", "")}_${p.basename(file.path).replaceAll(" ", "")}";

      final String fullPath = await Supabase.instance.client.storage
          .from('Comments')
          .upload(
            fileName,
            file,
            fileOptions: const FileOptions(cacheControl: '3600', upsert: false),
          );

      final String publicUrl = await Supabase.instance.client.storage
          .from("Comments")
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
}
