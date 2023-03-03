//
//  CreateValidatorFailureMock.swift
//  People
//
//  Created by J on 2023-03-02.
//

#if DEBUG
import Foundation

struct CreateValidatorFailureMock: CreateValidatorImpl {
    
    func validate(_ person: NewPerson) throws {
        throw CreateValidator.CreateValidatorError.invalidFirstName
    }
}
#endif
