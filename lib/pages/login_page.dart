
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tp1/components/MyButton.dart';
import 'package:tp1/components/my_textfield.dart';
import 'package:tp1/constant/myColors.dart';
import 'package:tp1/pages/home_page.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final void Function()? onTap;
  LoginPage({super.key, this.onTap});

//Login Method
  void login(BuildContext context) async {


       // login with firebase 
       
    // final authService = AuthService();
// 
    // try {
    //   await authService.signInWithEmailPassword(
    //       _emailController.text, _passwordController.text);
    // } catch (e) {
    //   showDialog(
    //       context: context,
    //       builder: (context) => AlertDialog(
    //             title: Text(e.toString()),
    //           ));
    // }

      if ( _emailController.text == 'admin' && _passwordController.text == '1234') {
        // Navigate to WelcomePage after login
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } else {
        // Show an error message if login fails
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Invalid username or password')),
        );
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.lock,
              size: 60,
              color: Theme.of(context).colorScheme.tertiary,
            ),
            const SizedBox(
              height: 50,
            ),
            Text("Sign In",style: TextStyle(color: Theme.of(context).colorScheme.primary),),
            const SizedBox(
              height: 50,
            ),
            MyTextField(
              hintText: "Email",
              obsecureText: false,
              controller: _emailController,
            ),
            const SizedBox(
              height: 15,
            ),
            MyTextField(
              hintText: "Password",
              obsecureText: true,
              controller: _passwordController,
            ),
            const SizedBox(
              height: 50,
            ),
            MyButton(
              text: "Login",
              onTap: () => login(context),
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Not a member ? ",style: TextStyle(color: myGrey),),
                GestureDetector(
                    onTap: onTap,
                    child: Text(
                      " Register Now",
                      style: TextStyle(fontWeight: FontWeight.bold,color: myBlue),
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
