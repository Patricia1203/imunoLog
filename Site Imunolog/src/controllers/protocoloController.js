var protocoloModel = require("../models/protocoloModel");

function listar(req, res) {
  protocoloModel.listar()
    .then(resultado => res.json(resultado))
    .catch(erro => {
      console.error(erro);
      res.status(500).json({ erro: erro.message });
    });
}

function buscarPorId(req, res) {
  var id = req.params.id;
  protocoloModel.buscarPorId(id)
    .then(resultado => {
      if (resultado.length > 0) res.json(resultado[0]);
      else res.status(404).json({ mensagem: "Protocolo não encontrado" });
    })
    .catch(erro => {
      console.error(erro);
      res.status(500).json({ erro: erro.message });
    });
}

function cadastrar(req, res) {
  const { idTransporte, responsavel, statusProtocolo, cepPartida, cepDestino, dataPartida, dataDestino, ocorrenciaSens } = req.body;

  if (!idTransporte || !responsavel || !statusProtocolo || !cepPartida || !cepDestino || !dataPartida) {
    return res.status(400).json({ mensagem: "Campos obrigatórios faltando" });
  }

  protocoloModel.cadastrar(idTransporte, responsavel, statusProtocolo, cepPartida, cepDestino, dataPartida, dataDestino, ocorrenciaSens)
    .then(resultado => res.status(201).json({ mensagem: "Protocolo cadastrado com sucesso", id: resultado.insertId }))
    .catch(erro => {
      console.error(erro);
      res.status(500).json({ erro: erro.message });
    });
}

function atualizar(req, res) {
  var id = req.params.id;
  var { descricao } = req.body;

  if (!descricao) {
    return res.status(400).json({ mensagem: "Descrição é obrigatória para atualizar" });
  }

  protocoloModel.atualizar(id, descricao)
    .then(() => res.json({ mensagem: "Protocolo atualizado com sucesso" }))
    .catch(erro => {
      console.error(erro);
      res.status(500).json({ erro: erro.message });
    });
}

function deletar(req, res) {
  var id = req.params.id;

  protocoloModel.deletar(id)
    .then(() => res.json({ mensagem: "Protocolo deletado com sucesso" }))
    .catch(erro => {
      console.error(erro);
      res.status(500).json({ erro: erro.message });
    });
}

module.exports = {
  listar,
  buscarPorId,
  cadastrar,
  atualizar,
  deletar,
};
