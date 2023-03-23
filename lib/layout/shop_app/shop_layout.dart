import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../modules/shop_app/search/search_scren.dart';
import '../../shared/components/components.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class ShopLayout extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopCubit()..getHomeData()..getCategories()..getFavoritea()..getUserData(),
      child: BlocConsumer<ShopCubit , ShopStates>(
        listener: (context , state){},
        builder: (context , state){

          var cubit = ShopCubit.get(context);

          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Salla',
              ),
              actions: [
                IconButton(
                  icon: Icon(Icons.search) ,
                  onPressed: ()
                  {
                    navigateTo(context, SearchScreen());
                  },
                ),
              ],
            ),
            body: cubit.BottomScreen[cubit.currentIndex],

            bottomNavigationBar: BottomNavigationBar(
              onTap:(index)
                {
                  cubit.changeBottom(index);
                },
                currentIndex:cubit.currentIndex ,
                items: [
                BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                label: 'Home',
              ),
                BottomNavigationBarItem(
                icon: Icon(
                  Icons.apps,
                ),
                label: 'Cateogries',
              ),
                BottomNavigationBarItem(
                icon: Icon(
                  Icons.favorite,
                ),
                label: 'Favorites',
              ),
                BottomNavigationBarItem(
                icon: Icon(
                  Icons.settings,
                ),
                label: 'Settings',
              ),
             ],
             ),
           );
         },
       ),
    );
  }
}
