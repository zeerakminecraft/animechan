import 'package:animechanproject/model/anime_datamodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreDoc{
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<void> addLikes({required AnimeData anime, required String uid})async{
    final _mainCollection = _firestore.doc('likedquotes/${uid}');
    final data = <String, dynamic>{
      'liked_Quotes' : FieldValue.arrayUnion([anime.toMap()])
    };
    await _mainCollection.set(data);
  }
}