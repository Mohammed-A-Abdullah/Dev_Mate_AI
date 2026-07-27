import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
import '../cubit/code_review_cubit.dart';
import '../cubit/code_review_state.dart';
import '../../../../core/widgets/custom_code_field.dart';
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

    return BlocConsumer<CodeReviewCubit, CodeReviewState>(
      listenWhen: (previous, current) =>
          previous.errorMessage != current.errorMessage ||
          previous.reviewResult != current.reviewResult,
      listener: (context, state) {
        if (state.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage!),
              backgroundColor: Colors.red,
            ),
          );
          context.read<CodeReviewCubit>().clearError();
        }

        if (state.reviewResult != null && !state.isLoading) {
          context.pushNamed(
            RouteName.ansewerEplainCode,
            extra: state.reviewResult,
          );
        }
      },
      builder: (context, state) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            appBar: CustomAppBar(title: local.codeReview),
            body: SingleChildScrollView(
              padding: EdgeInsets.all(16.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const HeightSpace(height: 35),
                  SizedBox(
                    width: double.infinity,
                    child: CustomDropdownbuttonfield(
                      labelText: local.language,
                      hintText: local.selectProgrammingLang,
                      initialValue: state.language,
                      items: LanguageHelper.languages,
                      onChanged: (value) {
                        if (value != null) {
                          context.read<CodeReviewCubit>().updateLanguage(value);
                        }
                      },
                    ),
                  ),
                  const HeightSpace(height: 20),
                  CustomCodeEditor(controller: _codeController),
                  const HeightSpace(height: 20),
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
                        context.read<CodeReviewCubit>().updateExperienceLevel(
                          value,
                        );
                      }
                    },
                  ),
                  const HeightSpace(height: 20),
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
                        context.read<CodeReviewCubit>().updateReviewDepth(
                          value,
                        );
                      }
                    },
                  ),
                  const HeightSpace(height: 20),
                  CustomReveiwTypesChips(state: state),
                  const HeightSpace(height: 20),
                  CustomReviewTextField(
                    errorLogController: _errorLogController,
                  ),
                  const HeightSpace(height: 20),
                  CustomFeatureButton(
                    isLoading: state.isLoading,
                    text: local.codeReview,
                    onTap: state.isLoading
                        ? null
                        : () {
                            context.read<CodeReviewCubit>().submitReview(
                              code: _codeController.text,
                              errorLog: _errorLogController.text,
                            );
                            FocusScope.of(context).unfocus();
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
