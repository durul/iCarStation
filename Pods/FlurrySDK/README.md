Flurry
======

Latest Flurry SDK

To use 6.7.0 or higher FlurrySDK from cocoapods, add this line in your Pods file:

```
  pod 'FlurrySDK', '~>6.7'
```


If you also want the FlurryAds SDK, you can define pods to install both subspecs:

```
  pod 'FlurrySDK/FlurrySDK', '~>6.7'
  pod 'FlurrySDK/FlurryAds', '~>6.7'
```


If you want to use FlurrySDK for Apple Watch Extension:    
```
target :"Your Apple Watch Extension Target" do 
   pod 'FlurrySDK/FlurryWatchSDK', '~>6.7'
end   
```
Don't forget to read how to track events correctly in Apple Watch Extensions  in FlurryiOSAnalyticsREADMExx.pdf  
