//
//  File.swift
//  
//
//  Created by Done Santana on 9/11/24.
//

import AVFoundation
import UIKit
import Photos

class CameraDelegate: NSObject, AVCapturePhotoCaptureDelegate {
 
   private let completion: (UIImage?) -> Void
 
   init(completion: @escaping (UIImage?) -> Void) {
      self.completion = completion
   }
 
   func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
      if let error {
         print("CameraManager: Error while capturing photo: \(error)")
         completion(nil)
         return
      }
  
      if let imageData = photo.fileDataRepresentation(), let capturedImage = UIImage(data: imageData) {
         //saveImageToGallery(capturedImage)
         completion(capturedImage)
      } else {
         print("CameraManager: Image not fetched.")
      }
   }
 
   func saveImageToGallery(_ image: UIImage) {
      PHPhotoLibrary.shared().performChanges {
         PHAssetChangeRequest.creationRequestForAsset(from: image)
      } completionHandler: { success, error in
         if success {
           print("Image saved to gallery.")
         } else if let error {
           print("Error saving image to gallery: \(error)")
         }
      }
   }
}
