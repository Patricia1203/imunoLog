var express = require("express");
var router = express.Router();

var usuarioController = require("../controllers/usuarioController");
var empresaController = require("../controllers/empresaController");

router.post("/cadastrarCompleto", async function (req, res) {
  try {
    const { empresa, usuario } = req.body;

    // Cadastra empresa e pega o ID
    const empresaId = await empresaController.cadastrar(empresa);

    // Cadastra usuário com o id da empresa
    usuario.empresaId = empresaId;
    const usuarioId = await usuarioController.cadastrar(usuario);

    res.status(201).json({
      mensagem: "Empresa e usuário cadastrados com sucesso",
      empresaId,
      usuarioId,
    });
  } catch (error) {
    console.error(error);
    res.status(500).json({ erro: error.message || "Erro no cadastro" });
  }
});

module.exports = router;
