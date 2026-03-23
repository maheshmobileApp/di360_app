query GetAppConfig($platform: String!) {
  app_config(
    where: { platform: { _eq: $platform } }
    limit: 1
  ) {
    id
    platform
    storeUrl
    message
    forceUpdate
    minSupportedVersion
    latestVersion
  }
}


{
  "platform": "android" / 'iOS'
}


Response 

{
  "data": {
    "app_config": [
      {
        "id": "7a52906d-cbbc-4f7d-866f-4697e771cf4e",
        "platform": "iOS",
        "storeUrl": "https://apps.apple.com/app/id6755395052",
        "message": "Please update the App",
        "forceUpdate": false,
        "minSupportedVersion": "1.1.0",
        "latestVersion": "2.1.0"
      }
    ]
  }
}


mutation UpdateAndroidConfig {
  update_app_config(
    where: { platform: { _eq: "iOS" } }
    _set: {
      latestVersion: "2.1.0",
      minSupportedVersion: "1.5.0",
      forceUpdate: true,
      message: "A new version of the app is available."
    }
  ) {
    affected_rows
  }
}

