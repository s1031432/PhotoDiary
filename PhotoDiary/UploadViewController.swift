//
//  UploadViewController.swift
//  PhotoDiary
//
//  Created by 黃翊唐 on 2024/7/26.
//

import UIKit
import Photos

class UploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var photos: [Photo] = []
    var imageView: UIImageView!
    var uploadButton: UIButton!
    var infoView: UIView!
    var originalImage: UIImage?
    var brandImageView = UIImageView()
    var capturedWithLabel = UILabel()
    var cameraModelLabel = UILabel()
    var shootingParamsLabel = UILabel()
    var lensModelLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    func setupUI() {
        // 創建 imageView
        imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        imageView.addGestureRecognizer(tapGesture)
        view.addSubview(imageView)

        // 創建上傳按鈕
        uploadButton = UIButton(type: .system)
        uploadButton.setTitle("選擇照片", for: .normal)
        uploadButton.titleLabel!.font = UIFont(name: "Exo2-Regular", size: 14)
        uploadButton.addTarget(self, action: #selector(uploadButtonTapped), for: .touchUpInside)
        uploadButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(uploadButton)

        let darkBlueColor = UIColor(red: 0.1, green: 0.2, blue: 0.3, alpha: 1.0) // 深藍色
        uploadButton.backgroundColor = darkBlueColor
        uploadButton.setTitleColor(.white, for: .normal)
        uploadButton.layer.cornerRadius = 10 // 圓角
        uploadButton.layer.borderWidth = 1
        uploadButton.layer.borderColor = UIColor.tintColor.cgColor // 白色邊框

        // 設置 infoView
        infoView = UIView()
        infoView.translatesAutoresizingMaskIntoConstraints = false
        infoView.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        view.addSubview(infoView)

        // 創建並設置品牌圖片
        brandImageView.image = UIImage(named: "canon")
        brandImageView.contentMode = .scaleAspectFit
        brandImageView.translatesAutoresizingMaskIntoConstraints = false
        infoView.addSubview(brandImageView)

        // 創建並設置標籤
        capturedWithLabel.text = "CAPTURED WITH"
        capturedWithLabel.textColor = UIColor.black
        capturedWithLabel.font = UIFont(name: "Exo2-Regular", size: 11)
        capturedWithLabel.translatesAutoresizingMaskIntoConstraints = false
        infoView.addSubview(capturedWithLabel)
        
        cameraModelLabel.textColor = UIColor.black
        cameraModelLabel.font = UIFont(name: "Exo2-Bold", size: 11)
        cameraModelLabel.translatesAutoresizingMaskIntoConstraints = false
        infoView.addSubview(cameraModelLabel)

        shootingParamsLabel.textColor = UIColor.black
        shootingParamsLabel.font = UIFont(name: "Exo2-Regular", size: 11)
        shootingParamsLabel.textAlignment = .right
        shootingParamsLabel.translatesAutoresizingMaskIntoConstraints = false
        infoView.addSubview(shootingParamsLabel)

        lensModelLabel.textColor = UIColor.black
        lensModelLabel.font = UIFont(name: "Exo2-Bold", size: 11)
        lensModelLabel.textAlignment = .right
        lensModelLabel.translatesAutoresizingMaskIntoConstraints = false
        infoView.addSubview(lensModelLabel)
        
        infoView.isHidden = true
        
        // set layout
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

//            uploadButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
//            uploadButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            uploadButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            uploadButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            uploadButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            uploadButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            uploadButton.heightAnchor.constraint(equalToConstant: 50),
            
            infoView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            infoView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            infoView.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            infoView.heightAnchor.constraint(equalToConstant: 40),  // 可以根據需要調整高度

            brandImageView.leadingAnchor.constraint(equalTo: infoView.leadingAnchor, constant: 8),
            brandImageView.centerYAnchor.constraint(equalTo: infoView.centerYAnchor),
            brandImageView.widthAnchor.constraint(equalToConstant: 36),
            brandImageView.heightAnchor.constraint(equalToConstant: 36),

            capturedWithLabel.leadingAnchor.constraint(equalTo: brandImageView.trailingAnchor, constant: 8),
            capturedWithLabel.bottomAnchor.constraint(equalTo: infoView.centerYAnchor, constant: -2),

            cameraModelLabel.leadingAnchor.constraint(equalTo: capturedWithLabel.leadingAnchor),
            cameraModelLabel.topAnchor.constraint(equalTo: infoView.centerYAnchor, constant: 2),

            shootingParamsLabel.trailingAnchor.constraint(equalTo: infoView.trailingAnchor, constant: -8),
            shootingParamsLabel.bottomAnchor.constraint(equalTo: infoView.centerYAnchor, constant: -2),

            lensModelLabel.trailingAnchor.constraint(equalTo: infoView.trailingAnchor, constant: -8),
            lensModelLabel.topAnchor.constraint(equalTo: infoView.centerYAnchor, constant: 2)
        ])
    }

    @objc func uploadButtonTapped() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            originalImage = selectedImage
            let resizedImage = resizeImage(selectedImage)
            imageView.image = resizedImage
            updateImageViewConstraints(for: resizedImage)
            updateInfoView(for: selectedImage, info: info)
            infoView.isHidden = false
        }
        dismiss(animated: true, completion: nil)
    }
    func updateInfoView(for image: UIImage, info: [UIImagePickerController.InfoKey : Any]) {
        if let url = info[.imageURL] as? URL {
            if let photo = extractExifInfo(for: url, image: image) {
                updateBrandImageView(brandName: photo.make)
                cameraModelLabel.text = photo.cameraModel
                lensModelLabel.text = photo.lensModel
                shootingParamsLabel.text = "\(photo.focalLength)MM   F \(photo.fNumber)   S \(convertDecimalToFraction(photo.exposureTime))   ISO \(photo.iso)"
                
                // set style of string
                let attributedString = NSMutableAttributedString(string: shootingParamsLabel.text!)
                let grayColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1)
                let fTextRange = NSRange(location: String(photo.focalLength).count+5, length: 1)
                let sTextRange = NSRange(location: String(photo.focalLength).count+String(photo.fNumber).count+10, length: 1)
                let isoRange = NSRange(location: String(photo.focalLength).count+String(photo.fNumber).count+convertDecimalToFraction(photo.exposureTime).count+15, length: 3)
                attributedString.addAttribute(.foregroundColor, value: grayColor, range: fTextRange)
                attributedString.addAttribute(.foregroundColor, value: grayColor, range: sTextRange)
                attributedString.addAttribute(.foregroundColor, value: grayColor, range: isoRange)
                shootingParamsLabel.attributedText = attributedString
            }
        }
    }
    func updateBrandImageView(brandName: String) {
        switch brandName.lowercased() {
        case "canon":
            brandImageView.image = UIImage(named: "canon")
        case "apple":
            brandImageView.image = UIImage(named: "apple")
        case "sony":
            brandImageView.image = UIImage(named: "sony")
        case "nikon":
            brandImageView.image = UIImage(named: "nikon")
        case "leica":
            brandImageView.image = UIImage(named: "leica")
        case "fujifilm":
            brandImageView.image = UIImage(named: "fuji")
        default:
            brandImageView.image = UIImage(named: "unknown")
        }
    }
    func resizeImage(_ image: UIImage) -> UIImage {
        let isLandscape = image.size.width > image.size.height
        let targetSize: CGSize

        if isLandscape {
            let aspectRatio = image.size.height / image.size.width
            targetSize = CGSize(width: 2048, height: 2048 * aspectRatio)
        } else {
            let aspectRatio = image.size.width / image.size.height
            targetSize = CGSize(width: 1365 * aspectRatio, height: 1365)
        }
        let renderer = UIGraphicsImageRenderer(size: targetSize)
        return renderer.image { _ in
            image.draw(in: CGRect(origin: .zero, size: targetSize))
        }
    }

    func updateImageViewConstraints(for image: UIImage) {
        let aspectRatio = image.size.width / image.size.height
        let screenWidth = view.bounds.width - 32

        NSLayoutConstraint.deactivate(imageView.constraints)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            imageView.widthAnchor.constraint(equalToConstant: screenWidth),
            imageView.heightAnchor.constraint(equalToConstant: screenWidth / aspectRatio)
        ])
    }
    func extractExifInfo(for url: URL, image: UIImage) -> Photo? {
        let fileURL = url
        if let imageSource = CGImageSourceCreateWithURL(fileURL as CFURL, nil),
           let imageProperties = CGImageSourceCopyPropertiesAtIndex(imageSource, 0, nil) as? [String: Any] {
            var photo = Photo(image: image, make: "", cameraModel: "", lensModel: "", fNumber: 0.0, exposureTime: 0.0, focalLength: 0, iso: 0, dateTime: "", timeOffset: "")
            if let tiff = imageProperties["{TIFF}"] as? [String: Any] {
                photo.make = tiff["Make"] as? String ?? ""
                photo.cameraModel = tiff["Model"] as? String ?? "???"
            }
            if let exif = imageProperties["{Exif}"] as? [String: Any] {
                photo.lensModel = exif["LensModel"] as? String ?? "???"
                photo.focalLength = exif["FocalLength"] as? Int ?? 0
                photo.fNumber = exif["FNumber"] as? Double ?? 0.0
                photo.exposureTime = exif["ExposureTime"] as? Double ?? 0.0
                photo.iso = (exif["ISOSpeedRatings"] as? [Int])?.first ?? 0
                photo.dateTime = exif["DateTimeOriginal"] as? String ?? ""
                photo.timeOffset = exif["OffsetTimeOriginal"] as? String ?? ""
            } else {
                print("Could not find '{Exif}' dictionary or it is not the expected type.")
            }
            print(photo)
            return photo
        }
        return nil
    }
    
    @objc func imageTapped() {
        guard let originalImage = self.originalImage else {
            print("No original image available")
            return
        }
        let infoViewSize = infoView.frame.width
        let scale = originalImage.size.width / infoViewSize
        let size = CGSize(width: originalImage.size.width, height: originalImage.size.height + infoView.bounds.height*scale)
        let format = UIGraphicsImageRendererFormat()
        format.scale = 1.0
        let renderer = UIGraphicsImageRenderer(size: size, format: format)
        // make final image that will be saved to user's album
        let finalImage = renderer.image { ctx in
            originalImage.draw(in: CGRect(origin: .zero, size: originalImage.size))
            ctx.cgContext.saveGState()
            ctx.cgContext.translateBy(x: 0, y: originalImage.size.height)
            ctx.cgContext.scaleBy(x: scale, y: scale)
            infoView.layer.render(in: ctx.cgContext)
            ctx.cgContext.restoreGState()
        }
        saveImageToAlbum(finalImage)
    }
    func saveImageToAlbum(_ finalImage: UIImage){
        // check permission and save image
        PHPhotoLibrary.requestAuthorization { status in
            guard status == .authorized else {
                DispatchQueue.main.async {
                    self.showAlert(title: "無法存取相簿", message: "請在設定中允許此應用存取您的相簿。")
                }
                return
            }
            PHPhotoLibrary.shared().performChanges({
                let request = PHAssetCreationRequest.forAsset()
                request.addResource(with: .photo, data: finalImage.jpegData(compressionQuality: 1.0)!, options: nil)
            }) { success, error in
                DispatchQueue.main.async {
                    if success {
                        self.showAlert(title: "儲存成功", message: "圖片已儲存至相簿")
                    } else {
                        self.showAlert(title: "儲存失敗", message: error?.localizedDescription ?? "未知錯誤")
                    }
                }
            }
        }
    }
    func convertDecimalToFraction(_ decimal: Double) -> String {
        // handle decimal
        var fraction = NSDecimalNumber(value: decimal)
        var denominator = 1
        while fraction != fraction.rounding(accordingToBehavior: nil) {
            fraction = fraction.multiplying(by: NSDecimalNumber(value: 10))
            denominator *= 10
        }
        // usd GCD to handle fraction
        let gcdValue = gcd(Int(fraction.intValue), denominator)
        let numerator = Int(fraction.intValue) / gcdValue
        let simplifiedDenominator = denominator / gcdValue
        
        if simplifiedDenominator == 1 {
            return "\(numerator)"
        }
        return "\(numerator)/\(simplifiedDenominator)"
    }
    func gcd(_ a: Int, _ b: Int) -> Int {
        if b == 0 {
            return a
        }
        return gcd(b, a % b)
    }
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "確定", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
