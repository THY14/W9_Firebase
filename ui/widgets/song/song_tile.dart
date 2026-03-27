import 'package:flutter/material.dart';

import '../../../model/artists/song_with_artist.dart';

class SongTile extends StatelessWidget {
  const SongTile({
    super.key,
    required this.songWithArtist,
    required this.isPlaying,
    required this.onTap,
  });

  final SongWithArtist songWithArtist;
  final bool isPlaying;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: ListTile(
          onTap: onTap,
          leading: CircleAvatar(
            radius: 28,
            backgroundImage: NetworkImage(songWithArtist.imageUrl),
            backgroundColor: Colors.grey.shade200,
          ),
          title: Text(
            songWithArtist.title,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          subtitle: Text(
            '${songWithArtist.artistName} • ${songWithArtist.artistGenre}',
            style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
          ),
          trailing: Text(
            isPlaying ? 'Playing' : '',
            style: const TextStyle(color: Colors.amber),
          ),
        ),
      ),
    );
  }
}