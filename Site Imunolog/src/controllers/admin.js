const dashboardModel = require("../models/admin");

module.exports = {
  async kpis(req, res) {
    const { idEmpresa } = req.params;
    try {
      const [resultado] = await dashboardModel.buscarKPIs(idEmpresa);
      res.json(resultado);
    } catch (error) {
      console.error("Erro ao buscar KPIs:", error);
      res.status(500).json({ erro: "Erro ao buscar KPIs" });
    }
  },

  async graficoLinha(req, res) {
    const { idEmpresa } = req.params;
    try {
      const resultado = await dashboardModel.graficoLinha(idEmpresa);
      res.json(resultado);
    } catch (error) {
      console.error("Erro ao buscar gráfico de linha:", error);
      res.status(500).json({ erro: "Erro ao buscar gráfico de linha" });
    }
  },

  async graficoPizza(req, res) {
    const { idEmpresa } = req.params;
    try {
      const resultado = await dashboardModel.graficoPizza(idEmpresa);
      res.json(resultado);
    } catch (error) {
      console.error("Erro ao buscar gráfico de pizza:", error);
      res.status(500).json({ erro: "Erro ao buscar gráfico de pizza" });
    }
  },

  async alertasRecentes(req, res) {
    const { idEmpresa } = req.params;
    try {
      const resultado = await dashboardModel.alertasRecentes(idEmpresa);
      res.json(resultado);
    } catch (error) {
      console.error("Erro ao buscar alertas recentes:", error);
      res.status(500).json({ erro: "Erro ao buscar alertas recentes" });
    }
  }
};
