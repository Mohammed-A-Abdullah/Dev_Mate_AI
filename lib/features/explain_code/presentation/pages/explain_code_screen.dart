import 'package:dev_mate_ai/features/explain_code/domain/usecase/explain_code_use_case.dart';
import 'package:dev_mate_ai/features/explain_code/presentation/cubit/explain_code_cubit.dart';
import 'package:dev_mate_ai/features/explain_code/presentation/cubit/explain_code_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/routing/route_name.dart';
import '../../../../core/services/gemini_service.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_dropdownButtonField.dart';
import '../../../../core/widgets/custom_feature_button.dart';
import '../../../../core/widgets/language_helper.dart';
import '../../../../core/widgets/spacing_widgets.dart';
import '../../../code_review/presentation/widgets/custom_code_field.dart';
import '../../data/repositories/explain_code_repository_impl.dart';
import '../widgets/custom_explain_code_text_field.dart';

class ExplainCodeScreen extends StatelessWidget {
  const ExplainCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ExplainCubit(
        explainCodeUseCase: ExplainCodeUseCase(repository: 
          ExplainRepositoryImpl(GeminiService()),
        ),
      ),
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
  late CodeController _codeController;
  late final TextEditingController _instructionsController;
  String _currentLanguage = 'Dart';

  @override
  void initState() {
    super.initState();
    _instructionsController = TextEditingController();
    _codeController = CodeController(
      text: '',
      language: LanguageHelper.languageModes[_currentLanguage]!,
    );

    // Sync code changes to cubit
    _codeController.addListener(() {
      final cubit = context.read<ExplainCubit>();
      final currentCode = _codeController.text;
      if (cubit.state.code != currentCode) {
        cubit.updateCode(currentCode);
      }
    });

    // Sync instructions changes to cubit
    _instructionsController.addListener(() {
      final cubit = context.read<ExplainCubit>();
      cubit.updateAdditionalInstructions(_instructionsController.text);
    });
  }

  @override
  void dispose() {
    _codeController.dispose();
    _instructionsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ExplainCubit, ExplainCodeState>(
      listener: (context, state) {
        if (state.errorMessage != null) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
          context.read<ExplainCubit>().clearError();
        }
        if (state.explanation != null && !state.isLoading) {
          // Navigate to result screen
          GoRouter.of(
            context,
          ).pushNamed(RouteName.ansewerEplainCode, extra: state.explanation);
        }
      },
      builder: (context, state) {
        // Update code controller language if state changed
        if (_currentLanguage != state.language) {
          final newLang = LanguageHelper.languageModes[state.language];
          if (newLang != null) {
            _codeController.language = newLang;
            _currentLanguage = state.language;
          }
        }

        return Scaffold(
          backgroundColor: AppColors.backgroundColor,
          appBar: const CustomAppBar(title: 'Explain Code'),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const HeightSpace(height: 35),
                  CustomDropdownbuttonfield(
                    labelText: 'Language',
                    hintText: 'Select language',
                    items: LanguageHelper.languages,
                    initialValue: state.language,
                    onChanged: (value) {
                      if (value != null) {
                        context.read<ExplainCubit>().updateLanguage(value);
                      }
                    },
                  ),
                  const HeightSpace(height: 20),
                  CustomCodeField(codeController: _codeController),
                  const HeightSpace(height: 20),
                  CustomExplainCodeTextField(
                    instructionsController: _instructionsController,
                  ),
                  const HeightSpace(height: 20),
                  CustomFeatureButton(
                    text: 'Explain Code',
                    isLoading: state.isLoading,
                    onTap: state.isLoading
                        ? null
                        : () {
                            context.read<ExplainCubit>().submitExplain();
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
