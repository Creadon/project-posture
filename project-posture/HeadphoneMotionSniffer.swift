import Foundation
import CoreMotion
import Combine


/// A simple class that listens to motion updates from AirPods (or any headphone device supporting motion data).
final class HeadphoneMotionSniffer: ObservableObject {
    private let motionManager = CMHeadphoneMotionManager()
    private var isListening = false
    
    @Published var roll: Double = 0
    @Published var pitch: Double = 0
    @Published var yaw: Double = 0

    /// Starts listening for motion updates from connected AirPods.
    func startSniffing() {
        guard motionManager.isDeviceMotionAvailable else {
            print("Headphone motion data is not available on this device.")
            return
        }

        guard !isListening else {
            print("Already listening for motion updates.")
            return
        }

        isListening = true
        
        motionManager.startDeviceMotionUpdates(to: .main) { [weak self] motion, error in
            if let error = error {
                print("Error receiving motion data: \(error.localizedDescription)")
                return
            }
            
            guard let self = self, let motion = motion else { return }

            self.roll = motion.attitude.roll
            self.pitch = motion.attitude.pitch
            self.yaw = motion.attitude.yaw
            
            print("""
            Attitude:
              Roll: \(motion.attitude.roll)
              Pitch: \(motion.attitude.pitch)
              Yaw: \(motion.attitude.yaw)
            Gravity: \(motion.gravity)
            Rotation Rate: \(motion.rotationRate)
            """)
        }
    }

    /// Stops listening for motion updates.
    func stopSniffing() {
        guard isListening else { return }
        motionManager.stopDeviceMotionUpdates()
        isListening = false
    }
}
