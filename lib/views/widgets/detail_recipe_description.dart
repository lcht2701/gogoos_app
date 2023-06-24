import 'package:flutter/material.dart';

class RecipeDescription extends StatefulWidget {
  final String description;

  const RecipeDescription({
    Key? key,
    required this.description,
  }) : super(key: key);

  @override
  State<RecipeDescription> createState() => _RecipeDescriptionState();
}

class _RecipeDescriptionState extends State<RecipeDescription> {
  bool isExpanded = false;
  final int maxLines = 2;

  @override
  Widget build(BuildContext context) {
    final textSpan = TextSpan(
      text: widget.description,
      style: TextStyle(
        color: Colors.white.withOpacity(0.9),
        fontSize: 14,
      ),
    );

    final textPainter = TextPainter(
      text: textSpan,
      maxLines: maxLines,
      textDirection: TextDirection.ltr,
    );

    textPainter.layout(maxWidth: MediaQuery.of(context).size.width);

    final isTextOverflowed = textPainter.didExceedMaxLines;

    return GestureDetector(
      onTap: () {
        setState(() {
          isExpanded = !isExpanded;
        });
      },
      child: RichText(
        text: textSpan,
        maxLines: isExpanded ? null : maxLines,
        overflow: isTextOverflowed && !isExpanded
            ? TextOverflow.ellipsis
            : TextOverflow.visible,
      ),
    );
  }
}
