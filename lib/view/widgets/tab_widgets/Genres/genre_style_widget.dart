import 'package:flutter/material.dart';

import 'genres_selection_widget.dart';

FractionallySizedBox teste(BuildContext context, isSelectedList, setState, genre, homePageServices, store) {
    return FractionallySizedBox(
                                          heightFactor: 0.7,
                                          child: GenreSelectionModal(
                                            isSelectedList: isSelectedList,
                                            onSelected:
                                                (index, newBoolValue) {
                                              setState(() {
                                                isSelectedList = List.filled(
                                                    39,
                                                    false); // Deselect all chips
                                                isSelectedList[index] =
                                                    newBoolValue;
                                                genre = homePageServices
                                                    .getGenreFromIndex(
                                                        index); // Convert index to genre
                                                store.getGenres(genre);
                                                Navigator.pop(context);
                                              });
                                            },
                                          ),
                                        );
  }