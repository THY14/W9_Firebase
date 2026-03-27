import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../model/songs/song.dart';
import '../../dtos/song_dto.dart';
import 'song_repository.dart';

const String baseUrl = "w9-db-8d7c4-default-rtdb.asia-southeast1.firebasedatabase.app";

class SongRepositoryFirebase extends SongRepository {
  final Uri songsUri = Uri.https(baseUrl, '/songs.json');
  List<Song>? _cache;

  @override
  Future<List<Song>> fetchSongs() async {
    if (_cache != null) return _cache!;

    final http.Response response = await http.get(songsUri);

    if (response.statusCode == 200) {
      final Map<String, dynamic> songJson = json.decode(response.body);

      List<Song> songs = [];
      songJson.forEach((id, data) {
        final Song song = SongDto.fromJson(id, data);
        songs.add(song);
      });

      _cache = songs;
      return _cache!;
    } else {
      throw Exception('Failed to load songs');
    }
  }

  @override
  Future<Song?> fetchSongById(String id) async {
    final List<Song> songs = await fetchSongs();
    try {
      return songs.firstWhere((song) => song.id == id);
    } catch (_) {
      return null;
    }
  }
}