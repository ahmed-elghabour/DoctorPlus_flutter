import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class PatientCarouselSlider extends StatefulWidget {
  final List<List<dynamic>> chunkedReservations;
  final List<Widget> reservationSliders;
  const PatientCarouselSlider(
      {super.key,
      required this.chunkedReservations,
      required this.reservationSliders});

  @override
  State<PatientCarouselSlider> createState() => _PatientCarouselSliderState();
}

class _PatientCarouselSliderState extends State<PatientCarouselSlider> {
  int _current = 0;
  final CarouselController _controller = CarouselController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          items: widget.reservationSliders,
          carouselController: _controller,
          options: CarouselOptions(
            aspectRatio: 16/13,
            // height: MediaQuery.sizeOf(context).height,
            viewportFraction: 1,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.chunkedReservations.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => _controller.animateToPage(entry.key),
              child: Container(
                width: 12.0,
                height: 12.0,
                margin:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: (Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black)
                      .withOpacity(_current == entry.key ? 0.9 : 0.4),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
