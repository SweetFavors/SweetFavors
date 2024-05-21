import 'package:flutter/material.dart';
import 'package:sweet_favors/Utils/text_use.dart';
import 'package:sweet_favors/widgets/title_bar.dart';

class Eula extends StatelessWidget {
  const Eula({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBarPop(
        title: 'Privacy policy',
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: ListView(
          children: const [
            RegularTextBold('Information We Collect'),
            RegularText(
                'We collect several types of information to provide and enhance our Service. This includes information such as your name, email address, username, and profile picture (optional) which you provide when creating a SweetFavors account. We store the details of the wishes you add to your wishlists, including descriptions, links, images, and any additional notes you provide. With your permission, we may access your contact list or social media connections to help you find and connect with friends on the platform. Additionally, we collect information about how you  interact with our Service, including pages visited, features used, time spent on the app, and other usage patterns. We may collect limited information about your device, such as the device type, operating system, IP address, and browser information. Finally, with your explicit permission, we may collect your location data to provide location-based features (e.g., suggesting nearby gift options).'),
            SizedBox(
              height: 12,
            ),
            RegularTextBold('How We Use Your Information'),
            RegularText(
                'We use your information for a variety of purposes, including operating, delivering, and improving our SweetFavors Service. We utilize your information to personalize your experience by customizing content, wish suggestions, and offers within the app. Your information helps us facilitate connections between you,  your friends, and family on the platform.  We may use your email address to send you important updates, notifications, or service-related information. Finally, we use aggregated and anonymized data to enhance the Service\'s overall quality and improve features.'),
            SizedBox(
              height: 12,
            ),
            RegularTextBold('How We Share Your Information'),
            RegularText(
                'We may share your information in certain circumstances. When you share wish details or connect with friends on SweetFavors, your chosen information may be visible to those friends. We may share information with third-party service providers who help us operate the Service (e.g., hosting, analytics, and payment processing).  If required by law, subpoena, or to protect the rights, safety, or property of us or others, we may disclose your information. In the event of a merger, acquisition, or asset sale, your information may be transferred.'),
            SizedBox(
              height: 12,
            ),
            RegularTextBold('Your choice'),
            RegularText(
                'You have several options to control your information. You can manage and update certain account information within your SweetFavors profile settings. You may opt out of promotional emails by following the instructions provided in those emails. You can manage location permission settings for the SweetFavors app within your device settings.'),
            SizedBox(
              height: 12,
            ),
            RegularTextBold('Data security'),
            RegularText(
                'We implement reasonable technical and organizational measures to safeguard your information. However, please be aware that no data transmission over the internet can be guaranteed as 100% secure.'),
          ],
        ),
      ),
    );
  }
}
