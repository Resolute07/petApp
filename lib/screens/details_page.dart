import 'dart:ui';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petapp/bloc/adopt_bloc/adopt_bloc.dart';
import 'package:petapp/bloc/adopt_bloc/adopt_event.dart';
import 'package:petapp/bloc/adopt_bloc/adopt_state.dart';
import 'package:petapp/bloc/theme_bloc/theme_bloc.dart';
import 'package:petapp/core/theme/colors.dart';
import 'package:petapp/core/widgets/contact_widget.dart';
import 'package:petapp/models/pet_model.dart';
import 'package:photo_view/photo_view.dart';
import 'package:flutter/gestures.dart';
import '../core/widgets/slightly_boxes.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key, required this.petModel});
  final PetModel petModel;

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  late ConfettiController _confettiController;
  bool isExpanded = false;

  late ScrollController _scrollController;
  @override
  void initState() {
    super.initState();
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 1));
    _scrollController = ScrollController();
    _scrollController
        .addListener(_scrollListener); 
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose(); 
    _confettiController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.offset < -150) {
      if (Navigator.of(context).canPop()) {
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(alignment: Alignment.topCenter, children: [
          SingleChildScrollView(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
               Container(
  constraints: const BoxConstraints(maxHeight: 430, minHeight: 150),
  child: ClipRRect(
    borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(16), bottomRight: Radius.circular(16)),
    child: PhotoView(
      imageProvider: AssetImage(widget.petModel.imageUrl!),
      minScale: PhotoViewComputedScale.contained,
      maxScale: PhotoViewComputedScale.contained * 2.0,
      initialScale: PhotoViewComputedScale.contained, 
      basePosition: Alignment.center, 
      enableRotation: true, 
      backgroundDecoration: const BoxDecoration(
        color: Colors.black, 
      ),
      gestureDetectorBehavior: HitTestBehavior.opaque, 
      heroAttributes: PhotoViewHeroAttributes(tag: widget.petModel.id),
    ),
  ),
),


                NameWidget(petModel: widget.petModel,),
                  
                
                Transform.translate(offset: const Offset(0, -30),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Text(
                              //   widget.petModel.name!,
                              //   style:
                              //       Theme.of(context).textTheme.headlineMedium,
                              // ),
                              // const Spacer(),
                              Card(
                                color: blue,
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                    '\$${widget.petModel.price?.toStringAsFixed(2) ?? "N/A"}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall
                                        ?.copyWith(color: Colors.white),
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons
                                    .favorite_border), // favourite for filled color
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              const Icon(Icons.location_on_outlined,
                                  color: blue),
                              Text(
                                "Birmingham, London ",
                                style: Theme.of(context).textTheme.displaySmall,
                              ),
                              const SizedBox(width: 30),
                              Text(
                                "7.3 km ",
                                style: Theme.of(context).textTheme.displaySmall,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 25),
                       PetDetails(petModel: widget.petModel,),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: AnimatedSize(
                                duration: const Duration(milliseconds: 300),
                                child: buildExpandableText(
                                    widget.petModel.description!)),
                          ),
                        ),
                          
                        
                        const ContactWidget(
                          contactnumber: 234,
                          ownername: "John",
                        ),
                        const SizedBox(height: 65),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const BackButton(),
                //back button here
          Positioned(
          bottom: 30,
          child: AdoptButton(
            petId: widget.petModel.id,
            petName: widget.petModel.name!,
            confettiController: _confettiController,
          ),
        ),
          _buildConfetti(),
          // Positioned(
          //   top: 350, // 50px above the PhotoView
          //   left: 20,
          //   right: 20,
          //   child: Container(
          //     height: 100,
          //     decoration: BoxDecoration(
          //       color: Colors.black.withOpacity(0.5), // Translucent black
          //       borderRadius: BorderRadius.circular(12),
          //     ),
          //     child: Center(
          //       child: Text(
          //         "Special Adoption Offer!",
          //         style: Theme.of(context)
          //             .textTheme
          //             .headlineMedium
          //             ?.copyWith(color: Colors.white),
          //       ),
          //     ),
          //   ),
          // )
         
        ]),
      ),
    );
  }






  Widget _buildConfetti(){
    return  ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              shouldLoop: false,
              colors: const [
                Colors.blue,
                Colors.red,
                Colors.yellow,
                Colors.green
              ],
            );
  }

  Widget buildExpandableText(String text) {
    const int maxLines = 3;
    final TextStyle? textStyle = Theme.of(context).textTheme.bodyMedium;

    if (isExpanded) {
      return RichText(
        text: TextSpan(
          style: textStyle,
          children: [
            TextSpan(text: text),
            TextSpan(
              text: " Show less",
              style: const TextStyle(color: Colors.blueAccent),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  setState(() {
                    isExpanded = false;
                  });
                },
            ),
          ],
        ),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final textSpan = TextSpan(text: text, style: textStyle);
        final textPainter = TextPainter(
          text: textSpan,
          maxLines: maxLines,
          textDirection: TextDirection.ltr,
        )..layout(maxWidth: constraints.maxWidth);

        if (textPainter.didExceedMaxLines) {
          return RichText(
            text: TextSpan(
              style: textStyle,
              children: [
                TextSpan(
                  text: text.substring(
                      0,
                      textPainter
                          .getPositionForOffset(
                              Offset(constraints.maxWidth, textPainter.height))
                          .offset),
                ),
                const TextSpan(text: "... "),
                TextSpan(
                  text: "Read more",
                  style: const TextStyle(color: Colors.blueAccent),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      setState(() {
                        isExpanded = true;
                      });
                    },
                ),
              ],
            ),
          );
        } else {
          return Text(text, style: textStyle);
        }
      },
    );
  }
}



