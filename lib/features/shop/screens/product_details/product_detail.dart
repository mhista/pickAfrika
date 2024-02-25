import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pickafrika/common/widgets/texts/section_heading.dart';
import 'package:pickafrika/features/shop/screens/product_details/widgets/bottom_add_to_cart.dart';
import 'package:pickafrika/features/shop/screens/product_details/widgets/product_attributes.dart';
import 'package:pickafrika/utils/constants/sizes.dart';
import 'package:readmore/readmore.dart';

import 'widgets/product_image_slider.dart';
import 'widgets/product_meta_data.dart';
import 'widgets/rating_and_share.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomAddToCart(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // PRODUCT IMAGE SLIDER
            const ProductImageSlider(),
            // PRODUCT DETAILS
            Padding(
              padding: const EdgeInsets.only(
                  right: PSizes.spaceBtwSections,
                  left: PSizes.spaceBtwSections,
                  bottom: PSizes.defaultSpace),
              child: Column(
                children: [
                  // RATING AND SHAER BUTTON
                  const RatingAndShare(),
                  // PRICE , TITLE, STOCK, BRAND
                  const ProductMetaData(),
                  // ATTRIBUTES
                  const ProductAttributes(),
                  const SizedBox(
                    height: PSizes.spaceBtwSections,
                  ),
                  // CHECKOUT BUTTON
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Text('Checkout'),
                    ),
                  ),
                  const SizedBox(
                    height: PSizes.spaceBtwSections,
                  ),
                  // DESCRIPTION
                  const PSectionHeading(
                    title: 'Description',
                    showActionButton: false,
                  ),
                  const SizedBox(
                    height: PSizes.spaceBtwItems,
                  ),
                  const ReadMoreText(
                    'lorem lipsum dolore sicyut uiwh  uihdidcuihdc uihwidkncidc uidhidcnuic uihdneui uiedheuide uiieudejkkdnie eined euidbe ceh ecuincuic  uice cuecbie uuci  ciu ecue euc euc wecuy dcc   wuybeyuee ',
                    trimLines: 2,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: 'Show more',
                    trimExpandedText: 'Show less',
                    moreStyle:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                    lessStyle:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                  ),
                  // REVIEWS
                  const Divider(),
                  const SizedBox(
                    height: PSizes.spaceBtwItems,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const PSectionHeading(
                        title: 'Reviews (123)',
                        showActionButton: false,
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Iconsax.arrow_right_3,
                          size: 18,
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}