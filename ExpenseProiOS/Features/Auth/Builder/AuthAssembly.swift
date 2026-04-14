import Foundation
import Swinject

enum AuthAssembly {
    static func assemble(container: Container) {
        container.register(AuthSession.self) { _ in AuthSession() }
            .inObjectScope(.container)

        container.register(AuthDataSource.self) { r in
            AuthRemoteDataSource(provider: r.resolve(SupabaseProvider.self)!)
        }

        container.register(AuthRepository.self) { r in
            AuthRepositoryImpl(
                remote: r.resolve(AuthDataSource.self)!,
                session: r.resolve(AuthSession.self)!
            )
        }

        container.register(SendOTPUseCase.self) { r in
            SendOTPUseCase(repository: r.resolve(AuthRepository.self)!)
        }
        container.register(VerifyOTPUseCase.self) { r in
            VerifyOTPUseCase(repository: r.resolve(AuthRepository.self)!)
        }
        container.register(LogoutUseCase.self) { r in
            LogoutUseCase(repository: r.resolve(AuthRepository.self)!)
        }
    }
}
