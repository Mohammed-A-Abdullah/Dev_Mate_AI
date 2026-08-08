import 'package:dev_mate_ai/core/theme/extensions/profile_theme_extension.dart';
import 'package:flutter/material.dart';

class CustomImageSection extends StatelessWidget {
  const CustomImageSection({super.key, this.photoUrl, this.onTap});
  final String? photoUrl;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 96,
          height: 96,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [
                Theme.of(
                  context,
                ).extension<ProfileThemeExtension>()!.profilCardGradient,
                Theme.of(
                  context,
                ).extension<ProfileThemeExtension>()!.secondprofilCardGradient,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            border: Border.all(
              color: Theme.of(context).colorScheme.outline,
              width: 2,
            ),
          ),
          child: ClipOval(
            child: photoUrl != null
                ? Image.network(
                    photoUrl!,
                    fit: BoxFit.cover,
                    errorBuilder: (_, _, _) =>
                        const Icon(Icons.person, size: 44, color: Colors.white),
                  )
                : const Icon(Icons.person, size: 44, color: Colors.white),
          ),
        ),
        Positioned(
          bottom: -2,
          right: -2,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(999),
            child: Container(
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(
                  context,
                ).extension<ProfileThemeExtension>()!.profilCard,
                border: Border.all(
                  color: Theme.of(context).colorScheme.outline,
                  width: 2,
                ),
              ),
              child: const Icon(Icons.edit, size: 14),
            ),
          ),
        ),
      ],
    );
  }
}
