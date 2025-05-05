import 'dart:typed_data';

import 'package:image/image.dart' as img;

Uint8List createThumbnailFromBytes(Uint8List originalBytes, int maxSize) {
  final image = img.decodeImage(originalBytes);
  if (image == null) return originalBytes;

  final thumbnail = img.copyResize(
    image,
  );

  return Uint8List.fromList(img.encodeJpg(thumbnail));
}
