import SwiftUI
import Firebase
import TelemetryDeck
import Foundation

@main
struct SE491GroupProjectApp: App {
    @StateObject var viewModel = AuthViewModel()
    @StateObject var globalSearch = GlobalSearch()
    @State private var showSplash = true
    @State private var startTime = Date()
    
    @Environment(\.scenePhase) private var scenePhase // Tracks app's scene phase changes
        
    init() {
        FirebaseApp.configure()
        
        // Functions waiting to detect a crash
        setupCrashHandler()
        checkForCrashes()
        
        // TelemetryDeck Initialization
        let config = TelemetryDeck.Config(appID: "B20FA230-0DA3-4450-9B20-7942D8898359")
        TelemetryDeck.initialize(config: config)
    }
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                if showSplash {
                    SplashScreenView(showSplash: $showSplash)
                } else {
                    ContentView().environmentObject(viewModel)
                }
            }
            .environmentObject(globalSearch)
            .onAppear {
                let launchTime = Date().timeIntervalSince(startTime)
                let launchCategory = categorizeLaunchTime(launchTime)
                TelemetryDeck.signal("App-LaunchTime", parameters: ["durationCategory": launchCategory])
                TelemetryDeck.signal("AppOpened")
                
                // Memory Usage
                let memoryUsage = MemoryFootprint.currentMemoryUsage()
                let memoryCategory = categorizeMemoryUsage(memoryUsage)
                TelemetryDeck.signal("Memory-Usage", parameters: ["memoryUsageCategory": memoryCategory])

                // CPU Usage
                reportCPUUsage()
            }
            .onChange(of: scenePhase) { newPhase in
                switch newPhase {
                case .background, .inactive:
                        // When the app goes to background, calculate the session length
                        let sessionLength = Date().timeIntervalSince(startTime)
                        let category = categorizeSessionLength(sessionLength)
                        TelemetryDeck.signal("SessionLength", parameters: ["length": category])
                        startTime = Date()  // Reset the start time for the next app session
                    case .active:
                        // When the app becomes active, reset the start time
                        startTime = Date()
                    default:
                        break
                }
            }
        }
    }
    
    func setupCrashHandler() {
        NSSetUncaughtExceptionHandler { exception in
            UserDefaults.standard.set(true, forKey: "AppCrashedOnLastRun")
        }
    }

    func checkForCrashes() {
        if UserDefaults.standard.bool(forKey: "AppCrashedOnLastRun") {
            TelemetryDeck.signal("AppCrashDetected")
            UserDefaults.standard.set(false, forKey: "AppCrashedOnLastRun")
        }
    }
    
    struct MemoryFootprint {
        static func currentMemoryUsage() -> UInt64 {
            var taskInfo = mach_task_basic_info()
            var count = mach_msg_type_number_t(MemoryLayout.size(ofValue: taskInfo) / MemoryLayout<mach_msg_type_number_t>.size)
            let kerr: kern_return_t = withUnsafeMutablePointer(to: &taskInfo) {
                $0.withMemoryRebound(to: integer_t.self, capacity: 1) {
                    task_info(mach_task_self_,
                              task_flavor_t(MACH_TASK_BASIC_INFO),
                              $0,
                              &count)
                }
            }

            if kerr == KERN_SUCCESS {
                return taskInfo.resident_size / 1024 / 1024
            } else {
                return 0
            }
        }
    }

    func reportCPUUsage() {
        _ = [Int32](repeating: 0, count: Int(CPU_STATE_MAX))
        var cpuLoadInfo = host_cpu_load_info()
        var count = mach_msg_type_number_t(MemoryLayout<host_cpu_load_info>.stride / MemoryLayout<integer_t>.stride)

        let result = withUnsafeMutablePointer(to: &cpuLoadInfo) {
            $0.withMemoryRebound(to: integer_t.self, capacity: Int(count)) {
                host_statistics(mach_host_self(), HOST_CPU_LOAD_INFO, $0, &count)
            }
        }

        if result == KERN_SUCCESS {
            let totalTicks = cpuLoadInfo.cpu_ticks.0 + cpuLoadInfo.cpu_ticks.1 + cpuLoadInfo.cpu_ticks.2 + cpuLoadInfo.cpu_ticks.3
            let userTicks = cpuLoadInfo.cpu_ticks.0
            let systemTicks = cpuLoadInfo.cpu_ticks.1
            _ = cpuLoadInfo.cpu_ticks.3
            let usage = Float(userTicks + systemTicks) / Float(totalTicks)
            let usageCategory = categorizeCPUUsage(usage)

            TelemetryDeck.signal("CPU-Usage", parameters: ["CPU%": usageCategory])
        } else {
            TelemetryDeck.signal("CPU-Usage", parameters: ["cpuUsage": "Error retrieving CPU data"])
        }
    }
    
    func categorizeSessionLength(_ length: TimeInterval) -> String {
        switch length {
        case 0..<60:
            return "<1 min"
        case 60..<300:
            return "1-5 min"
        case 300..<600:
            return "5-10 min"
        case 600..<1800:
            return "10-30 min"
        case 1800..<3600:
            return "30-60 min"
        default:
            return "60+ min"
        }
    }
    
    func categorizeCPUUsage(_ usage: Float) -> String {
        switch usage {
        case 0..<0.1:
            return "0-10%"
        case 0.1..<0.2:
            return "10-20%"
        case 0.2..<0.4:
            return "20-40%"
        case 0.4..<0.6:
            return "40-60%"
        case 0.6..<0.8:
            return "60-80%"
        case 0.8...1:
            return "80-100%"
        default:
            return "Out of range"
        }
    }
    
    func categorizeMemoryUsage(_ memoryUsageMB: UInt64) -> String {
        switch memoryUsageMB {
        case 0..<50:
            return "<50 MB"
        case 50..<100:
            return "50-100 MB"
        case 100..<150:
            return "100-150 MB"
        case 150..<200:
            return "150-200 MB"
        case 200..<250:
            return "200-250 MB"
        case 250..<300:
            return "250-300 MB"
        default:
            return "300+ MB"
        }
    }
    
    func categorizeLaunchTime(_ time: TimeInterval) -> String {
        switch time {
        case 0..<0.5:
            return "0-0.5 sec"
        case 0.5..<1:
            return "0.5-1 sec"
        case 1..<2:
            return "1-2 sec"
        default:
            return "2+ sec"
        }
    }
}


