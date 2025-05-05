import 'dart:convert';
import 'dart:typed_data';

class PhotoAsset {
  final String id;
  final String deviceAssetId;
  final Uint8List hash;
  final Uint8List thumbnailData;
  final DateTime createDate;
  final int width;
  final int height;
  final bool uploaded;

  PhotoAsset({
    required this.id,
    required this.deviceAssetId,
    required this.hash,
    required this.thumbnailData,
    required this.createDate,
    required this.width,
    required this.height,
    required this.uploaded,
  });

  factory PhotoAsset.fromJson(Map<String, dynamic> json) {
    return PhotoAsset(
      id: json['id'] as String,
      deviceAssetId: json['device_asset_Id'] as String,
      hash:  base64Decode(json['hash'] as String),
      thumbnailData:  base64Decode(json['thumbnail_data'] as String),
      createDate: DateTime.parse(json['create_date'] as String),
      width: json['width'] as int,
      height: json['height'] as int,
      uploaded: json['uploaded'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'device_asset_Id': deviceAssetId,
      'hash': base64Encode(hash),
      'thumbnail_data': base64Encode(thumbnailData),
      'create_date': createDate.toIso8601String(),
      'width': width,
      'height': height,
      'uploaded': uploaded,
    };
  }
}
