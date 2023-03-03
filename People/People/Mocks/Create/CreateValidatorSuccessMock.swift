//
//  CreateValidatorSuccessMock.swift
//  People
//
//  Created by J on 2023-03-02.
//

#if DEBUG
import Foundation

struct CreateValidatorSuccessMock: CreateValidatorImpl {
    
    func validate(_ person: NewPerson) throws {}
}
#endif
