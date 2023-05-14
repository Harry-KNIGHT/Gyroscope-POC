//
//  ContentView.swift
//  GyroscopePoc
//
//  Created by Elliot Knight on 14/05/2023.
//

import SwiftUI
import CoreMotion

struct ContentView: View {
	@State private var x: Double = 0
	@State private var y: Double = 0

	let motion = CMMotionManager()

	let timer = Timer.publish(every: 0.2, on: .main, in: .common).autoconnect()

	var body: some View {
		VStack {
			Text("Hello, World!")
				.offset(x: x * 200, y: y * 200)
		}
		.onAppear(perform: {
			motion.startGyroUpdates()
		})
		.onReceive(timer, perform: { _ in
			withAnimation {
				if let data = motion.gyroData {
					self.x = data.rotationRate.x
					self.y = data.rotationRate.y
				} else {
					print("--- NO GYRO DATA ---")
				}
			}
		})
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
