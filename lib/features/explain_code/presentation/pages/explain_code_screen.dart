import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dev_mate_ai/core/di/service_locator.dart';
import 'package:dev_mate_ai/core/widgets/custom_snack_bar.dart';
import 'package:dev_mate_ai/features/chat_screen/data/datasource/firebase_chat_data_source.dart';
import 'package:dev_mate_ai/features/explain_code/presentation/cubit/explain_code_cubit.dart';
import 'package:dev_mate_ai/features/explain_code/presentation/cubit/explain_code_state.dart';
import 'package:dev_mate_ai/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:re_editor/re_editor.dart';

import '../../../../core/routing/route_name.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_dropdown_button_field.dart';
import '../../../../core/widgets/custom_feature_button.dart';
import '../../../../core/widgets/language_helper.dart';
import '../../../../core/widgets/spacing_widgets.dart';
import '../../../../core/widgets/custom_code_field.dart';
import '../widgets/custom_explain_code_text_field.dart';

class ExplainCodeScreen extends StatelessWidget {
  const ExplainCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ExplainCubit>(),
      child: const ExplainCodeView(),
    );
  }
}

class ExplainCodeView extends StatefulWidget {
  const ExplainCodeView({super.key});

  @override
  State<ExplainCodeView> createState() => _ExplainCodeViewState();
}

class _ExplainCodeViewState extends State<ExplainCodeView> {
  late final CodeLineEditingController _codeController;
  late final TextEditingController _instructionsController;

  @override
  void initState() {
    super.initState();
    _instructionsController = TextEditingController();
    _codeController = CodeLineEditingController();
  }

  @override
  void dispose() {
    _codeController.dispose();
    _instructionsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final local = S.of(context);
    return BlocConsumer<ExplainCubit, ExplainCodeState>(
      listenWhen: (previous, current) =>
          previous.errorMessage != current.errorMessage ||
          previous.explanation != current.explanation,
      listener: (context, state) {
        if (state.errorMessage != null) {
          CustomSnackBar.show(context, message: "",backgroundColor: Theme.of(context).colorScheme.error);
          context.read<ExplainCubit>().clearError();
        }

        if (state.explanation != null && !state.isLoading) {
          final cubit = context.read<ExplainCubit>();
          final explanation = state.explanation;

          _saveAndNavigate(context, state, explanation!);
          cubit.resetExplanation();
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: CustomAppBar(title: local.explainCode),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const HeightSpace(height: 35),
                  CustomDropdownbuttonfield(
                    labelText: local.language,
                    hintText: local.selectProgrammingLang,
                    items: LanguageHelper.languages,
                    initialValue: state.language,
                    onChanged: (value) {
                      if (value != null) {
                        context.read<ExplainCubit>().updateLanguage(value);
                      }
                    },
                  ),
                  const HeightSpace(height: 20),
                  CustomCodeEditor(controller: _codeController),
                  const HeightSpace(height: 20),
                  CustomExplainCodeTextField(
                    instructionsController: _instructionsController,
                  ),
                  const HeightSpace(height: 20),
                  CustomFeatureButton(
                    text: local.explainCode,
                    isLoading: state.isLoading,
                    onTap: state.isLoading
                        ? null
                        : () {
                            FocusScope.of(context).unfocus();
                            context.read<ExplainCubit>().submitExplain(
                              code: _codeController.text,
                              additionalInstructions:
                                  _instructionsController.text,
                            );
                          },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _saveAndNavigate(
    BuildContext context,
    ExplainCodeState state,
    String explanation,
  ) async {
    final prompt = [
      'Language: ${state.language}',
      'Code:',
      state.code,
      if (state.additionalInstructions.isNotEmpty)
        'Instructions: ${state.additionalInstructions}',
    ].join('\n');

    try {
      await FirebaseChatDataSource(
        firestore: FirebaseFirestore.instance,
      ).saveQuickToolConversation(
        title: 'Explain Code',
        type: 'Explain Code',
        prompt: prompt,
        response: explanation,
      );
    } catch (_) {}

    if (!mounted) return;
    GoRouter.of(
      context,
    ).pushNamed(RouteName.ansewerEplainCode, extra: explanation);
  }
}
