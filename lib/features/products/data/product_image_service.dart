import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class ProductImageService {
  final ImagePicker _picker = ImagePicker();

  // Seleccionar fotografía desde la galería.
  Future<XFile?> pickFromGallery() async {
    return await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
      maxWidth: 1800,
    );
  }

  // Guardar fotografía permanentemente en el dispositivo.
  Future<String> saveLocalImage(XFile image) async {
    final directory = await getApplicationSupportDirectory();

    final imageDirectory = Directory(p.join(directory.path, 'product_images'));

    if (!await imageDirectory.exists()) {
      await imageDirectory.create(recursive: true);
    }

    final extension = p.extension(image.path).toLowerCase();

    final filename =
        '${DateTime.now().microsecondsSinceEpoch}'
        '${extension.isEmpty ? '.jpg' : extension}';

    final destination = File(p.join(imageDirectory.path, filename));

    await File(image.path).copy(destination.path);

    return destination.path;
  }

  // Eliminar una fotografía local.
  Future<void> deleteLocalImage(String imagePath) async {
    final directory = await getApplicationSupportDirectory();

    final imageDirectory = p.normalize(
      p.join(directory.path, 'product_images'),
    );

    final normalizedPath = p.normalize(imagePath);

    // No permitir borrar archivos fuera de nuestra carpeta.
    if (!p.isWithin(imageDirectory, normalizedPath)) {
      return;
    }

    final image = File(normalizedPath);

    if (await image.exists()) {
      await image.delete();
    }
  }

  // Validar que una URL utilice HTTPS.
  static bool isValidImageUrl(String value) {
    final uri = Uri.tryParse(value.trim());

    return uri != null &&
        uri.scheme == 'https' &&
        uri.host.isNotEmpty &&
        !value.trim().contains(RegExp(r'\s'));
  }
}
