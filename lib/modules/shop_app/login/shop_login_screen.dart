
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



import '../../../layout/shop_app/shop_layout.dart';
import '../../../shared/components/components.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/network/local/cache_helper.dart';
import '../register/shop_register_screen.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class ShopLoginScreen extends StatelessWidget
{
  var formKey = GlobalKey<FormState>();
  var emailcontroller = TextEditingController();
  var passwordcontroller = TextEditingController();


  @override
  Widget build(BuildContext context) {


    return BlocProvider(
      create: (BuildContext context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit , ShopLoginStates>(
        listener: (context , state){
          if(state is ShopLoginSuccessState)
          {
            if(state.loginModel.status!){
            print(state.loginModel.message);
            print(state.loginModel.data!.token);

            CacheHelper.saveData(
              key: 'token',
              value: state.loginModel.data!.token,
            ).then((value)
            {
              token =state.loginModel.data!.token!;
              navigateAndFinish(
                context,
                ShopLayout(),
              );
            });
                }else
            {
              print(state.loginModel.message);
              showToast(
                text: state.loginModel.message!,
                state: ToastState.ERROR,
              );
            }
          }
        },
        builder: (context , state){
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LOGIN',
                          style: Theme.of(context).textTheme.headline4?.copyWith(
                            color:Colors.black,
                          ),
                        ),
                        Text(
                          'Login now to browse our hot offers',
                          style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            color :Colors.grey,
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        defaultFormFild(
                          controller: emailcontroller,
                          validate: (String value)
                          {
                            if(value.isEmpty)
                            {
                              return 'please enter your email address';
                            }
                          },
                          type: TextInputType.emailAddress,
                          label: 'Email Address',
                          prefix: Icons.email_outlined,
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultFormFild(
                          controller: passwordcontroller,
                          suffix: ShopLoginCubit.get(context).suffix,
                          onSubmit: (value)
                          {
                            if(formKey.currentState!.validate())
                            {
                              ShopLoginCubit.get(context).userLogin(
                                email: emailcontroller.text,
                                password: passwordcontroller.text,
                              );
                            }
                          },
                          isPassword: ShopLoginCubit.get(context).isPassword,
                          suffixPressed: ()
                          {
                            ShopLoginCubit.get(context).changePasswordVisibility();
                          },
                          validate: (String value)
                          {
                            if(value.isEmpty)
                            {
                              return 'password is too short';
                            }
                          },
                          type: TextInputType.visiblePassword,
                          label: 'Password',
                          prefix: Icons.lock_outline,
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        ConditionalBuilder(
                            condition: state is! ShopLoginLoadinglState,
                            builder: (context) => defaultButton(
                              function: ()
                              {
                                if(formKey.currentState!.validate())
                                {
                                  ShopLoginCubit.get(context).userLogin(
                                    email: emailcontroller.text,
                                    password: passwordcontroller.text,
                                  );
                                }
                              },
                              text: 'login',
                              isUpperCase: true,
                            ),
                          fallback: (context) => Center(child: CircularProgressIndicator()),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don\'t have an account?',
                              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                              // style: TextStyle(
                              //   fontWeight: FontWeight.bold,
                              // ),
                            ),

                            defaultTextButton(
                              function: ()
                              {
                                navigateTo(
                                  context,
                                  ShopRegisterScreen(),
                                );
                              },
                              text: 'register',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
