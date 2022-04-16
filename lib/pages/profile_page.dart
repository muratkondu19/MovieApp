import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/components/utils.dart';
import 'package:movies_app/constants.dart';
import 'package:movies_app/provider/google_sign_in.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key}) : super(key: key);
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: getBody(),
    );
  }

  Widget getBody() {
    final user = FirebaseAuth.instance.currentUser!;
    return Stack(
      alignment: Alignment.center,
      children: [
        CustomPaint(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
          painter: HeaderCurvedContainer(),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.all(40),
              child: Text(
                'Profil',
                style: TextStyle(
                    fontSize: 35,
                    fontFamily: fontFamiy,
                    letterSpacing: 1.5,
                    color: textWhite,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width / 2,
              height: MediaQuery.of(context).size.width / 2,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 5),
                  shape: BoxShape.circle,
                  color: Colors.white,
                  image: DecorationImage(
                      image: NetworkImage(user.photoURL.toString()),
                      fit: BoxFit.cover)),
            )
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              height: 300,
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    textField(user.displayName!),
                    textField(user.email!),
                    ElevatedButton(
                      style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(17.5),
                      ))),
                      onPressed: () {
                        final provider = Provider.of<GoogleSignInProvider>(
                            context,
                            listen: false);
                        provider.logout();
                      },
                      child: Container(
                        height: 45.0,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: primary.withOpacity(0.7),
                          boxShadow: [
                            BoxShadow(
                              color: primary.withOpacity(0.5),
                              spreadRadius: 0.0,
                              blurRadius: 6.0,
                              offset: Offset(0, 2),
                            )
                          ],
                        ),
                        child: const Text(
                          'Çıkış Yap',
                          style: TextStyle(
                            fontSize: 14.0,
                            fontFamily: fontFamiy,
                            fontWeight: FontWeight.w700,
                            color: textWhite,
                          ),
                        ),
                      ),
                    ),
                  ]),
            ),
          ],
        ),
      ],
    );
  }

  Widget textField(@required String hintText) {
    return Material(
      elevation: 4,
      shadowColor: Colors.grey,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(17.5)),
      child: TextField(
        decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(
                letterSpacing: 2,
                color: textBlack,
                fontFamily: fontFamiy,
                fontWeight: FontWeight.w600),
            fillColor: textWhite,
            filled: true,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(17.5),
                borderSide: BorderSide.none)),
      ),
    );
  }
}

class HeaderCurvedContainer extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    Paint paint = Paint()..color = secondary;
    Path path = Path()
      ..relativeLineTo(0, 200)
      ..quadraticBezierTo(size.width / 2, 275, size.width, 200)
      ..relativeLineTo(0, -200)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }
}
