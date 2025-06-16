const db = require('../database/config');

module.exports = {
  async buscarKPIs(fkEmpresa) {
    const [leituras] = await db.executar(`
      SELECT COUNT(*) AS totalLeituras
      FROM leitura l
      JOIN protocolo p ON l.fkProtocolo = p.idProtocolo
      WHERE p.fkEmpresa = ?`, [fkEmpresa]);

    const [protocolosAtivos] = await db.executar(`
      SELECT COUNT(*) AS totalProtocolosAtivos
      FROM protocolo
      WHERE fkEmpresa = ?`, [fkEmpresa]);

    const [sensores] = await db.executar(`
      SELECT COUNT(*) AS totalSensores
      FROM sensor
      WHERE fkEmpresa = ?`, [fkEmpresa]);

    const [media] = await db.executar(`
      SELECT ROUND(AVG(temperatura), 2) AS mediaTemperatura
      FROM leitura l
      JOIN protocolo p ON l.fkProtocolo = p.idProtocolo
      WHERE p.fkEmpresa = ?`, [fkEmpresa]);

    return {
      totalLeituras: leituras.totalLeituras,
      totalProtocolosAtivos: protocolosAtivos.totalProtocolosAtivos,
      totalSensores: sensores.totalSensores,
      mediaTemperatura: media.mediaTemperatura
    };
  },

  async dadosLinhaArduino(fkEmpresa) {
    const result = await db.executar(`
      SELECT l.dataLeitura, l.temperatura
      FROM leitura l
      JOIN protocolo p ON l.fkProtocolo = p.idProtocolo
      WHERE p.fkEmpresa = ?
      ORDER BY l.dataLeitura DESC
      LIMIT 20`, [fkEmpresa]);
    return result.reverse();
  }

};
