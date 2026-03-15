import 'package:flutter/material.dart';
import 'package:merhaba/core/helper/spacing.dart';
import 'package:merhaba/core/utils/providers/create_account_provider.dart';
import 'package:merhaba/core/widgets/custom_info_label.dart';
import 'package:merhaba/core/widgets/logo_boarding_light.dart';
import 'package:merhaba/core/widgets/row_log_reg.dart';
import 'package:provider/provider.dart';

class CreateAccountView extends StatelessWidget {
  CreateAccountView({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final createAccountProvider = Provider.of<CreateAccountProvider>(context);

    return Scaffold(
      body: createAccountProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              children: [
                LogoOnboardingLight(),

                CustomInfoLabel(
                  funcController: emailController,
                  label: "Enter your email",
                  placeholder: 'Email',
                ),

                verticalSpace(15),
                CustomInfoLabel(
                  funcController: fullNameController,
                  label: "Enter your Full Name",
                  placeholder: 'Full Name',
                ),

                verticalSpace(15),
                CustomInfoLabel(
                  funcController: phoneController,
                  label: "Enter your Phone",
                  placeholder: 'Phone',
                  textInputType: TextInputType.phone,
                ),

                verticalSpace(15),
                CustomInfoLabel(
                  funcController: passController,
                  label: "Enter your password",
                  placeholder: 'Password',
                  obsecure: true,
                ),

                verticalSpace(20),
                CustomInfoLabel(
                  funcController: confirmPassController,
                  label: "Confirm your password",
                  placeholder: 'Confirm Password',
                  obsecure: true,
                ),

                verticalSpace(20),

                RowLogCreateAcc(textButton: 'Sign Up'),
              ],
            ),
    );
  }
}
