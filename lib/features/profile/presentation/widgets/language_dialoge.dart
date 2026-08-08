import 'package:dev_mate_ai/generated/l10n.dart';
import 'package:dev_mate_ai/l10n/local_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LanguageDialog extends StatelessWidget {
  const LanguageDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final local = S.of(context);
    return AlertDialog(
      title: Text(local.chooseLang),
      content: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 360),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.language),
              title: Text(local.english),
              onTap: () {
                context.read<LocaleCubit>().changeLanguage("en");
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.language),
              title: Text(local.arabic),
              onTap: () {
                context.read<LocaleCubit>().changeLanguage("ar");
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
