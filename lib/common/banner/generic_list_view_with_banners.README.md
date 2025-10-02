# GenericListViewWithBanners Usage Guide

This widget allows you to inject banners (or any custom widgets) at specific indices in a ListView, while displaying your data items at all other positions. It is fully generic and works with any data model.

## Features
- Inject banners or widgets at any indices you specify
- Works with any data type/model
- Handles index mapping for you
- Simple API: just pass your data, banner indices, and builders

## Example Usage

Suppose you have a list of jobs and want to show a banner at index 0 and 5:

```dart
GenericListViewWithBanners<Jobs>(
  items: vm.jobs,
  bannerIndices: [0, 5], // Show banners at 0 and 5
  itemBuilder: (context, dataIndex) {
    final jobData = vm.jobs[dataIndex];
    return InkWell(
      onTap: () {
        navigationService.navigateToWithParams(
          RouteList.jobdetailsScreen,
          params: jobData,
        );
      },
      child: JobSeekCard(jobsData: jobData),
    );
  },
  bannerBuilder: (context, bannerPos) {
    // bannerPos is 0 for index 0, 1 for index 5, etc.
    return ListBanner(pageIndex: bannerPos);
  },
)
```

### Parameters
- `items`: Your data list (e.g., jobs)
- `bannerIndices`: List of indices where you want banners/widgets
- `itemBuilder`: How to build your data item (receives the mapped data index)
- `bannerBuilder`: How to build your banner/widget (receives the banner's order in the bannerIndices list)
- `scrollDirection`, `shrinkWrap`, `physics`: Standard ListView options (optional)

## Notes
- The widget automatically adjusts the data index for you, so you don't need to worry about skipping banner positions.
- You can use this for any data type, not just jobs!

---

**File:** `lib/common/banner/generic_list_view_with_banners.dart`
