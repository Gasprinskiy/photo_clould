import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key});

 
  @override
  @override
  State<GalleryScreen> createState() => _GalleryScreen();
}

class _GalleryScreen extends State<GalleryScreen> {
  List<String> _groupeKeys = [];
  Map<String, List<AssetEntity>> _groupes = {};

  @override
  void initState() {
    super.initState();
    _fetchAlbums();
  }
  

  Future<void> _fetchAlbums() async {
    final List<AssetPathEntity> albums = await PhotoManager.getAssetPathList(
      type: RequestType.all,
      filterOption: FilterOptionGroup(
        imageOption: const FilterOption(
          sizeConstraint: SizeConstraint(ignoreSize: true),
        ),
        orders: [const OrderOption(type: OrderOptionType.createDate, asc: false)],
      ),
    );
    final picsAlbum = albums.firstWhere((album) => album.name == 'Camera');
    final end = await picsAlbum.assetCountAsync;

    final List<AssetEntity> allAssets = await picsAlbum.getAssetListRange(
      start: 0,
      end: end,
    );

    Map<String, List<AssetEntity>> grouped = {};

    for (final asset in allAssets) {
      final date = asset.createDateTime;
      final key = "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
      // final file = await asset.file;
      grouped.putIfAbsent(key, () => []).add(asset);
    }

    setState(() {
      _groupes = grouped;
      _groupeKeys = grouped.keys.toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: _groupeKeys.length,
        itemBuilder: (context, index) {
          final key = _groupeKeys[index];
          final assets = _groupes[key]!;

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  key,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: assets.length,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 4,
                  mainAxisSpacing: 4,
                ),
                itemBuilder: (context, i) {
                  return FutureBuilder<Uint8List?>(
                    future: assets[i].thumbnailData,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                        return Image.memory(snapshot.data!, fit: BoxFit.cover);
                      } else {
                        return const Center(child: CircularProgressIndicator(strokeWidth: 1));
                      }
                    },
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}