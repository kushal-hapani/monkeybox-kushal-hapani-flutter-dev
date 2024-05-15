
#Run build runner
build_runner:
	dart run build_runner build
	
#Run in release mode
run_release:
	flutter run --release

#Get Packages
get_package:
	flutter clean && flutter pub get
	
#Install Pods for iOS
install_pods:
	cd ios && pod install
	
#Update Pods for iOS
update_pods:
	cd ios && pod update
	
