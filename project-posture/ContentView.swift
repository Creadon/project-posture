import SwiftUI

struct ContentView: View {
    @EnvironmentObject var sniffer: HeadphoneMotionSniffer

    var body: some View {
        VStack(spacing: 24) {
            Text("Headphone Motion Data")
                .font(.title)
                .fontWeight(.bold)
                .padding(.top, 20)

            HStack(alignment: .top, spacing: 24) {
                // MARK: - Attitude Section
                VStack(alignment: .leading, spacing: 12) {
                    Text("Attitude (radians)")
                        .font(.headline)

                    attitudeRow(label: "Roll", value: sniffer.roll, color: .blue)
                    attitudeRow(label: "Pitch", value: sniffer.pitch, color: .green)
                    attitudeRow(label: "Yaw", value: sniffer.yaw, color: .orange)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(RoundedRectangle(cornerRadius: 12).fill(Color.gray.opacity(0.1)))

                // MARK: - Acceleration Section
                VStack(alignment: .leading, spacing: 12) {
                    Text("User Acceleration (g)")
                        .font(.headline)

                    accelerationRow(label: "X", value: sniffer.accelerationX, color: .purple)
                    accelerationRow(label: "Y", value: sniffer.accelerationY, color: .pink)
                    accelerationRow(label: "Z", value: sniffer.accelerationZ, color: .red)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(RoundedRectangle(cornerRadius: 12).fill(Color.gray.opacity(0.1)))
            }
            .padding(.horizontal)
            .frame(maxWidth: 800)

            Spacer()
        }
        .padding()
    }

    // MARK: - Subviews

    private func attitudeRow(label: String, value: Double, color: Color) -> some View {
        VStack(alignment: .leading) {
            HStack {
                Text("\(label):")
                    .bold()
                Spacer()
                Text(String(format: "%.3f", value))
                    .monospacedDigit()
            }
            Gauge(value: normalizedRadians(value), in: 0...1) {
                Text(label)
            } currentValueLabel: {
                Text(String(format: "%.1f°", value * 180 / .pi))
            }
            .tint(color)
        }
    }

    private func accelerationRow(label: String, value: Double, color: Color) -> some View {
        VStack(alignment: .leading) {
            HStack {
                Text("\(label):")
                    .bold()
                Spacer()
                Text(String(format: "%.3f", value))
                    .monospacedDigit()
            }
            Gauge(value: normalizedAcceleration(value), in: 0...1) {
                Text(label)
            } currentValueLabel: {
                Text(String(format: "%.2f g", value))
            }
            .tint(color)
        }
    }

    // MARK: - Normalization helpers

    /// Converts a radian value (-π to π) to 0–1 range for the gauge
    private func normalizedRadians(_ value: Double) -> Double {
        (value + .pi) / (2 * .pi)
    }

    /// Converts an acceleration value (approx -1g to +1g) to 0–1 range for the gauge
    private func normalizedAcceleration(_ value: Double) -> Double {
        min(max((value + 1) / 2, 0), 1)
    }
}

#Preview {
    ContentView()
        .environmentObject(HeadphoneMotionSniffer())
}
