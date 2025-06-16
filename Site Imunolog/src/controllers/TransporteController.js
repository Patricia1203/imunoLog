const Transporte = require('../models/Transporte');

// src/controllers/TransporteController.js

const TransporteController = {
  async listar(req, res) {
    try {
      const idEmpresa = req.params.idEmpresa;
      const transportes = await TransporteModel.buscarPorEmpresa(idEmpresa);
      // transporteModel deve retornar um array
      res.json(transportes);
    } catch (error) {
      res.status(500).json({ erro: 'Erro ao buscar transportes.' });
    }
  },

  cadastrar: (req, res) => {
    const { responsavel, cepOrigem, cepDestino, dataSaida } = req.body;
    res.json({ mensagem: "Transporte cadastrado com sucesso", dados: req.body });
  },

  detalhes: (req, res) => {
    const { idTransporte, idEmpresa } = req.params;
    res.json({ mensagem: "Detalhes do transporte", idTransporte, idEmpresa });
  }
};

module.exports = TransporteController;


