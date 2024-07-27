# Photo EXIF Viewer

Photo EXIF Viewer is an iOS application that allows users to upload photos and display their EXIF information along with the camera brand logo beneath the photo. The photo is scaled to fit the screen while maintaining its original resolution.

## Features

- Upload photos from your device
- Automatically extract and display EXIF information
- Display camera brand logo below the photo
- Scale photo to fit screen size while maintaining original resolution

## Screenshots

![Demo](demo/ScreenRecording_07-28-2024%2001-37-47_1.gif)
![ScreenShot](demo/IMG_1524.PNG)

## Installation

1. Clone the repository:
    ```bash
    git clone https://github.com/s1031432/photo-exif-viewer.git
    ```
2. Open the project in Xcode:
    ```bash
    cd photo-exif-viewer
    open PhotoExifViewer.xcodeproj
    ```
3. Build and run the project on your iOS device or simulator.

## Usage

1. Open the app on your iOS device.
2. Tap the upload button to select a photo from your device.
3. The photo will be displayed on the screen, scaled to fit the screen size.
4. EXIF information and the camera brand logo will be displayed below the photo.

## EXIF Information

The following EXIF information is displayed:
- Aperture
- Shutter Speed
- ISO
- Camera Body Model
- Lens Model
- Focal Length

## Camera Brand Logos

Supported camera brands include:
- Canon
- Apple
- Nikon
- Sony
- Fujifilm
- Leica


## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a pull request