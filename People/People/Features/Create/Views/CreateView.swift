//
//  CreateView.swift
//  People
//
//  Created by J on 2023-02-23.
//

import SwiftUI

struct CreateView: View {
    
    @Environment(\.dismiss) private var dismiss
    @FocusState private var focusedField: Field?
    @StateObject private var vm: CreateViewModel
    
    private let successfulAction: () -> Void
    
    init(successfulAction: @escaping () -> Void) {
        self.successfulAction = successfulAction
        
#if DEBUG
        
        if UITestingHelper.isUITesting {
            
            let mock: NetworkingManagerImpl = UITestingHelper.isCreateNetworkingSuccessful ? NetworkingManagerCreateSuccessMock() : NetworkingManagerCreateFailureMock()
            _vm = StateObject(wrappedValue: CreateViewModel(networkingManager: mock))
            
        } else {
            _vm = StateObject(wrappedValue: CreateViewModel())
        }
        
#else
        _vm = StateObject(wrappedValue: CreateViewModel())
#endif
    }
    
    
    var body: some View {
        Form {
            Section {
                firstName
                lastName
                job
            } footer: {
                if case .validation(let error) = vm.error,
                   let errorDesc = error.errorDescription {
                    Text(errorDesc)
                        .foregroundColor(.red)
                }
            }
            Section {
                submit
            }
        }
        .disabled(vm.state == .submitting)
        .navigationTitle("Create")
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                done
            }
        }
        .onChange(of: vm.state) { formState in
            if formState == .successful {
                dismiss()
                successfulAction()
            }
        }
        .alert(isPresented: $vm.hasError,
               error: vm.error) {
        }
               .overlay {
                   if vm.state == .submitting {
                       ProgressView()
                   }
               }
               .embedInNavigation()
    }
}

extension CreateView {
    enum Field: Hashable {
        case firstName
        case lastName
        case job
    }
}

struct CreateView_Previews: PreviewProvider {
    static var previews: some View {
        CreateView {}
    }
}

private extension CreateView {
    
    var firstName: some View {
        TextField("First Name", text: $vm.person.firstName)
            .focused($focusedField, equals: .firstName)
    }
    
    var lastName: some View {
        TextField("Last Name", text: $vm.person.lastName)
            .focused($focusedField, equals: .lastName)
    }
    
    var job: some View {
        TextField("Job", text: $vm.person.job)
            .focused($focusedField, equals: .job)
    }
    
    var submit: some View {
        Button("Submit") {
            focusedField = nil
            Task {
                await vm.create()
            }
        }
    }
    
    var done: some View {
        Button("Done") {
            dismiss()
        }
    }
    
}
