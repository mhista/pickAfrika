import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pickafrika/utils/constants/colors.dart';
import 'package:pickafrika/utils/constants/image_strings.dart';
import 'package:pickafrika/utils/constants/sizes.dart';

import '../../../../common/widgets/custom_shapes/containers/primary_header_container.dart';
import '../../../../common/widgets/custom_shapes/containers/search_container.dart';
import '../../../../common/widgets/layouts/gid_layout.dart';
import '../../../../common/widgets/products/product_cards/product_card_vertical.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../all_products/all_products.dart';
import 'widgets/home_appbar.dart';
import 'widgets/home_categories.dart';
import 'widgets/home_slider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // HEADER
            const PPrimaryHeaderContainer(
              child: Column(
                children: [
                  // APP BAR
                  PHomeAppbar(),
                  SizedBox(
                    height: PSizes.spaceBtwSections,
                  ),

                  // SEARCHBAR PART
                  PSearchContainer(
                    icon: Iconsax.search_normal,
                    text: 'Search in Market',
                  ),
                  SizedBox(
                    height: PSizes.defaultSpace,
                  ),

                  // CATEGORIES PART
                  Padding(
                    padding: EdgeInsets.only(
                      left: PSizes.defaultSpace,
                    ),
                    child: Column(
                      children: [
                        PSectionHeading(
                          title: 'Popular Categories',
                          showActionButton: false,
                          textColor: PColors.white,
                        ),
                        SizedBox(
                          height: PSizes.spaceBtwItems,
                        ),
                        PHomeCategories()
                      ],
                    ),
                  ),
                  SizedBox(
                    height: PSizes.defaultSpace,
                  )
                ],
              ),
            ),
            // BODY PART
            Padding(
              padding: const EdgeInsets.all(PSizes.buttonWidth),
              child: Column(
                children: [
                  const PPromoSlider(
                    banners: [
                      PImages.promoBanner1,
                      PImages.promoBanner2,
                      PImages.promoBanner3,
                    ],
                  ),
                  const SizedBox(
                    height: PSizes.spaceBtwItems,
                  ),
                  // Popular Products

                  // HEADING SECTION
                  PSectionHeading(
                    title: 'Popular Products',
                    onPressed: () => Get.to(() => const AllProducts()),
                  ),
                  const SizedBox(
                    height: PSizes.spaceBtwItems,
                  ),
                  PGridLayout(
                    itemCount: 2,
                    itemBuilder: (_, index) => const PProductCardVertical(),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}


// (_, index) => const PProductCardVertical()