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
    let formatedPostalCode: String
    
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
        formatedPostalCode = numCodPostal + "-" + extCodPostal + " " + desigPostal
    }
}
