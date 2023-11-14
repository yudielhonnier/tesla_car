import 'package:flutter/material.dart';
import 'package:tesla_animation/constanins.dart';
import 'package:tesla_animation/home_controller.dart';
import 'package:tesla_animation/screens/components/temp_btn.dart';

class TempDetails extends StatelessWidget {
  const TempDetails({
    super.key,
    required HomeController controller,
  }) : _controller = controller;

  final HomeController _controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 120,
            child: Row(
              children: [
                TempBtn(
                  isActive: _controller.isCoolSelected,
                  title: "Cool",
                  svgSrc: "assets/icons/coolShape.svg",
                  press: _controller.updateCoolSelected,
                ),
                const SizedBox(
                  width: defaultPadding,
                ),
                TempBtn(
                  isActive: !_controller.isCoolSelected,
                  title: "Heat",
                  svgSrc: "assets/icons/coolShape.svg",
                  press: _controller.updateCoolSelected,
                  activeColor: redColor,
                ),
              ],
            ),
          ),
          const Spacer(),
          Column(
            children: [
              IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {},
                  icon: const Icon(
                    Icons.arrow_drop_up,
                    size: 48,
                  )),
              const Text(
                "20 " "\u2103",
                style: TextStyle(fontSize: 86),
              ),
              IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {},
                  icon: const Icon(
                    Icons.arrow_drop_down,
                    size: 48,
                  )),
            ],
          ),
          const Spacer(),
          const Text("CURRENT TEMPERATURE"),
          const SizedBox(
            height: defaultPadding,
          ),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Inside".toUpperCase()),
                  Text(
                    "20 " "\u2103",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ],
              ),
              const SizedBox(
                width: defaultPadding,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Inside".toUpperCase(),
                    style: const TextStyle(color: Colors.white54),
                  ),
                  Text(
                    "20 " "\u2103",
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall!
                        .copyWith(color: Colors.white54),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
