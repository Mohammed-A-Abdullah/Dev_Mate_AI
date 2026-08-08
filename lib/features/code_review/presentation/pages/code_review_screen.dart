import 'dart:async';

import 'package:dev_mate_ai/core/widgets/custom_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:re_editor/re_editor.dart';

import '../../../../core/di/service_locator.dart';
import '../../../../core/routing/route_name.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_dropdown_button_field.dart';
import '../../../../core/widgets/custom_feature_button.dart';
import '../../../../core/widgets/language_helper.dart';
import '../../../../core/widgets/spacing_widgets.dart';
import '../../../../generated/l10n.dart';
import '../../../../core/widgets/custom_code_field.dart';
import '../cubit/code_review_cubit.dart';
import '../cubit/code_review_state.dart';
import '../widgets/custom_review_text_field.dart';
import '../widgets/custom_reveiw_types_chips.dart';

class CodeReviewScreen extends StatelessWidget {
  const CodeReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<CodeReviewCubit>(),
      child: const CodeReviewView(),
    );
  }
}

class CodeReviewView extends StatefulWidget {
  const CodeReviewView({super.key});

  @override
  State<CodeReviewView> createState() => _CodeReviewViewState();
}

class _CodeReviewViewState extends State<CodeReviewView> {
  late final CodeLineEditingController _codeController;
  late final TextEditingController _errorLogController;

  Timer? _slowLoadingTimer;

  @override
  void initState() {
    super.initState();

    _codeController = CodeLineEditingController();
    _errorLogController = TextEditingController();
  }

  @override
  void dispose() {
    _codeController.dispose();
    _errorLogController.dispose();
    _slowLoadingTimer?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final local = S.of(context);

    return BlocConsumer<CodeReviewCubit, CodeReviewState>(
      listenWhen: (previous, current) =>
          previous.isLoading != current.isLoading ||
          previous.errorMessage != current.errorMessage ||
          previous.reviewResult != current.reviewResult,
      listener: (context, state) {
        // ------------------------------------------------------------
        // Loading
        // ------------------------------------------------------------

        if (state.isLoading) {
          _slowLoadingTimer?.cancel();

          _slowLoadingTimer = Timer(const Duration(seconds: 4), () {
            if (mounted && state.isLoading) {
              CustomSnackBar.show(
                context,
                message: local.processingMayTakeLonger,
                backgroundColor: Theme.of(context).colorScheme.primary,
                textColor: Theme.of(context).colorScheme.onPrimary,
                time: 5,
              );
            }
          });
        } else {
          _slowLoadingTimer?.cancel();
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        }

        // ------------------------------------------------------------
        // Error
        // ------------------------------------------------------------

        if (state.errorMessage != null) {
          CustomSnackBar.show(
            context,
            message: state.errorMessage!,
            backgroundColor: Theme.of(context).colorScheme.error,
          );

          context.read<CodeReviewCubit>().clearError();
        }

        // ------------------------------------------------------------
        // Success
        // ------------------------------------------------------------

        if (state.reviewResult != null && !state.isLoading) {
          context.pushNamed(
            RouteName.ansewerEplainCode,
            extra: state.reviewResult,
          );
        }
      },
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,

            appBar: CustomAppBar(title: local.codeReview),

            body: LayoutBuilder(
              builder: (context, constraints) {
                final width = constraints.maxWidth;

                // --------------------------------------------------
                // Breakpoints
                // --------------------------------------------------

                final isTablet = width >= 600;
                final isDesktop = width >= 1024;

                // --------------------------------------------------
                // Responsive Padding
                // --------------------------------------------------

                final horizontalPadding = isDesktop
                    ? 40.0
                    : isTablet
                    ? 28.0
                    : 16.0;

                final verticalPadding = isDesktop
                    ? 35.0
                    : isTablet
                    ? 30.0
                    : 20.0;

                // --------------------------------------------------
                // Maximum Content Width
                // --------------------------------------------------

                final maxWidth = isDesktop
                    ? 950.0
                    : isTablet
                    ? 750.0
                    : double.infinity;

                // --------------------------------------------------
                // Code Editor Height
                // --------------------------------------------------

                final editorHeight = isDesktop
                    ? 480.0
                    : isTablet
                    ? 400.0
                    : 320.0;

                return SingleChildScrollView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,

                  child: Center(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: maxWidth),

                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: horizontalPadding,
                          vertical: verticalPadding,
                        ),

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            // ==================================================
                            // Programming Language
                            // ==================================================
                            CustomDropdownbuttonfield(
                              labelText: local.language,
                              hintText: local.selectProgrammingLang,
                              initialValue: state.language,
                              items: LanguageHelper.languages,

                              onChanged: (value) {
                                if (value != null) {
                                  context
                                      .read<CodeReviewCubit>()
                                      .updateLanguage(value);
                                }
                              },
                            ),

                            const HeightSpace(height: 20),

                            // ==================================================
                            // Code Editor
                            // ==================================================
                            CustomCodeEditor(
                              controller: _codeController,
                              height: editorHeight,
                            ),

                            const HeightSpace(height: 20),

                            // ==================================================
                            // Experience Level
                            // ==================================================
                            CustomDropdownbuttonfield(
                              labelText: local.experienceLevel,
                              hintText: local.selectExperienceLevel,

                              items: const [
                                'Beginner',
                                'Intermediate',
                                'Advanced',
                                'Expert',
                              ],

                              initialValue: state.experienceLevel,

                              onChanged: (value) {
                                if (value != null) {
                                  context
                                      .read<CodeReviewCubit>()
                                      .updateExperienceLevel(value);
                                }
                              },
                            ),

                            const HeightSpace(height: 20),

                            // ==================================================
                            // Review Depth
                            // ==================================================
                            CustomDropdownbuttonfield(
                              labelText: local.reveiwDepth,

                              hintText: local.reviewDepthDes,

                              items: const [
                                'Quick Review',
                                'Detailed Review',
                                'In-depth Analysis',
                              ],

                              initialValue: state.reviewDepth,

                              onChanged: (value) {
                                if (value != null) {
                                  context
                                      .read<CodeReviewCubit>()
                                      .updateReviewDepth(value);
                                }
                              },
                            ),

                            const HeightSpace(height: 20),

                            // ==================================================
                            // Review Focus
                            // ==================================================
                            CustomReveiwTypesChips(state: state),

                            const HeightSpace(height: 20),

                            // ==================================================
                            // Project Context
                            // ==================================================
                            CustomReviewTextField(
                              errorLogController: _errorLogController,
                            ),

                            const HeightSpace(height: 24),

                            // ==================================================
                            // Review Button
                            // ==================================================
                            CustomFeatureButton(
                              isLoading: state.isLoading,

                              text: local.codeReview,

                              onTap: state.isLoading
                                  ? null
                                  : () {
                                      FocusScope.of(context).unfocus();

                                      context
                                          .read<CodeReviewCubit>()
                                          .submitReview(
                                            code: _codeController.text,
                                            errorLog: _errorLogController.text,
                                          );
                                    },
                            ),

                            // Extra bottom spacing
                            SizedBox(height: isDesktop ? 30 : 20),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
