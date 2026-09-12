part of 'settings_page.dart';

/// GitHub repository this fork is based on. Updates are disabled in this
/// project: it only ships the version built from this repository, so these
/// constants are only used for the repository link on the About page.
const kUpdateRepoOwner = 'Kyosee';
const kUpdateRepoName = 'VeneraX';

class AboutSettings extends StatefulWidget {
  const AboutSettings({super.key});

  @override
  State<AboutSettings> createState() => _AboutSettingsState();
}

class _AboutSettingsState extends State<AboutSettings> {

  @override
  Widget build(BuildContext context) {
    return SmoothCustomScrollView(
      scrollbarTopPadding: context.padding.top + 56,
      slivers: [
        SliverAppbar(title: Text("About".tl)),
        SizedBox(
          height: 112,
          width: double.infinity,
          child: Center(
            child: Container(
              width: 112,
              height: 112,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(136)),
              clipBehavior: Clip.antiAlias,
              child: Image(
                image: AssetImage(LauncherIconService.current.inAppLogoAsset),
                filterQuality: FilterQuality.medium,
              ),
            ),
          ),
        ).paddingTop(16).toSliver(),
        Column(
          children: [
            const SizedBox(height: 8),
            Text("V${App.version}", style: const TextStyle(fontSize: 16)),
            Text(
              "VeneraX is a free and open-source, multi-platform comic reader forked from Venera and maintained with enhancements over the original.".tl,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
          ],
        ).paddingHorizontal(16).toSliver(),
        ListTile(
          title: Text("Guide".tl),
          subtitle: Text("How to use the main features".tl),
          trailing: const Icon(Icons.menu_book_outlined),
          onTap: () => GuidePage.open(context),
        ).toSliver(),
        ListTile(
          title: Text("Repository".tl),
          subtitle: const Text("$kUpdateRepoOwner/$kUpdateRepoName"),
          trailing: const Icon(Icons.open_in_new),
          onTap: () {
            launchUrlString("https://github.com/$kUpdateRepoOwner/$kUpdateRepoName");
          },
        ).toSliver(),
        ListTile(
          title: Text("User Agreement & Disclaimer".tl),
          trailing: const Icon(Icons.info_outline),
          onTap: () => showDisclaimerDialog(context),
        ).toSliver(),
      ],
    );
  }
}
