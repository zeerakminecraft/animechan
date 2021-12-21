
import 'package:animechanproject/controller/writing_data.dart';
import 'package:animechanproject/model/anime_datamodel.dart';
import 'package:animechanproject/view/quote_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:animechanproject/controller/data_retrival.dart';

import '../constants.dart';


class MainScreen extends StatefulWidget {
  static const String id = 'main_screen';

  const MainScreen({Key? key}) : super(key: key);
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  List<AnimeData> _animeJson =[];
  void populateAnime() async{
    final animeJson = await FetchData.tenRandomQuotes();
    setState(() {
      _animeJson = animeJson;
    });
  }

  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    populateAnime();
  }

  String? animename;

  void searchbyName() async{
    if(animename!=null){
      final animeJson = await FetchData.searchByAnimeName(animename!);
      setState(() {
        _animeJson = animeJson;
      });
    }
  }

  bool check = false;

  @override
  Widget build(BuildContext context) {
    if(_animeJson.isNotEmpty){
      return Scaffold(
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  child: const Text('Sign Out'),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.blueAccent),
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                  ),
                  onPressed: () async{
                    await FirebaseAuth.instance.signOut();
                    Navigator.pop(context);
                  },
                ),
              ),
              TextField(
                onChanged: (value){
                  animename=value;
                },
                decoration: kTextFieldDecoration.copyWith(hintText: 'Search by anime name'),
              ),
              ElevatedButton(
                child: Text('Search'),
                onPressed: searchbyName,
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: _animeJson.length,
                    // shrinkWrap: true,
                    itemBuilder: (context, i){
                      final anime = _animeJson[i];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => QuoteScreen(anime: anime),
                            ),
                          );
                        },
                        child: Card(
                          child: ListTile(
                            tileColor: Colors.white,
                            dense: true,
                            title: Text(
                                anime.quote
                            ),
                            subtitle: Text(
                                anime.character
                            ),
                            trailing: IconButton(
                              icon: const Icon(
                                Icons.favorite,
                              ),
                              color: check? Colors.red : Colors.blueGrey,
                              onPressed: (){
                                FirestoreDoc.addLikes(anime: anime, uid: FirebaseAuth.instance.currentUser!.uid);
                                setState(() {
                                  check ? false : true;
                                });
                              },
                            ),
                          ),
                        ),
                      );
                    }
                ),
                // StreamBuilder<List<AnimeData>>(
                //   stream: _likedanime,
                //   builder: (BuildContext context,snapshot){
                //     if (snapshot.hasError || snapshot.data == null) {
                //       return const Text('Something went wrong');
                //     }
                //
                //     if (snapshot.connectionState == ConnectionState.waiting) {
                //       return const Text("Loading");
                //     }
                //     final likedAnime = snapshot.data!;
                //     return ListView.builder(
                //         itemCount: _animeJson.length,
                //         // shrinkWrap: true,
                //         itemBuilder: (context, i){
                //           final anime = _animeJson[i];
                //           bool check = likedAnime.any((element) => element==anime);
                //           return GestureDetector(
                //             onTap: () {
                //               Navigator.push(
                //                 context,
                //                 MaterialPageRoute(
                //                 builder: (context) => QuoteScreen(anime: anime),
                //                 ),
                //               );
                //             },
                //             child: Card(
                //               child: ListTile(
                //                 tileColor: Colors.white,
                //                 dense: true,
                //                 title: Text(
                //                     anime.quote
                //                 ),
                //                 subtitle: Text(
                //                     anime.character
                //                 ),
                //                 trailing: IconButton(
                //                   icon: const Icon(
                //                     Icons.favorite,
                //                   ),
                //                   color: check? Colors.red : Colors.blueGrey,
                //                   onPressed: (){
                //                     FirestoreDoc.addLikes(anime: anime, uid: FirebaseAuth.instance.currentUser!.uid);
                //                   },
                //                 ),
                //               ),
                //             ),
                //           );
                //         }
                //     );
                //   },
                // ),
              ),
              const SizedBox(height: 5,),
              ElevatedButton(
                child: Text('Load More'),
                onPressed: populateAnime,
              )
            ],
          ),
        ),
      );

    }
    else{
      return const Scaffold(
        body: Center(
          child: Text('D A T A   L O A D I N G...'),
        ),
      );
    }
  }
}
