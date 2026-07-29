import 'package:dev_mate_ai/core/di/service_locator.dart';
import 'package:dev_mate_ai/core/widgets/custom_code_field.dart';
import 'package:dev_mate_ai/core/widgets/custom_snack_bar.dart'; // تأكد من استدعاء هذا الملف
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final local = S.of(context);

    return BlocConsumer<DebugCubit, DebugState>(
      listenWhen: (previous, current) =>
          previous.errorMessage != current.errorMessage ||
          previous.debugResult != current.debugResult,
      listener: (context, state) {
        if (state.errorMessage != null) {
          CustomSnackBar.show(
            context,
            message: state.errorMessage!,
            backgroundColor: Theme.of(context).colorScheme.error,
          );
          context.read<DebugCubit>().clearError();
        }

        if (state.debugResult != null && !state.isLoading) {
          final result = state.debugResult!;
          context.read<DebugCubit>().clearResult();
          context.pushNamed(RouteName.ansewerEplainCode, extra: result);
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: CustomAppBar(title: local.debugCode),
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
                        context.read<DebugCubit>().updateLanguage(value);
                      }
                    },
                  ),
                  const HeightSpace(height: 20),
                  CustomCodeEditor(
                    controller: _codeController,
                    onChanged: (code) {
                      context.read<DebugCubit>().updateCode(code);
                    },
                  ),
                  const HeightSpace(height: 20),
                  CustomDebugCodeTextField(
                    errorLogController: _errorLogController,
                    onChanged: (value) {
                      context.read<DebugCubit>().updateErrorLog(value);
                    },
                  ),
                  const HeightSpace(height: 20),
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
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
