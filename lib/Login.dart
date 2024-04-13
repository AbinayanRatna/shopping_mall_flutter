import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopping_mall_flutter/AdminHome.dart';

class AdminLoginPage extends StatefulWidget {
  const AdminLoginPage({super.key});

  @override
  State<StatefulWidget> createState() => _AdminLoginPage();
}

class _AdminLoginPage extends State<AdminLoginPage> {
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 1.0),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left:30.w,right:30.w,top:50.w),
              child: Container(
                height: MediaQuery.of(context).size.height / 3,
                child: SvgPicture.asset('assets/login.svg',fit: BoxFit.fitWidth),
              ),
            ),
            Padding(padding: EdgeInsets.only(top:20.w,bottom: 20.w),
              child: Text("Authorized Login",style: TextStyle(fontSize: 20.w,fontWeight: FontWeight.bold),),),
            Padding(
              padding: EdgeInsets.only(left: 40.w, right: 40.w),
              child: Container(
                decoration: BoxDecoration(
                    color: Color.fromRGBO(82, 131, 210, 0.2),
                    borderRadius: BorderRadius.all(Radius.circular(10.w))),
                child: Padding(
                  padding: EdgeInsets.only(
                      top: 20.w, bottom: 10.w, right: 10.w, left: 10.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        decoration: const BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: Color.fromRGBO(143, 148, 251, 1)))),
                        child: TextField(
                          controller: emailController,
                          style: TextStyle(fontSize: 15.w),
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Email or Phone number",
                              hintStyle: TextStyle(color: Colors.grey[700])),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top:10.w),
                        child: Container(
                          child: TextField(
                            style: TextStyle(fontSize: 15.w),
                            controller: passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Password",
                                hintStyle: TextStyle(color: Colors.grey[700])),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left:40.w,right:40.w,top:20.w,bottom: 20.w),
              child: Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: Color.fromRGBO(82, 131, 210, 1.0),
                      fixedSize:Size.fromWidth(MediaQuery.of(context).size.width),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.w)))
                  ),
                  child:  Padding(
                    padding: EdgeInsets.only(top:13.w,bottom: 13.w),
                    child:  Text("Login",style: TextStyle(fontSize: 20.w)),
                  ),
                  onPressed: (){
                    if(emailController.text.trim()=='admin@gmail.com' && passwordController.text.trim()=='password'){
                      //Navigator.push(context, MaterialPageRoute(builder: (context)=>const AdminAddContacts()));
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> const AdminHomePage()));
                    }else if(emailController.text.trim()!='admin@gmail.com' && passwordController.text.trim()!='password'){
                      Fluttertoast.showToast(msg: "Incorrect credentials",toastLength: Toast.LENGTH_SHORT);
                    }else if(passwordController.text.trim()!='password'){
                      Fluttertoast.showToast(msg: "Incorrect password",toastLength: Toast.LENGTH_SHORT);
                    }else if(emailController.text.trim()!='admin@gmail.com'){
                      Fluttertoast.showToast(msg: "Incorrect email",toastLength: Toast.LENGTH_SHORT);
                    }

                  },
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Forgot password ?",style: TextStyle(fontSize: 15.w)),
                TextButton(onPressed: (){},child: Text("Contact Admin",style: TextStyle(fontSize: 15.w))),
              ],
            )
          ],
        ),
      ),
    );
  }
}
