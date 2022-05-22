import Foundation

protocol PostalCodeViewModelProtocol {
    var postalCodes: [PostalCode] { get }
    func getContacts()
}

final class PostalCodeViewModel: PostalCodeViewModelProtocol {
    private let service: PostalCodeService?
    private let postalCodeUrl: URL? = URL(string: "https://raw.githubusercontent.com/centraldedados/codigos_postais/master/data/codigos_postais.csv")
    var postalCodes: [PostalCode] = [PostalCode]()
    
    init(service: PostalCodeService = PostalCodeService()) {
        self.service = service
    }
    
    func getContacts() {
        guard let postalCodeUrl = postalCodeUrl else {
            return
        }
        service?.loadFileSync(url: postalCodeUrl, completion: { [weak self] result in
            switch result {
            case let .success(postalCodes):
                self?.postalCodes = postalCodes
            case .failure:
                self?.loadContactsAsync(with: postalCodeUrl)
            }
        })
    }
    
    private func loadContactsAsync(with url: URL) {
        self.service?.loadFileAsync(url: url, completion: { [weak self] result in
            switch result {
            case let .success(postalCodes):
                self?.postalCodes = postalCodes
            case let .failure(error):
                print(error)
            }
        })
    }
}
