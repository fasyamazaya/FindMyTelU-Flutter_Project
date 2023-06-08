import 'package:flutter/material.dart';
import 'package:project1/screens/HomePage.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login and Registration Form',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Colors.blue,
          focusColor: Colors.blue, colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue).copyWith(secondary: Colors.blue)),
      home: Login(),
    );
  }
}
class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);
  @override
  State<Login> createState() => _LoginState();
}
// flutter login and registration template
class _LoginState extends State<Login> {
  bool isLoginSelected = true;
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.blueGrey.shade50, Colors.blueGrey.shade200])),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                titleText(),
                SizedBox(
                  height: 30,
                ),
                toggleButton(),
                isLoginSelected ? SizedBox() : usernameField(),
                emailField(),
                passwordField(),
                isLoginSelected ? SizedBox() : confirmPasswordField(),
                !isLoginSelected ? SizedBox() : forgotPassword(),
                isLoginSelected
                    ? SizedBox()
                    : Padding(
                  padding: EdgeInsets.only(top: 30),
                ),
                SizedBox(
                  height: 40,
                ),
                button1(),
                SizedBox(
                  height: 53,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  // flutter login and registration template
  Widget titleText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          isLoginSelected ? 'Find My TelU' : 'Find My TelU',
          style: TextStyle(
              fontSize: 45,
              fontWeight: FontWeight.bold,
              color: Colors.black87),
        ),
      ],
    );
  }
