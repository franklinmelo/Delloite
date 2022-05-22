import Foundation

enum ServiceError: Error {
    case saveError
    case loadLocalFileError
    case requestError
    case noDataError
}

struct PostalCodeService {    
    func loadFileSync(url: URL, completion: @escaping (Result<[PostalCode], ServiceError>) -> Void) {
        guard let documentsUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let destinationUrl = documentsUrl.appendingPathComponent(url.lastPathComponent)
        
        if FileManager().fileExists(atPath: destinationUrl.path) {
            print("File already exists")
            completion(.success(convertCVSToPostalCode(filePath: destinationUrl.path)))
        }
        else {
            print("File not exists")
            completion(.failure(.loadLocalFileError))
        }
    }
    
    func loadFileAsync(url: URL, completion: @escaping (Result<[PostalCode], ServiceError>) -> Void) {
        guard let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let destinationUrl = documentsUrl.appendingPathComponent(url.lastPathComponent)
        
        if FileManager().fileExists(atPath: destinationUrl.path) {
            print("File already exists")
            completion(.success(convertCVSToPostalCode(filePath: destinationUrl.path)))
        }
        else {
            let session = URLSession(configuration: URLSessionConfiguration.default)
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            let task = session.dataTask(with: request, completionHandler: { data, _, error in
                if error != nil {
                    completion(.failure(.requestError))
                    return
                }
                
                if let data = data {
                    do {
                        try data.write(to: destinationUrl, options: Data.WritingOptions.atomic)
                        print("File saved")
                        completion(.success(convertCVSToPostalCode(filePath: destinationUrl.path)))
                    } catch {
                        completion(.failure(.saveError))
                    }
                }
                else {
                    completion(.failure(.noDataError))
                }
            })
            task.resume()
        }
    }
    
    private func convertCVSToPostalCode(filePath: String) -> [PostalCode] {
        var postalCodes = [PostalCode]()
        let urlValid = URL(fileURLWithPath: filePath)
        var data = ""
        
        do {
            data = try String(contentsOf: urlValid)
        } catch {
            print(error)
            return []
        }
        
        var rows = data.components(separatedBy: "\n")
        rows.removeFirst()
        rows.forEach {
            let csvColumns = $0.components(separatedBy: ",")
            if csvColumns.count == 17 {
                let postalCode = PostalCode(data: csvColumns)
                postalCodes.append(postalCode)
            }
        }
        
        return postalCodes
    }
}
