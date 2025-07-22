import 'package:flutter/material.dart';
import 'package:gftr/Helper/appConfig.dart';
import 'package:gftr/Helper/colorConstants.dart';

class ExpandableNotesWidget extends StatefulWidget {
  final String notes;
  final VoidCallback onEdit;

  const ExpandableNotesWidget({
    Key? key,
    required this.notes,
    required this.onEdit,
  }) : super(key: key);

  @override
  _ExpandableNotesWidgetState createState() => _ExpandableNotesWidgetState();
}

class _ExpandableNotesWidgetState extends State<ExpandableNotesWidget> {
  bool _needsExpansion = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkIfExpansionNeeded();
    });
  }

  void _checkIfExpansionNeeded() {
    if (widget.notes.isEmpty) {
      setState(() {
        _needsExpansion = false;
      });
      return;
    }

    final TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: "Notes: ${widget.notes}",
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w100,
          fontFamily: poppins,
        ),
      ),
      textDirection: TextDirection.ltr,
      maxLines: 2,
    );

    final double maxWidth = MediaQuery.of(context).size.width / 1.8 -
        40; // Account for padding and icon
    textPainter.layout(maxWidth: maxWidth);

    setState(() {
      _needsExpansion = textPainter.didExceedMaxLines;
    });
  }

  void _showNotesDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return NotesDialog(
          notes: widget.notes,
          onEdit: widget.onEdit,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth(context, dividedBy: 1.8),
      padding: EdgeInsets.only(
        left: screenWidth(context, dividedBy: 60),
        top: 8,
        bottom: 8,
        right: 8,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          width: 1.2,
          color: ColorCodes.greyButton,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: _needsExpansion ? _showNotesDialog : null,
                  child: Text(
                    "Notes: ${widget.notes}",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 10,
                      fontWeight: FontWeight.w100,
                      fontFamily: poppins,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (_needsExpansion)
                    GestureDetector(
                      onTap: _showNotesDialog,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        child: Icon(
                          Icons.visibility,
                          size: 16,
                          color: ColorCodes.greyButton,
                        ),
                      ),
                    ),
                  const SizedBox(width: 4),
                  GestureDetector(
                    onTap: widget.onEdit,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      child: Icon(
                        Icons.edit,
                        size: 16,
                        color: ColorCodes.greyButton,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class NotesDialog extends StatelessWidget {
  final String notes;
  final VoidCallback onEdit;

  const NotesDialog({
    Key? key,
    required this.notes,
    required this.onEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      insetPadding: EdgeInsets.all(20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        constraints: BoxConstraints(
          maxWidth: screenWidth(context, dividedBy: 1.2),
          maxHeight: screenHeight(context, dividedBy: 1.5),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Notes',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    fontFamily: poppins,
                    color: Colors.black,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: Icon(Icons.close, size: 20),
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Flexible(
              child: SingleChildScrollView(
                child: Text(
                  notes,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    fontFamily: poppins,
                    color: Colors.black87,
                    height: 1.4,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(
                    'Close',
                    style: TextStyle(
                      color: ColorCodes.greyButton,
                      fontFamily: poppins,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
