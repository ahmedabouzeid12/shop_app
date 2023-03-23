
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/shop_app/cubit/cubit.dart';
import '../../../layout/shop_app/cubit/states.dart';
import '../../../shared/components/components.dart';
import '../../../shared/components/constants.dart';


class SettingsSceen extends StatelessWidget {

  var formkey = GlobalKey<FormState>();

var nameController = TextEditingController();
var emailController = TextEditingController();
var phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit , ShopStates>(
      listener: (context , state)
      {
        // if(state is ShopSuccessUserDataState)
        // {
        //   nameController.text = state.loginModel.data.name;
        //   emailController.text = state.loginModel.data.email;
        //   phoneController.text = state.loginModel.data.phone;
        // }
      },
      builder: (context , state) {
        var model = ShopCubit.get(context).userModel;
        nameController.text = model!.data!.name!;
        emailController.text = model.data!.email!;
        phoneController.text = model.data!.phone!;
        return ConditionalBuilder(
          condition: ShopCubit.get(context).userModel != null,
          builder: (context) => Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formkey,
              child: Column(
                children: [
                  if(state is ShopLoadingUpdateUserState)
                  LinearProgressIndicator(),
                  SizedBox(
                    height: 20.0,
                  ),
                  defaultFormFild(
                    controller: nameController,
                    type: TextInputType.name,
                    validate: (String value)
                    {
                      if(value.isEmpty)
                      {
                        return 'name must not be empty';
                      }
                      return null;
                    },
                    label: 'Name',
                    prefix: Icons.person,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  defaultFormFild(
                    controller: emailController,
                    type: TextInputType.emailAddress,
                    validate: (String value)
                    {
                      if(value.isEmpty)
                      {
                        return 'email must not be empty';
                      }
                      return null;
                    },
                    label: 'Email Address',
                    prefix: Icons.email,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  defaultFormFild(
                    controller: phoneController,
                    type: TextInputType.phone,
                    validate: (String value)
                    {
                      if(value.isEmpty)
                      {
                        return 'phone must not be empty';
                      }
                      return null;
                    },
                    label: 'Phone Number',
                    prefix: Icons.phone,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  defaultButton(
                    function: ()
                    {
                      if(formkey.currentState!.validate())
                      {
                        ShopCubit.get(context).updatetUserData(
                          name: nameController.text,
                          email: emailController.text,
                          phone: phoneController.text,
                        );
                      }
                    },
                    text: 'Update',
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  defaultButton(
                      function: ()
                      {
                        signOut(context);
                      },
                      text: 'Logoit',
                  ),
                ],
              ),
            ),
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
