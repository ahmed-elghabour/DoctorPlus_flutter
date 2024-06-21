import 'dart:io';

import 'package:flutter/material.dart';

Widget fileUploaded({
  required List<File> files,
  required void Function()? onCLear,
}) {
  return files.isEmpty
      ? const SizedBox()
      : Stack(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1.0),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Wrap(
                children: files.map((file) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                    ),
                    child: Center(
                      child: Column(
                        children: [
                          Image.asset("assets/pdf.png"),
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Text(
                              file.path.split('/').last,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 13,
                                color: Colors.black,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            PositionedDirectional(
                top: -10,
                end: 0,
                child: IconButton(
                  onPressed: onCLear,
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                )),
          ],
        );
}
