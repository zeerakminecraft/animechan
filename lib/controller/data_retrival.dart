import 'dart:convert';
import 'package:http/http.dart';
import 'package:animechanproject/model/anime_datamodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class FetchData{

  static Future<List<AnimeData>> tenRandomQuotes() async {
    String url = 'https://animechan.vercel.app/api/quotes';
    try {
      final response = await get(Uri.parse(url));
      final List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData.map<AnimeData>((e) => AnimeData.fromJson(e as Map<String, dynamic>)).toList();
    } catch (e) {
      throw ("Error $e");
    }
  }

  static Future<List<AnimeData>> searchByAnimeName(String name) async{
    String url = 'https://animechan.vercel.app/api/quotes/anime?title=${name}';
    try {
      final response = await get(Uri.parse(url));
      final List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData.map<AnimeData>((e) => AnimeData.fromJson(e as Map<String, dynamic>)).toList();
    } catch (e) {
      throw ("Error $e");
    }
  }

  static Stream<List<AnimeData>> populateLikedAnime(String uid){
    final documentStream = FirebaseFirestore.instance.collection('likedquotes').doc(uid).snapshots();
    // return documentStream.map((event) => AnimeData.fromJson(event.data()));
  }
}

// (doc) => AnimeData(
// anime: doc.data['anime'],
// character: doc.data['character'],
// quote: doc.data['quote'],
)