import Foundation
struct PostalCode {

    let codDistrito: String
    let codConcelho: String
    let codLocalidade: String
    let nomeLocalidade: String
    let codArteria: String
    let tipoArteria: String
    let prep1: String
    let tituloArteria: String
    let prep2: String
    let nomeArteria: String
    let localArteria: String
    let troco: String
    let porta: String
    let cliente: String
    let numCodPostal: String
    let extCodPostal: String
    let desigPostal: String
    
    init(data: [String]) {
        codDistrito = data[0]
        codConcelho = data[1]
        codLocalidade = data[2]
        nomeLocalidade = data[3]
        codArteria = data[4]
        tipoArteria = data[5]
        prep1 = data[6]
        tituloArteria = data[7]
        prep2 = data[8]
        nomeArteria = data[9]
        localArteria = data[10]
        troco = data[11]
        porta = data[12]
        cliente = data[13]
        numCodPostal = data[14]
        extCodPostal = data[15]
        desigPostal = data[16]
    }
    
//    enum CodingKeys: String, CodingKey {
//        case codDistrito = "cod_distrito"
//        case codConcelho = "cod_concelho"
//        case codLocalidade = "cod_localidade"
//        case nomeLocalidade = "nome_localidade"
//        case codArteria = "cod_arteria"
//        case tipoArteria = "tipo_arteria"
//        case prep1
//        case tituloArteria = "titulo_arteria"
//        case prep2
//        case nomeArteria = "nome_arteria"
//        case localArteria = "local_arteria"
//        case troco
//        case porta
//        case cliente
//        case numCodPostal = "num_cod_postal"
//        case extCodPostal = "ext_cod_postal"
//        case desigPostal = "desig_postal"
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        codDistrito = try values.decodeIfPresent(String.self, forKey: .codDistrito)
//        codConcelho = try values.decodeIfPresent(String.self, forKey: .codConcelho)
//        codLocalidade = try values.decodeIfPresent(String.self, forKey: .codLocalidade)
//        nomeLocalidade = try values.decodeIfPresent(String.self, forKey: .nomeLocalidade)
//        codArteria = try values.decodeIfPresent(String.self, forKey: .codArteria)
//        tipoArteria = try values.decodeIfPresent(String.self, forKey: .tipoArteria)
//        prep1 = try values.decodeIfPresent(String.self, forKey: .prep1)
//        tituloArteria = try values.decodeIfPresent(String.self, forKey: .tituloArteria)
//        prep2 = try values.decodeIfPresent(String.self, forKey: .prep2)
//        nomeArteria = try values.decodeIfPresent(String.self, forKey: .nomeArteria)
//        localArteria = try values.decodeIfPresent(String.self, forKey: .localArteria)
//        troco = try values.decodeIfPresent(String.self, forKey: .troco)
//        porta = try values.decodeIfPresent(String.self, forKey: .porta)
//        cliente = try values.decodeIfPresent(String.self, forKey: .cliente)
//        numCodPostal = try values.decodeIfPresent(String.self, forKey: .numCodPostal)
//        extCodPostal = try values.decodeIfPresent(String.self, forKey: .extCodPostal)
//        desigPostal = try values.decodeIfPresent(String.self, forKey: .desigPostal)
//    }
}
