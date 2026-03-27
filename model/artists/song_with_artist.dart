import 'artist.dart';
import '../songs/song.dart';

class SongWithArtist {
  final Song song;
  final Artist artist;

  SongWithArtist({
    required this.song,
    required this.artist,
  });

  String   get id          => song.id;
  String   get title       => song.title;
  String   get imageUrl    => song.imageUrl;
  Duration get duration    => song.duration;

  String   get artistName  => artist.name;
  String   get artistGenre => artist.genre;
}