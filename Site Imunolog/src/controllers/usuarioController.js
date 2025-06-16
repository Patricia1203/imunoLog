var usuarioModel = require("../models/usuarioModel");

const adminEmails = [
    "julia.visconti@sptech.school",
    "bryan.silva@sptech.school",
    "dandara.ramos@sptech.school",
    "davi.caproni@sptech.school",
    "patricia.borges@sptech.school"
];
const senhaPadraoAdmin = "admin123";

function autenticar(req, res) {
    var email = req.body.emailServer;
    var senha = req.body.senhaServer;

    if (email == undefined) {
        res.status(400).send("Seu email está undefined!");
        return;
    }
    if (senha == undefined) {
        res.status(400).send("Sua senha está indefinida!");
        return;
    }

    // Verifica se é admin (hardcoded)
    if (adminEmails.includes(email) && senha === senhaPadraoAdmin) {
        // Responde direto, sem ir no banco
        return res.json({
            idUsuario: 0,  // id fictício
            nome: "Administrador",
            email: email,
            fkEmpresa: null,
            admin: true
        });
    }

    // Se não for admin, busca no banco
    usuarioModel.autenticar(email, senha)
        .then(function (resultadoAutenticar) {
            console.log(`\nResultados encontrados: ${resultadoAutenticar.length}`);
            console.log(`Resultados: ${JSON.stringify(resultadoAutenticar)}`);

            if (resultadoAutenticar.length == 1) {
                res.json({
                    idUsuario: resultadoAutenticar[0].idUsuario,
                    email: resultadoAutenticar[0].email,
                    nome: resultadoAutenticar[0].nome,
                    fkEmpresa: resultadoAutenticar[0].idEmpresa
                });
            } else if (resultadoAutenticar.length == 0) {
                res.status(403).send("Email e/ou senha inválido(s)");
            } else {
                res.status(403).send("Mais de um usuário com o mesmo login e senha!");
            }
        })
        .catch(function (erro) {
            console.log(erro);
            console.log("\nHouve um erro ao realizar o login! Erro: ", erro.sqlMessage);
            res.status(500).json(erro.sqlMessage);
        });
}

async function cadastrar(usuarioData) {
    const { nome, email, senha, telefone1, telefone2, empresaId } = usuarioData;

    if (!nome) throw new Error("Nome está undefined");
    if (!email) throw new Error("Email está undefined");
    if (!senha) throw new Error("Senha está undefined");
    if (!empresaId) throw new Error("Empresa para vincular está undefined");

    const resultado = await usuarioModel.cadastrar(
      nome,
      email,
      senha,
      telefone1,
      telefone2,
      empresaId
    );

    return resultado.insertId || resultado.id || null;
}

module.exports = {
    autenticar,
    cadastrar,
};
