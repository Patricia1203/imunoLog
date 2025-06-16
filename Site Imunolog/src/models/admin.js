const db = require("../database/config");

module.exports = {
  buscarKPIs: (idEmpresa) => {
    const query = `
      SELECT 
        (SELECT COUNT(*) FROM usuario WHERE fkEmpresa = ?) AS totalUsuarios,
        (SELECT COUNT(*) FROM transporte WHERE fkEmpresa = ?) AS totalTransportes,
        (SELECT COUNT(*) FROM protocolo WHERE status = 'Alerta' AND fkEmpresa = ?) AS totalAlertas
    `;
    return db.query(query, [idEmpresa, idEmpresa, idEmpresa]);
  },

  graficoLinha: (idEmpresa) => {
    const query = `
      SELECT DATE_FORMAT(dataLeitura, '%Y-%m-%d') AS data, AVG(temperatura) AS temperatura
      FROM leitura
      WHERE fkEmpresa = ?
      GROUP BY DATE(dataLeitura)
      ORDER BY dataLeitura DESC
      LIMIT 7;
    `;
    return db.query(query, [idEmpresa]);
  },

  graficoPizza: (idEmpresa) => {
    const query = `
      SELECT status, COUNT(*) AS total 
      FROM transporte 
      WHERE fkEmpresa = ?
      GROUP BY status;
    `;
    return db.query(query, [idEmpresa]);
  },

  alertasRecentes: (idEmpresa) => {
    const query = `
      SELECT protocolo.idProtocolo, protocolo.descricao, DATE_FORMAT(protocolo.dataInicio, '%d/%m/%Y') AS data
      FROM protocolo
      WHERE protocolo.status = 'Alerta' AND protocolo.fkEmpresa = ?
      ORDER BY protocolo.dataInicio DESC
      LIMIT 5;
    `;
    return db.query(query, [idEmpresa]);
  }
};
