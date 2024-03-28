import 'package:f2p_games/view/widgets/my_text.widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../services/game__list_page_services.dart';

// ignore: must_be_immutable
class GenreSelectionModal extends StatefulWidget {
  final List<bool> isSelectedList;
  final Function(int, bool) onSelected;

  const GenreSelectionModal({
    Key? key,
    required this.isSelectedList,
    required this.onSelected,
  }) : super(key: key);

  @override
  State<GenreSelectionModal> createState() => _GenreSelectionModalState();
}

class _GenreSelectionModalState extends State<GenreSelectionModal> {
  GameListPageServices homePageServices = GameListPageServices();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Wrap(
        spacing: 5,
        children: [
          // Repeat for each genre
          for (int index = 0; index < 39; index++)
            ChoiceChip(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16))),
              label: MyText(
                  googleFont: GoogleFonts.michroma,
                  color: widget.isSelectedList[index]
                      ? Colors.white
                      : Colors.black,
                  fontSize: 14,
                  title: homePageServices.getGenreFromIndex(index),
                  weight: FontWeight.normal),
              selected: widget.isSelectedList[index],
              selectedColor: Colors.purple,
              onSelected: (newBoolValue) {
                setState(() {
                  // Toggle the selected state of the current item
                  widget.isSelectedList[index] = newBoolValue;
                  // Deselect all other items
                  for (int i = 0; i < widget.isSelectedList.length; i++) {
                    if (i != index) {
                      widget.isSelectedList[i] = false;
                    }
                  }
                });
                widget.onSelected(index, newBoolValue);
              },
            ),
        ],
      ),
    );
  }
}
