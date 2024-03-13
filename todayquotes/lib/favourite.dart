import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'color.dart';
import 'favourite_provider.dart';
import 'home.dart';
class favourite extends StatefulWidget {
  const favourite({super.key});

  @override
  State<favourite> createState() => _favouriteState();
}

class _favouriteState extends State<favourite> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FavoritesProvider>(context);
    final quotes = provider.quote;

    return Scaffold(

        appBar: AppBar(
            backgroundColor: darkblue,
            elevation: 0,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Favorites',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                  ),
                ),
              ],
            )
        ),

       body:
    Container(
    width: double.infinity,
    height: double.infinity,
    decoration: BoxDecoration(
    image: DecorationImage(image: AssetImage("images/f_background.png"),fit:BoxFit.cover),

    ),
           child:
           ListView.builder(

            itemCount: quotes.length,
               itemBuilder: (context,index) {

                 final quote = quotes[index];
                 return ListTile(
                   title: Text(
                   ('"'+quote+'"'),
                     style: TextStyle(
                       color: Colors.white,
                       fontSize: 20,
                       fontWeight:FontWeight.w500

                     ) ,

                   ),
                   trailing: IconButton(onPressed :(){
                     provider.toggleFavorite(quote);
                   },
                       icon: provider.isExist(quote)
                           ? const Icon(Icons.favorite, color: Colors.red,)
                           : const Icon(Icons.favorite_border,color: Colors.red,)


                   ),
                 );

               }

           ),
    )
    );
  }
}
