import '../../model/songs/song.dart';

class SongDto {
  static const String idKey       = 'id';
  static const String titleKey    = 'name';
  static const String artistKey   = 'artists';
  static const String durationKey = 'durationMs'; // in ms
  static const String imageUrl    = 'img';


  static Song fromJson(String id, Map<String, dynamic> json) {
    assert(json[titleKey]    is String);
    assert(json[artistKey]   is String);
    assert(json[durationKey] is int);
    assert(json[imageUrl]    is String); 

    return Song(
      id:       id,
      title:    json[titleKey],
      artistId:   json[artistKey],
      duration: Duration(milliseconds: json[durationKey]),
      imageUrl: json[imageUrl], artist: null,          
    );
  }

  /// Convert Song to JSON
  static Map<String, dynamic> toJson(Song song) {
    return {
      idKey:       song.id,
      titleKey:    song.title,
      artistKey:   song.artistId,
      durationKey: song.duration.inMilliseconds,
      imageUrl:    song.imageUrl,
    };
  }
}