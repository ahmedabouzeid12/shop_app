import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../layout/shop_app/shop_layout.dart';
import '../../../shared/components/components.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/network/local/cache_helper.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class ShopRegisterScreen extends StatelessWidget {

  var formKey = GlobalKey<FormState>();
  var namecontroller = TextEditingController();
  var emailcontroller = TextEditingController();
  var passwordcontroller = TextEditingController();
  var phonecontroller = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit , ShopRegisterStates>(
        listener: (context , state)
        {
          if(state is ShopRegisterSuccessState)
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
                          'REGISTER',
                          style: Theme.of(context).textTheme.headline4!.copyWith(
                            color:Colors.black,
                          ),
                        ),
                        Text(
                          'register now to browse our hot offers',
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color :Colors.grey,
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        defaultFormFild(
                          controller: namecontroller,
                          validate: (String value)
                          {
                            if(value.isEmpty)
                            {
                              return 'Pleas Enter your Name';
                            }
                          },
                          type: TextInputType.name,
                          label: 'User Name',
                          prefix: Icons.person,
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultFormFild(
                          controller: emailcontroller,
                          validate: (String value)
                          {
                            if(value.isEmpty)
                            {
                              return 'Pleas Enter your Email Address';
                            }
                          },
                          type: TextInputType.name,
                          label: 'Email Address',
                          prefix: Icons.email_outlined,
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultFormFild(
                          controller: passwordcontroller,
                          suffix: ShopRegisterCubit.get(context).suffix,
                          onSubmit: (value)
                          {
                            // if(formKey.currentState!.validate())
                            // {
                            //   ShopRegisterCubit.get(context).userLogin(
                            //     email: emailcontroller.text,
                            //     password: passwordcontroller.text,
                            //   );
                            // }
                          },
                          isPassword: ShopRegisterCubit.get(context).isPassword,
                          suffixPressed: ()
                          {
                            ShopRegisterCubit.get(context).changePasswordVisibility();
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
                          height: 15.0,
                        ),
                        defaultFormFild(
                          controller: phonecontroller,
                          validate: (String value)
                          {
                            if(value.isEmpty)
                            {
                              return 'Pleas Enter your Phone Number';
                            }
                          },
                          type: TextInputType.phone,
                          label: 'Phone number',
                          prefix: Icons.phone,
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopRegisterLoadinglState,
                          builder: (context) => defaultButton(
                            function: ()
                            {
                              if(formKey.currentState!.validate())
                              {
                                ShopRegisterCubit.get(context).userRegister(
                                  name: namecontroller.text,
                                  email: emailcontroller.text,
                                  password: passwordcontroller.text,
                                  phone: phonecontroller.text,
                                );
                              }
                            },
                            text: 'register',
                            isUpperCase: true,
                          ),
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator()),
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