// flutter login and registration template
  Widget usernameField() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25).copyWith(top: 10),
        child: Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          height: 53,
          width: double.infinity,
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    offset: Offset(4, 4),
                    blurRadius: 5,
                    spreadRadius: 0,
                    color: Colors.black26)
              ],
              borderRadius: BorderRadius.circular(50),
              gradient: LinearGradient(
                  colors: [Colors.white70, Colors.white54])),
          child: TextField(
            style: TextStyle(color: Colors.black45, fontSize: 14),
            decoration: InputDecoration(
              border: InputBorder.none,
              prefixIconConstraints: BoxConstraints(minWidth: 24),
              prefixIcon: Padding(
                padding: EdgeInsets.only(right: 10),
                child: Icon(
                  Icons.person,
                  color: Colors.black87,
                  size: 20,
                ),
              ),
              hintText: 'Name',
              hintStyle: TextStyle(color: Colors.black45, fontSize: 14),
            ),
          ),
        ));
  }
  Widget emailField() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25).copyWith(top: 10),
        child: Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          height: 53,
          width: double.infinity,
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    offset: Offset(4, 4),
                    blurRadius: 5,
                    spreadRadius: 0,
                    color: Colors.black26)
              ],
              borderRadius: BorderRadius.circular(50),
              gradient: LinearGradient(
                  colors: [Colors.white70, Colors.white54])),
          child: TextField(
            style: TextStyle(color: Colors.black45, fontSize: 14),
            decoration: InputDecoration(
              border: InputBorder.none,
              prefixIconConstraints: BoxConstraints(minWidth: 24),
              prefixIcon: Padding(
                padding: EdgeInsets.only(right: 10),
                child: Icon(
                  Icons.email,
                  color: Colors.black87,
                  size: 20,
                ),
              ),
              hintText: 'Email',
              hintStyle: TextStyle(color: Colors.black45, fontSize: 14),
            ),
          ),
        ));
  }
  // flutter login and registration template
  Widget passwordField() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25).copyWith(top: 10),
        child: Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          height: 53,
          width: double.infinity,
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    offset: Offset(4, 4),
                    blurRadius: 5,
                    spreadRadius: 0,
                    color: Colors.black26)
              ],
              borderRadius: BorderRadius.circular(50),
              gradient: LinearGradient(
                  colors: [Colors.white70, Colors.white54])),
          child: TextField(
            obscureText: isPasswordVisible ? false : true,
            style: TextStyle(color: Colors.black45, fontSize: 14),
            decoration: InputDecoration(
              border: InputBorder.none,
              prefixIconConstraints: BoxConstraints(minWidth: 24),
              suffixIconConstraints: BoxConstraints(minWidth: 24),
              prefixIcon: Padding(
                padding: EdgeInsets.only(right: 10),
                child: Icon(
                  Icons.lock,
                  color: Colors.black87,
                  size: 20,
                ),
              ),
              suffixIcon: Padding(
                padding: EdgeInsets.only(left: 10),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      isPasswordVisible = !isPasswordVisible;
                    });
                  },
                  child: Icon(
                    isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                    color: Colors.black87,
                    size: 20,
                  ),
                ),
              ),
              hintText: 'Password',
              hintStyle: TextStyle(color: Colors.black45, fontSize: 14),
            ),
          ),
        ));
  }
  // flutter login and registration template
  Widget confirmPasswordField() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25).copyWith(top: 10),
        child: Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          height: 53,
          width: double.infinity,
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    offset: Offset(4, 4),
                    blurRadius: 5,
                    spreadRadius: 0,
                    color: Colors.black26)
              ],
              borderRadius: BorderRadius.circular(50),
              gradient: LinearGradient(
                  colors: [Colors.white70, Colors.white54])),
          child: TextField(
            obscureText: isConfirmPasswordVisible ? false : true,
            style: TextStyle(color: Colors.black45, fontSize: 14),
            decoration: InputDecoration(
              border: InputBorder.none,
              prefixIconConstraints: BoxConstraints(minWidth: 24),
              suffixIconConstraints: BoxConstraints(minWidth: 24),
              prefixIcon: Padding(
                padding: EdgeInsets.only(right: 10),
                child: Icon(
                  Icons.lock,
                  color: Colors.black87,
                  size: 20,
                ),
              ),
              suffixIcon: Padding(
                padding: EdgeInsets.only(left: 10),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      isConfirmPasswordVisible = !isConfirmPasswordVisible;
                    });
                  },
                  child: Icon(
                    isConfirmPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: Colors.black87,
                    size: 20,
                  ),
                ),
              ),
              hintText: 'Password confirmation',
              hintStyle: TextStyle(color: Colors.black45, fontSize: 14),
            ),
          ),
        ));
  }
  Widget button1() {
    return GestureDetector(
      onTap: () {
        ///ScaffoldMessenger.of(context)
            ///.showSnackBar(SnackBar(content: Text('Clicked')));
        Navigator.push(context, MaterialPageRoute(builder:(context) => HomePage()));
      },
      child: Container(
        height: 53,
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 30),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  blurRadius: 4, color: Colors.black26, offset: Offset(5, 5))
            ],
            borderRadius: BorderRadius.circular(100),
            gradient: LinearGradient(
                colors: [Colors.blue.shade200, Colors.blue.shade900])),
        child: Text(isLoginSelected ? 'Login' : 'Register',
            style: TextStyle(
                color: Colors.white.withOpacity(.8),
                fontSize: 15,
                fontWeight: FontWeight.bold)),
      ),
    );
  }
  // flutter login and registration template design ui
  Widget toggleButton() {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        height: 40,
        width: 150,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  offset: Offset(4, 4),
                  blurRadius: 5,
                  spreadRadius: 0,
                  color: Colors.black26)
            ],
            borderRadius: BorderRadius.circular(50),
            gradient: LinearGradient(
                colors: [Colors.blue.shade200, Colors.blue.shade900])),
        child: Row(
          // flutter login and registration template source code design UI
          children: [
            !isLoginSelected
                ? Expanded(
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        print('tap');
                        isLoginSelected = true;
                        ///Navigator.push(context, MaterialPageRoute(builder:(context) => HomePage()));
                      });
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ))
                : Expanded(
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(4, 4),
                            blurRadius: 5,
                            spreadRadius: 0,
                            color: Colors.black26)
                      ],
                      borderRadius: BorderRadius.circular(50),
                      gradient: LinearGradient(colors: [
                        Colors.blue.shade200,
                        Colors.blue.shade900
                      ])),
                  child: Text(
                    'Login',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                  ),
                )),
            isLoginSelected
                ? Expanded(
                child: Center(
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        print('tap');
                        isLoginSelected = false;
                      });
                    },
                    child: Text(
                      'Register',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ))
                : Expanded(
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(4, 4),
                            blurRadius: 5,
                            spreadRadius: 0,
                            color: Colors.black26)
                      ],
                      borderRadius: BorderRadius.circular(50),
                      gradient: LinearGradient(colors: [
                        Colors.blue.shade200,
                        Colors.blue.shade900
                      ])),
                  child: Text(
                    'Register',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                  ),
                ))
          ],
        ),
      ),
    );
  }
  // flutter login and registration template design code
  Widget forgotPassword() {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(top: 10, right: 30),
        child: InkWell(
          onTap: () {
            // can navigate to other screen or perform some other action
          },
          child: Text(
            'Forgot password?',
            style: TextStyle(
                color: Colors.black26.withOpacity(.9),
                fontSize: 12,
                fontWeight: FontWeight.w700),
          ),
        ),
      ),
    );
  }
}