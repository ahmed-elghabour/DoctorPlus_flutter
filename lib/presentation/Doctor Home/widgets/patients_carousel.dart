import 'package:carousel_slider/carousel_slider.dart';
import 'package:doctor_plus/data/model/doctor_reservation.dart';
import 'package:doctor_plus/domain/cubits/doctorReservations/doctor_reservation_cubit.dart';
import 'package:doctor_plus/utils/reservation_chunks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class PatientsCarousel extends StatefulWidget {
  const PatientsCarousel({super.key});
  
  @override
  State<PatientsCarousel> createState() => _PatientsCarouselState();
}

class _PatientsCarouselState extends State<PatientsCarousel> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DoctorReservationCubit, List<DoctorReservation>>(
      builder: (context, reservations) {
        if (reservations.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }
        List<List<DoctorReservation>> chunkedReservations =
            chunkedReservList(reservations, 4);

        //TODO: separate code of one reservation UI
        List<Widget> reservationSliders = chunkedReservations.map((chunk) {
          return Column(
            children: chunk.map((item) {
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 10.0),
                child: Card(
                  child: ListTile(
                    title: Text('Patient ID: ${item.patientId}'),
                    subtitle: Text('Reservation Type: ${item.reservationType}'),
                    trailing: Text('${item.reservationDate}'),
                  ),
                ),
              );
            }).toList(),
          );
        }).toList();

        return Column(
          children: [
            CarouselSlider(
              items: reservationSliders,
              carouselController: _controller,
              options: CarouselOptions(
                autoPlay: false,
                enlargeCenterPage: true,
                height: MediaQuery.of(context).size.height * 0.6,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                },
              ),
            ),

            //TODO: Separate code of slider
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: chunkedReservations.asMap().entries.map((entry) {
                return GestureDetector(
                  onTap: () => _controller.animateToPage(entry.key),
                  child: Container(
                    width: 12.0,
                    height: 12.0,
                    margin: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 4.0),
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
    });
  }
}
