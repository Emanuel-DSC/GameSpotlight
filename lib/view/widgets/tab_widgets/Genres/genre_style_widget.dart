import 'dart:ui';

import 'package:flutter/material.dart';

import 'genres_selection_widget.dart';

IconButton genreFilter(
    BuildContext context, setState, genre, homePageServices, store) {
  List<bool> isSelectedList =
      List.filled(39, false); // Initialize with false for each chip

  return IconButton(
      icon: const Icon(
        Icons.abc,
        color: Colors.white,
      ),
      onPressed: () {
        setState(
          () {
            showModalBottomSheet(
              backgroundColor: Colors.transparent,
              isScrollControlled: true,
              context: context,
              builder: (BuildContext context) {
                return FractionallySizedBox(
                  heightFactor: 0.7,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(12),
                    ),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: 20.0,
                        sigmaY: 20.0,
                      ),
                      child: Container(
                        color: Colors.white
                            .withOpacity(0.1), // Adjust opacity as needed
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: GenreSelectionModal(
                            isSelectedList: isSelectedList,
                            onSelected: (index, newBoolValue) {
                              setState(() {
                                isSelectedList = List.filled(
                                    39, false); // Deselect all chips
                                isSelectedList[index] = newBoolValue;
                                genre = homePageServices.getGenreFromIndex(
                                    index); // Convert index to genre
                                store.getGenres(genre);
                                Navigator.pop(context);
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        );
      });
}
