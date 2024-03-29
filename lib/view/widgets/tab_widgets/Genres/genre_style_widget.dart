// import 'dart:ui';

// import 'package:flutter/material.dart';

// import 'genres_selection_widget.dart';

// FractionallySizedBox teste(BuildContext context, isSelectedList, setState,
//     genre, homePageServices, store) {
//   return FractionallySizedBox(
//     heightFactor: 0.75,
//     child: BackdropFilter(
//           filter: ImageFilter.blur(
//             sigmaX: 20.0,
//             sigmaY: 20.0,
//           ),
//           child: Container(
//             color: Colors.white.withOpacity(0.08), // Adjust opacity as needed
//             child: Padding(
//               padding: const EdgeInsets.all(10.0),
//               child: GenreSelectionModal(
//                   isSelectedList: isSelectedList,
//                   onSelected: (index, newBoolValue) {
//                     setState(() {
//                       isSelectedList = List.filled(39, false); // Deselect all chips
//                       isSelectedList[index] = newBoolValue;
//                       genre = homePageServices
//                 .getGenreFromIndex(index); // Convert index to genre
//                       store.getGenres(genre);
//                       Navigator.pop(context);
//                     });
//                   },
//                 ),
//             ),
//   ),),);
// }
