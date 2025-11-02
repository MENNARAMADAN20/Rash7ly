import 'package:flutter/material.dart';
import 'package:rash7ly/components/buttons/main_button.dart';
import 'package:rash7ly/features/home/presentation/widgets/card_lower.dart';
import 'package:rash7ly/features/home/presentation/widgets/card_photo.dart';
import 'package:rash7ly/features/home/presentation/widgets/upper_card.dart';

class CardDetails extends StatefulWidget {
  const CardDetails({super.key});

  @override
  State<CardDetails> createState() => _CardDetailsState();
}

class _CardDetailsState extends State<CardDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 5),
          child: MainButton(
            text: 'show on map',
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isDismissible: false,
                builder: (context) {
                  return Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Product Details',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(Icons.close),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Text(model.name),
                              // Text('\$${model.price}'),
                            ],
                          ),
                        ),
                        Divider(color: Colors.grey),
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //    children: [Text('Quantity'), Text(model.quantity)],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
      //    appBar: AppBar(),
      body: Stack(
        children: [
          CardPhoto(),
          UpperCard(),
          CardLower(),
        ],
      ),
    );
  }
}
