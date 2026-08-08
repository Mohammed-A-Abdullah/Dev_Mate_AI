import 'package:dev_mate_ai/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum ImageSourceType { camera, gallery, delete }

class ImagePickerDialog extends StatelessWidget {
  const ImagePickerDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final local = S.of(context);
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: Text(
                  local.camera,
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                onTap: () => Navigator.pop(context, ImageSourceType.camera),
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: Text(
                  local.gallary,
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                onTap: () => Navigator.pop(context, ImageSourceType.gallery),
              ),
              ListTile(
                leading: const Icon(Icons.delete, color: Colors.redAccent),
                title: Text(
                  local.delete,
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent,
                  ),
                ),
                onTap: () => Navigator.pop(context, ImageSourceType.delete),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
