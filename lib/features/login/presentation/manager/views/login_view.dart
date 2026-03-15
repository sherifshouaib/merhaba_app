import 'package:flutter/material.dart';
import 'package:merhaba/core/helper/spacing.dart';
import 'package:merhaba/core/utils/providers/login_provider.dart';
import 'package:merhaba/core/widgets/custom_info_label.dart';
import 'package:merhaba/core/widgets/logo_boarding_light.dart';
import 'package:merhaba/core/widgets/row_log_reg.dart';
import 'package:merhaba/core/widgets/row_text_button.dart';
import 'package:provider/provider.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);

    return Scaffold(
      body: loginProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              children: [
                LogoOnboardingLight(),

                verticalSpace(20),

                // SizedBox(height: 20),
                CustomInfoLabel(
                  funcController: emailController,
                  label: "Enter your email",
                  placeholder: 'Email',
                ),
                verticalSpace(15),

                // SizedBox(height: 15),
                CustomInfoLabel(
                  funcController: emailController,
                  label: "Enter your password",
                  placeholder: 'Password',
                  obsecure: true,
                ),

                verticalSpace(20),
                //SizedBox(height: 20),
                RowLogCreateAcc(textButton: 'Login'),

                //SizedBox(height: 10,),
                verticalSpace(10),
                RowTextButton(buttonText: "Create Account"),
              ],
            ),
    );
  }
}
