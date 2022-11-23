import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/modules/register_screen/cubit/cubit.dart';
import 'package:socialapp/modules/register_screen/cubit/states.dart';
import 'package:socialapp/shared/componenet/component.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CubitRegister, SocialRegisterStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = CubitRegister.get(context);
        return Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.arrow_back_ios)),
          ),
          body: Center(
              child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
                  child: Text("Hello Register to get \n Started",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      )),
                ),
                CustomizedTextfield(
                  myController: nameController,
                  hintText: "Username",
                  isPassword: false,
                ),
                CustomizedTextfield(
                  myController: emailController,
                  hintText: "Email",
                  isPassword: false,
                ),
                CustomizedTextfield(
                  myController: passwordController,
                  hintText: "Password",
                  isPassword: cubit.isPassword,
                  suffixIcon: cubit.sufficIcon,
                  suffixPressed: () {
                    cubit.changeVisibility();
                  },
                ),
                CustomizedTextfield(
                  myController: phoneController,
                  hintText: "Phone",
                  isPassword: false,
                ),
                CustomizedButton(
                  buttonColor: Colors.black,
                  buttonText: "Register",
                  onPressed: () async {
                    cubit.userRegister(
                        name: nameController.text,
                        email: emailController.text,
                        password: passwordController.text,
                        phone: phoneController.text);
                  },
                  textColor: Colors.white,
                ),
              ],
            ),
          )),
        );
      },
    );
  }
}
