const Dashboard = require('../models/dashboardModel');

module.exports = {
  async kpis(req, res) {
    const { empresaId } = req.params;
    try {
      const dados = await Dashboard.buscarKPIs(empresaId);
      res.json(dados);
    } catch (erro) {
      console.error('Erro ao buscar KPIs:', erro);
      res.status(500).send('Erro ao buscar KPIs');
    }
  },

  async graficoLinhaArduino(req, res) {
    const { empresaId } = req.params;
    try {
      const dados = await Dashboard.dadosLinhaArduino(empresaId);
      res.json(dados);
    } catch (erro) {
      console.error('Erro ao buscar dados do Arduino:', erro);
      res.status(500).send('Erro ao buscar gráfico de linha');
    }
  }
  
};
