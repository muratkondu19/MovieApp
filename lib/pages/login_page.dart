import 'package:flutter/material.dart';
import 'package:movies_app/components/components.dart';
import 'package:movies_app/components/under_part.dart';
import 'package:movies_app/components/utils.dart';
import 'package:movies_app/constants.dart';
import 'package:movies_app/pages/signup_page.dart';
import 'package:movies_app/provider/google_sign_in.dart';
import 'package:movies_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: size.width,
          height: size.height,
          child: SingleChildScrollView(
            child: Stack(
              children: [
                const Upside(
                  imgUrl: "assets/images/marvel.png",
                ),
                const PageTitleBar(title: 'Giriş Yap'),
                Padding(
                  padding: const EdgeInsets.only(top: 320.0),
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 15,
                        ),
                        iconButton(context),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "veya e-posta hesabınızı kullanın",
                          style: TextStyle(
                              color: Colors.grey,
                              fontFamily: 'OpenSans',
                              fontSize: 13,
                              fontWeight: FontWeight.w600),
                        ),
                        Form(
                          child: Column(
                            children: [
                              const RoundedInputField(
                                  hintText: "Mail Adesiniz", icon: Icons.email),
                              const RoundedPasswordField(),
                              //switchListTile(),
                              RoundedButton(text: 'Giriş Yap', press: () {}),
                              const SizedBox(
                                height: 10,
                              ),
                              UnderPart(
                                title: "Hesabınız yok mu?",
                                navigatorText: "Buradan kayıt olun",
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const SignUpPage()));
                                },
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// switchListTile() {
//   return Padding(
//     padding: const EdgeInsets.only(left: 50, right: 40),
//     child: SwitchListTile(
//       dense: true,
//       title: const Text(
//         'Beni Hatırla',
//         style: TextStyle(fontSize: 16, fontFamily: 'OpenSans'),
//       ),
//       value: true,
//       activeColor: kPrimaryColor,
//       onChanged: (val) {},
//     ),
//   );
// }

iconButton(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      // const RoundedIcon(imageUrl: "assets/images/facebook.png"),
      // const SizedBox(
      //   width: 20,
      // ),
      // const RoundedIcon(imageUrl: "assets/images/twitter.png"),
      // const SizedBox(
      //   width: 20,
      // ),
      //RoundedIcon(imageUrl: "assets/images/google.jpg"),
      IconButton(
        icon: const RoundedIcon(imageUrl: "assets/images/google.jpg"),
        onPressed: () {
          final provider =
              Provider.of<GoogleSignInProvider>(context, listen: false);
          provider.googleLogin();
          Utils.showSnackBar(context, 'Google Hesabınızı Seçiniz.');
        },
        iconSize: 30,
      )
    ],
  );
}
