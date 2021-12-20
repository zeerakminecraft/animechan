import 'package:equatable/equatable.dart';

class AnimeData extends Equatable {
  String anime;
  String character;
  String quote;

  AnimeData({required this.anime, required this.character, required this.quote});

  factory AnimeData.fromJson(Map<String, dynamic> json){
    return AnimeData(
        anime: json['anime'],
        character: json['character'],
        quote: json['quote']
    );
  }

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'anime': anime,
      'character': character,
      'quote': quote,
    };
    return map;
  }

  @override
  // TODO: implement props
  List<Object> get props => [anime, character, quote];
}