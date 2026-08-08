import 'package:dev_mate_ai/core/widgets/custom_snack_bar.dart';
import 'package:dev_mate_ai/core/widgets/custom_text_field.dart';
import 'package:dev_mate_ai/core/widgets/spacing_widgets.dart';
import 'package:dev_mate_ai/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:dev_mate_ai/features/profile/presentation/cubit/profile_state.dart';
import 'package:dev_mate_ai/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class ChangePasswordDialog extends StatefulWidget {
  final ProfileCubit cubit;

  const ChangePasswordDialog({super.key, required this.cubit});

  @override
  State<ChangePasswordDialog> createState() => _ChangePasswordDialogState();
}

class _ChangePasswordDialogState extends State<ChangePasswordDialog> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final local = S.of(context);
    return BlocProvider.value(
      value: widget.cubit,
      child: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is ChangePasswordSuccess) {
            CustomSnackBar.success(
              context,
              message: local.passwordUpdateSucceful,
            );
            Navigator.pop(context);
          } else if (state is ProfileError) {
            CustomSnackBar.error(context, message: state.message);
          }
        },
        builder: (context, state) {
          final isLoading = state is ChangePasswordLoading;

          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: Text(
              local.changePass,
              style: GoogleFonts.inter(
                color: Theme.of(context).colorScheme.secondary,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: SizedBox(
              width: 400,
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomTextField(
                      controller: _passwordController,
                      isPassword: true,
                      hintText: local.password,
                      prefixIcon: const Icon(Icons.lock_outline),
                      textStyle: TextStyle(
                        color: Theme.of(context).colorScheme.onSecondary,
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return local.passValidate;
                        }
                        return null;
                      },
                    ),
                    const HeightSpace(height: 16),
                    CustomTextField(
                      controller: _confirmPasswordController,
                      isPassword: true,
                      hintText: local.comfirmPass,
                      textStyle: TextStyle(
                        color: Theme.of(context).colorScheme.onSecondary,
                      ),
                      prefixIcon: const Icon(Icons.lock_outline),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return local.comfirmPassValidator;
                        }
                        if (value != _passwordController.text) {
                          return 'كلمتا المرور غير متطابقتين';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: isLoading ? null : () => Navigator.pop(context),
                child: Text(
                  local.cancel,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSecondary,
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: isLoading
                    ? null
                    : () {
                        if (_formKey.currentState!.validate()) {
                          widget.cubit.changePassword(
                            _passwordController.text.trim(),
                          );
                        }
                      },
                child: isLoading
                    ? SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      )
                    : Text(
                        local.update,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}
