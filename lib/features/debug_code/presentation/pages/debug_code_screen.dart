import 'dart:async';

import 'package:dev_mate_ai/core/di/service_locator.dart';
import 'package:dev_mate_ai/core/widgets/custom_code_field.dart';
import 'package:dev_mate_ai/core/widgets/custom_snack_bar.dart';
import 'package:dev_mate_ai/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:re_editor/re_editor.dart';

import '../../../../core/routing/route_name.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_dropdown_button_field.dart';
import '../../../../core/widgets/custom_feature_button.dart';
import '../../../../core/widgets/language_helper.dart';
import '../../../../core/widgets/spacing_widgets.dart';
import '../cubit/debug_code_cubit.dart';
import '../cubit/debug_code_state.dart';
import '../widgets/custom_debug_code_text_field.dart';

class DebugCodeScreen extends StatelessWidget {
  const DebugCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<DebugCubit>(),
      child: const DebugCodeView(),
    );
  }
}

class DebugCodeView extends StatefulWidget {
  const DebugCodeView({super.key});

  @override
  State<DebugCodeView> createState() => _DebugCodeViewState();
}

class _DebugCodeViewState extends State<DebugCodeView> {
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

    return BlocConsumer<DebugCubit, DebugState>(
      listenWhen: (previous, current) =>
          previous.isLoading != current.isLoading ||
          previous.errorMessage != current.errorMessage ||
          previous.debugResult != current.debugResult,

      listener: (context, state) {
        // ============================================================
        // Loading
        // ============================================================

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

        // ============================================================
        // Error
        // ============================================================

        if (state.errorMessage != null) {
          CustomSnackBar.show(
            context,
            message: state.errorMessage!,
            backgroundColor: Theme.of(context).colorScheme.error,
          );

          context.read<DebugCubit>().clearError();
        }

        // ============================================================
        // Success
        // ============================================================

        if (state.debugResult != null && !state.isLoading) {
          final result = state.debugResult!;

          context.read<DebugCubit>().clearResult();

          context.pushNamed(RouteName.ansewerEplainCode, extra: result);
        }
      },

      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },

          child: Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,

            appBar: CustomAppBar(title: local.debugCode),

            body: LayoutBuilder(
              builder: (context, constraints) {
                final width = constraints.maxWidth;

                // ==================================================
                // Breakpoints
                // ==================================================

                final isTablet = width >= 600;
                final isDesktop = width >= 1024;

                // ==================================================
                // Responsive Padding
                // ==================================================

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

                // ==================================================
                // Maximum Content Width
                // ==================================================

                final maxWidth = isDesktop
                    ? 950.0
                    : isTablet
                    ? 750.0
                    : double.infinity;

                // ==================================================
                // Code Editor Height
                // ==================================================

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

                              items: LanguageHelper.languages,

                              initialValue: state.language,

                              onChanged: (value) {
                                if (value != null) {
                                  context.read<DebugCubit>().updateLanguage(
                                    value,
                                  );
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

                              onChanged: (code) {
                                context.read<DebugCubit>().updateCode(code);
                              },
                            ),

                            const HeightSpace(height: 20),

                            // ==================================================
                            // Error Log
                            // ==================================================
                            CustomDebugCodeTextField(
                              errorLogController: _errorLogController,

                              maxLines: isDesktop
                                  ? 5
                                  : isTablet
                                  ? 4
                                  : 3,

                              onChanged: (value) {
                                context.read<DebugCubit>().updateErrorLog(
                                  value,
                                );
                              },
                            ),

                            const HeightSpace(height: 24),

                            // ==================================================
                            // Debug Button
                            // ==================================================
                            CustomFeatureButton(
                              text: local.debugCode,

                              isLoading: state.isLoading,

                              onTap: state.isLoading
                                  ? null
                                  : () {
                                      FocusScope.of(context).unfocus();

                                      context.read<DebugCubit>().submitDebug();
                                    },
                            ),

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
