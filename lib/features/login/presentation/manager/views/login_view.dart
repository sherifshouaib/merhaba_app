import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:merhaba/core/helper/spacing.dart';
import 'package:merhaba/core/locale/app_locale.dart';
import 'package:merhaba/core/utils/controllers/auth_controller.dart';
import 'package:merhaba/core/utils/funcs/getPostsAndNavigate_method.dart';
import 'package:merhaba/core/utils/providers/login_provider.dart';
import 'package:merhaba/core/widgets/custom_info_label.dart';
import 'package:merhaba/core/widgets/logo_boarding_light.dart';
import 'package:merhaba/core/widgets/row_log_reg.dart';
import 'package:merhaba/core/widgets/row_text_button.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:merhaba/features/login/presentation/manager/views/widgets/forget_password_button.dart';
import 'package:merhaba/main_development.dart';
import 'package:provider/provider.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);

    return Directionality(
      textDirection: localization.currentLocale.localeIdentifier == "ar"
          ? TextDirection.rtl
          : TextDirection.ltr,
      child: SafeArea(
        child: Scaffold(
          body: loginProvider.isLoading
              ? const Center(child: CircularProgressIndicator())
              : ListView(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  children: [
                    LogoOnboardingLight(),

                    verticalSpace(20),

                    CustomInfoLabel(
                      funcController: emailController,
                      label: AppLocale.enter_your_email_label.getString(
                        context,
                      ),
                      placeholder: AppLocale.email_label.getString(context),
                    ),
                    verticalSpace(15),

                    CustomInfoLabel(
                      funcController: passController,
                      label: AppLocale.enter_your_password_label.getString(
                        context,
                      ),
                      placeholder: AppLocale.password_label.getString(context),
                      obsecure: true,
                    ),

                    verticalSpace(20),
                    RowLogCreateAcc(
                      textButton: AppLocale.login_label.getString(context),
                      onPressed: () async {
                        if (emailController.text == "") {
                          Fluttertoast.showToast(
                            msg: "Please enter your email!",
                          );
                          return;
                        }

                        if (passController.text == "") {
                          Fluttertoast.showToast(
                            msg: "Please enter your password!",
                          );
                          return;
                        }

                        loginProvider.toggleLoading();

                        try {
                          var res = await AuthController.login(
                            emailController.text,
                            passController.text,
                          );

                          if (res["result"] == true) {
                            getPostsAndNavigateMethod(context);

                            //   final timelineProvider =
                            //       Provider.of<TimelineProvider>(
                            //         context,
                            //         listen: false,
                            //       );
                            // await  timelineProvider.getData();

                            //   context.go(AppRouter.kHomeView);
                          } else {
                            Fluttertoast.showToast(
                              msg: res["message"].toString(),
                            );
                          }
                        } catch (e) {
                          debugPrint(e.toString());
                        }

                        loginProvider.toggleLoading();
                      },
                    ),

                    verticalSpace(10),

                    ForgetPasswordButton(),
                    verticalSpace(10),

                    RowTextButton(
                      buttonText: AppLocale.create_account_label.getString(
                        context,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
