//
//  File.swift
//  
//
//  Created by Samlo Berutu on 11/12/21.
//

import Foundation
import Combine
import Core
public class ModuleDetailPresenter<Request, Response, Interactor: CoreUseCase>: ObservableObject where Interactor.Request == Request, Interactor.Response == Response {
    
    private var cancellables: Set<AnyCancellable> = []
    
    private let _useCase: Interactor
    
    @Published public var detail: Response
    @Published public var errorMessage: String = ""
    @Published public var isLoading: Bool = false
    @Published public var isError: Bool = false
    @Published public var isComplete: Bool = false
    public init(detail: Response, useCase: Interactor) {
        self.detail = detail
        self._useCase = useCase
    }
    public func getList(request: Request?) {
        isLoading = true
        _useCase.execute(request: request)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    self.isError = true
                    self.isLoading = false
                case .finished:
                    self.isComplete = true
                    self.isLoading = false
                }
            }, receiveValue: { detail in
                self.detail = detail
            })
            .store(in: &cancellables)
    }
}
