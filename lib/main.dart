import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopping_mall_flutter/Login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(builder: (_, child) {
      return const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const SelectUserPage(),
      );
    });
  }
}

class SelectUserPage extends StatefulWidget {
  const SelectUserPage({super.key});

  @override
  State<StatefulWidget> createState() => _SelectUSerPage();
}

class _SelectUSerPage extends State<SelectUserPage> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,

      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
                Color.fromRGBO(20, 72, 140, 1.0),
                Color.fromRGBO(7, 121, 222, 1.0),
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.bottomRight),
        ),
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                child: Stack(
                  children: [
                    ClipPath(
                      clipper: DrawClip2(),
                      child: Container(
                        width: size.width,
                        height: size.height * 0.8,
                        decoration: BoxDecoration(
                          color: Colors.white
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        "Welcome",
                        style: TextStyle(
                            fontSize: 35.w,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(51, 110, 201, 1.0),),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.only(left: 50.w, right: 50.w),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20.w))),
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: 20.w, left: 20.w, right: 20.w, bottom: 20.w),
                    child: Column(
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            fixedSize:
                                Size.fromWidth(MediaQuery.of(context).size.width),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(15.w),
                              ),
                            ),
                          ),
                          onPressed: () {},
                          child: Padding(
                            padding: EdgeInsets.only(top: 15.w, bottom: 15.w),
                            child: Text("Visit the mall",
                                style: TextStyle(fontSize: 15.w)),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 20.w, bottom: 20.w),
                          child: Center(
                            child: Text("--------------- or ---------------", style: TextStyle(fontSize: 15.w,color: Colors.white)),
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(15.w),
                            ),
                          ),
                            fixedSize:
                                Size.fromWidth(MediaQuery.of(context).size.width),
                          ),
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder:(context)=> const AdminLoginPage()));
                          },
                          child: Padding(
                            padding: EdgeInsets.only(top: 15.w, bottom: 15.w),
                            child: Text("Admin Login",
                                style: TextStyle(fontSize: 15.w)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(flex: 1,child: Padding(
              padding: EdgeInsets.only(bottom: 30.w),
              child: Align(alignment: Alignment.bottomCenter,child: Text("SS creation",style: TextStyle(fontSize: 13.w,color: Colors.white)),),
            ))
          ],
        ),
      ),
    );
  }
}

class DrawClip2 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height * 0.80);
    path.cubicTo(size.width / 4, size.height, 3 * size.width / 4,
        size.height / 2, size.width, size.height * 0.8);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
