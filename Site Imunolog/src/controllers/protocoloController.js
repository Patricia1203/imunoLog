const TransporteModel = require('../models/TransporteModel');

module.exports = {
  async listar(req, res) {
    const { idEmpresa } = req.params;
    try {
      const [dados] = await TransporteModel.listarPorEmpresa(idEmpresa);
      res.json(dados);
    } catch (error) {
      res.status(500).json({ erro: 'Erro ao listar transportes.' });
    }
  },

  async cadastrar(req, res) {
    const { idTransporte, tipoTransporte, fkEmpresa } = req.body;
    try {
      await TransporteModel.cadastrar(idTransporte, tipoTransporte, fkEmpresa);
      res.status(201).json({ mensagem: 'Transporte cadastrado com sucesso!' });
    } catch (error) {
      res.status(500).json({ erro: 'Erro ao cadastrar transporte.' });
    }
  },

  async detalhes(req, res) {
    const { idTransporte, idEmpresa } = req.params;
    try {
      const [dados] = await TransporteModel.detalhes(idTransporte, idEmpresa);
      res.json(dados);
    } catch (error) {
      res.status(500).json({ erro: 'Erro ao buscar detalhes do transporte.' });
    }
  }
};
