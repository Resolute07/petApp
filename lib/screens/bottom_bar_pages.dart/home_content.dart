import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:petapp/bloc/search_bloc/search_bloc.dart';
import 'package:petapp/bloc/search_bloc/search_event.dart';
import 'package:petapp/bloc/search_bloc/search_state.dart';
import 'package:petapp/core/theme/colors.dart';
import 'package:petapp/core/widgets/custom_banner.dart';
import 'package:petapp/screens/category_page.dart';
import 'package:petapp/screens/details_page.dart';
import 'package:petapp/screens/see_more_pages/catogory_see_more.dart';
import 'package:petapp/screens/see_more_pages/ready_to_adopt.dart';
import 'package:petapp/static_data/data.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchBloc(listOfPetsGeneral),
      child: Scaffold(
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: [
              MediaQuery.of(context).orientation==Orientation.portrait?
              const SearchBarWidget():SizedBox(),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildSearchResults(),
                      const CustomBanner(),
                      const CategorySubWidget(),
                      const ReadyToAdoptWidget(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }



 

  Widget _buildSearchResults() {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        if (state is SearchLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is SearchEmpty) {
          return const Center(
            child: Text("Start searching for pets..."),
          );
        } else if (state is SearchLoaded) {
          if (state.filteredPets.isEmpty) {
            return const Center(
              child: Text("No pets found"),
            );
          }

          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: state.filteredPets.length,
            itemBuilder: (context, index) {
              final pet = state.filteredPets[index];
              return ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    pet.imageUrl!,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text(pet.name!),
                subtitle: Text(pet.breed ?? "Unknown Breed"),
                trailing: Text('${pet.age!.toStringAsFixed(0)} Yrs'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return DetailsPage(petModel: pet);
                      },
                    ),
                  );
                },
              );
            },
          );
        } else if (state is SearchError) {
          return const Center(
            child: Text("Error occurred"),
          );
        }

        return const Center(
          child: Text("Start searching for pets..."),
        );
      },
    );
  }
}





class CategorySubWidget extends StatelessWidget {
  const CategorySubWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Hero(
                tag: 'Categories',
                child: Material(
                    child: Text(
                  "Categories",
                  style: Theme.of(context).textTheme.titleSmall,
                ))),
            TextButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      return const CategorySeeMorePage();
                    },
                  ));
                },
                child: const Text("See more")),
          ],
        ),
        SizedBox(
          height:MediaQuery.of(context).orientation==Orientation.landscape?100: 150.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: petCategories.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      return CategoryPage(petType: petCategories[index]);
                    },
                  ));
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: petColors[index]),
                        height: 80.h,
                        width: 80.w,
                        child: Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(categoryimages[index]),
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Hero(
                          tag: petCategories[index],
                          child: Material(child: Text(petCategories[index]))),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class ReadyToAdoptWidget extends StatelessWidget {
  const ReadyToAdoptWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Hero(
              tag: 'Ready to adopt',
              child: Material(
                child: Text(
                  "Ready to adopt",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return const ReadyToAdoptPage();
                  },
                ));
              },
              child: const Text("See more"),
            ),
          ],
        ),
    LayoutBuilder(
  builder: (context, constraints) {
    double itemWidth = 180;
    int crossAxisCount = (constraints.maxWidth / itemWidth).floor().clamp(1, 4);

    double childAspectRatio = itemWidth / (itemWidth + 60); 

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 10,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: childAspectRatio,
      ),
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return DetailsPage(
                    petModel: listOfPetsGeneral[index],
                  );
                },
              ),
            );
          },
          child: Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Hero(
                      tag: listOfPetsGeneral[index].id,
                      child: Image.asset(
                        listOfPetsGeneral[index].imageUrl!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: (constraints.maxWidth / crossAxisCount) * 0.7, // 70% of width as height.
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    listOfPetsGeneral[index].name!,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  Text(listOfPetsGeneral[index].breed ?? "Pup"),
                  Text(
                    '${listOfPetsGeneral[index].age!.toStringAsFixed(0)} Yrs',
                    style: const TextStyle(color: Colors.blue),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  },
)

,

        TextButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) {
                return const ReadyToAdoptPage();
              },
            ));
          },
          child: const Text("See more"),
        ),
      ],
    );
  }
}



class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15.0),
      child: TextField(
        onChanged: (query) {
          context.read<SearchBloc>().add(SearchQueryChanged(query));
        },
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: blue),
            borderRadius: BorderRadius.circular(15),
          ),
          prefixIcon: Icon(
            Icons.search,
            color: Colors.grey[400],
          ),
          hintText: 'Search pet',
          hintStyle: TextStyle(letterSpacing: 1, color: Colors.grey[400]),
          filled: true,
          fillColor: Colors.white,
          suffixIcon: Icon(Icons.tune_sharp, color: Colors.grey[400]),
        ),
      ),
    );
  }
}
