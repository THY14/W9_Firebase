import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../model/artists/song_with_artist.dart';
import '../../../theme/theme.dart';
import '../../../utils/async_value.dart';
import '../../../widgets/song/song_tile.dart';
import '../view_model/library_view_model.dart';

class LibraryContent extends StatelessWidget {
  const LibraryContent({super.key});

  @override
  Widget build(BuildContext context) {
    final LibraryViewModel vm = context.watch<LibraryViewModel>();

    final AsyncValue<List<SongWithArtist>> asyncValue = vm.songsValue;

    Widget content;
    switch (asyncValue.state) {

      case AsyncValueState.loading:
        content = const Center(child: CircularProgressIndicator());
        break;

      case AsyncValueState.error:
        content = Center(
          child: Text(
            'Error: ${asyncValue.error}',
            style: const TextStyle(color: Colors.red),
          ),
        );
        break;

      case AsyncValueState.success:
        List<SongWithArtist> songs = asyncValue.data!;
        content = ListView.builder(
          itemCount: songs.length,
          itemBuilder: (context, index) => SongTile(
            songWithArtist: songs[index],
            isPlaying: vm.isSongPlaying(songs[index]),
            onTap: () => vm.start(songs[index]),
          ),
        );
    }

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 16),
          Text('Library', style: AppTextStyles.heading),
          const SizedBox(height: 50),
          Expanded(child: content),
        ],
      ),
    );
  }
}