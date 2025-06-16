const db = require('../database/config');

const Transporte = {
  listarPorEmpresa: async (idEmpresa) => {
    const [rows] = await db.execute('SELECT * FROM transporte WHERE fkEmpresa = ?', [idEmpresa]);
    return rows;
  },

  inserir: async (idTransporte, tipoTransporte, fkEmpresa) => {
    const [result] = await db.execute(
      'INSERT INTO transporte (idTransporte, tipoTransporte, fkEmpresa) VALUES (?, ?, ?)',
      [idTransporte, tipoTransporte, fkEmpresa]
    );
    return result;
  }
};

module.exports = Transporte;
