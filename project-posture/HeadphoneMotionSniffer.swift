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
    
    @Published var accelerationX: Double = 0
    @Published var accelerationY: Double = 0
    @Published var accelerationZ: Double = 0

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
            
            self.accelerationX = motion.userAcceleration.x
            self.accelerationY = motion.userAcceleration.y
            self.accelerationZ = motion.userAcceleration.z
            
            print("""
Attitude:
    Roll:  \(String(format: "%.3f", motion.attitude.roll))
    Pitch: \(String(format: "%.3f", motion.attitude.pitch))
    Yaw:   \(String(format: "%.3f", motion.attitude.yaw))
Gravity:
    X:     \(String(format: "%.3f", motion.gravity.x))
    Y:     \(String(format: "%.3f", motion.gravity.y))
    Z:     \(String(format: "%.3f", motion.gravity.z))
UserAcceleration:
    X:     \(String(format: "%.3f", motion.userAcceleration.x))
    Y:     \(String(format: "%.3f", motion.userAcceleration.y))
    Z:     \(String(format: "%.3f", motion.userAcceleration.z))
Sensor Location: \(motion.sensorLocation.rawValue == 1 ? "Left" : "Right")

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