class PetDetails extends StatelessWidget {
  final PetModel petModel;

  const PetDetails({super.key, required this.petModel});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(scrollDirection: Axis.horizontal,
      child: Row(
        children: [
         
          SlightlyBorderBoxes(
            category: "Breed",
            data: petModel.breed ?? "Unknown",
          ),
          const SizedBox(width: 15),
          SlightlyBorderBoxes(
            category: "Weight",
            data: '${petModel.weight ?? "N/A"} Kg',
          ),
           const SizedBox(width: 15),
           SlightlyBorderBoxes(
            category: "Age",
            data: petModel.age?.toStringAsFixed(0) ?? "N/A",
          ),
         
        ],
      ),
    );
  }
}


class BackButton extends StatelessWidget {
  const BackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
              left: 20,
              top: 10,
              child: SizedBox(
                width: 48,
                height: 48,
                child: GestureDetector(
                  onTap: () {},
                  child: IconButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                          Theme.of(context).brightness == Brightness.dark
                              ? Colors.black
                              : Colors.white),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.arrow_back),
                  ),
                ),
              ),
            );
  }
}


class AdoptButton extends StatelessWidget {
  final String petId;
  final String petName;
  final ConfettiController confettiController;

  const AdoptButton({
    super.key,
    required this.petId,
    required this.petName,
    required this.confettiController,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdoptionBloc, AdoptionState>(
      builder: (context, state) {
        final adoptedPetIds = state is AdoptedPetsState
            ? state.adoptedPets.map((pet) => pet['id']!).toSet()
            : <String>{};
        final isAdopted = adoptedPetIds.contains(petId);

        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          decoration: BoxDecoration(
            color: isAdopted ? Colors.grey : Colors.blueAccent,
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 10,
              ),
            ],
          ),
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(
                isAdopted ? Colors.grey : Colors.blueAccent,
              ),
            ),
            onPressed: isAdopted
                ? null
                : () {
                    confettiController.play();
                    context.read<AdoptionBloc>().add(
                          AdoptPetEvent(petName: petName, id: petId),
                        );
                  },
            child: Text(
              isAdopted ? "Adopted" : "Adopt me",
              style: const TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }
}


class NameWidget extends StatefulWidget {
  const NameWidget({super.key, required this.petModel});
  final PetModel petModel;

  @override
  State<NameWidget> createState() => _NameWidgetState();
}

class _NameWidgetState extends State<NameWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize the AnimationController
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this, // Use the SingleTickerProviderStateMixin
    );

    // Define the offset animation (moving up)
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, 1), // Start off-screen (below)
      end: const Offset(0, -0.5), // Move it up
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut, // Apply easing curve
      ),
    );

    // Start the animation
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose(); // Don't forget to dispose the controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _offsetAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: _offsetAnimation.value * 50, // Moves up by 50px
          child: child,
        );
      },
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            margin: const EdgeInsets.symmetric(horizontal: 20),
            height: 100,
            decoration: BoxDecoration(
              color: context.read<ThemeBloc>().state.themeMode == ThemeMode.dark
                  ? Colors.black.withOpacity(0.7)
                  : Colors.white.withOpacity(0.75), // Translucent color based on theme
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.petModel.name!,
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(fontSize: 32),
                      ),
                      Text(
                        widget.petModel.breed!,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(fontSize: 20),
                      ),
                    ],
                  ),
                  const Spacer(),
                  const Icon(Icons.male, size: 60, color: Colors.blue),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
