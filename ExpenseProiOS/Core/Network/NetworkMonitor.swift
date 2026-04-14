import Foundation
import Network
import Combine

// Flutter `NetworkInfo` ekvivalenti.

protocol NetworkMonitorProtocol {
    var isConnected: Bool { get }
    var isConnectedPublisher: AnyPublisher<Bool, Never> { get }
}

final class NetworkMonitor: NetworkMonitorProtocol {
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "com.expensepro.network")
    private let subject = CurrentValueSubject<Bool, Never>(true)

    var isConnected: Bool { subject.value }
    var isConnectedPublisher: AnyPublisher<Bool, Never> {
        subject.removeDuplicates().eraseToAnyPublisher()
    }

    init() {
        monitor.pathUpdateHandler = { [weak self] path in
            self?.subject.send(path.status == .satisfied)
        }
        monitor.start(queue: queue)
    }

    deinit { monitor.cancel() }
}
