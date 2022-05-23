import Foundation

protocol PostalCodeViewModelProtocol {
    var postalCodes: [PostalCode] { get }
    var filteredPostalCodes: [PostalCode] { get }
    func getContacts(completion: @escaping(() -> Void))
    func filterContacts(with text: String, completion: @escaping(() -> Void))
}

final class PostalCodeViewModel: PostalCodeViewModelProtocol {
    private let service: PostalCodeService?
    private let postalCodeUrl: URL? = URL(string: "https://raw.githubusercontent.com/centraldedados/codigos_postais/master/data/codigos_postais.csv")
    var postalCodes: [PostalCode] = [PostalCode]()
    var filteredPostalCodes: [PostalCode] = [PostalCode]()
    
    init(service: PostalCodeService = PostalCodeService()) {
        self.service = service
    }
    
    func getContacts(completion: @escaping(() -> Void)) {
        guard let postalCodeUrl = postalCodeUrl else {
            completion()
            return
        }
        service?.loadFileAsync(url: postalCodeUrl, completion: { [weak self] result in
            switch result {
            case let .success(postalCodes):
                self?.postalCodes = postalCodes
                print("Successfull get postal codes from async file")
                completion()
            case let .failure(error):
                print(error)
                completion()
            }
        })
    }
    
    func filterContacts(with text: String, completion: @escaping(() -> Void)) {
        filteredPostalCodes = postalCodes.filter({ $0.formatedPostalCode.lowercased().contains(text.lowercased()) })
        completion()
    }
}
