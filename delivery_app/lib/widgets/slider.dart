import 'package:flutter/material.dart';

class MySlider extends StatefulWidget {
  const MySlider({super.key});

  @override
  State<MySlider> createState() => _MySliderState();
}

class _MySliderState extends State<MySlider> {
  List<String> banners = [
    'https://img.freepik.com/premium-vector/food-delivery-service-fast-food-delivery-scooter-delivery-service-vector-illustration_67394-1192.jpg?size=626&ext=jpg&ga=GA1.1.523418798.1711497600&semt=ais',
    'https://img.freepik.com/premium-vector/food-delivery-banner-design-flat-design-online-order_42237-696.jpg',
    'https://img.freepik.com/premium-vector/food-delivery-online-mobile-phone-shopping-online-online-food-order-internet-ecommerce-concept-website-banner-3d-perspective-vector-illustration_473922-160.jpg',
  ];
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        children: [
          SizedBox(
            height: 200,
            width: double.infinity,
            child: PageView.builder(
                onPageChanged: (index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                itemCount: banners.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      child: SizedBox(
                        height: 200,
                        width: double.infinity,
                        child: Image.network(
                          banners[index],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                }),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [for (var i = 0; i < banners.length; i++)
              buildIndicator(currentIndex == i)
            ],
          )
        ],
      ),
    );
  }

  Widget buildIndicator(bool isSelected) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: Container(
        height: isSelected ? 12 : 8,
        width: isSelected ? 12 : 8,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected ? Colors.red : Colors.grey
        ),
      ),
    );
  }
}
