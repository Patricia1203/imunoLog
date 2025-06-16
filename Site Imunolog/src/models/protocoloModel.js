var database = require("../database/config");

function listar() {
  var instrucaoSql = `SELECT * FROM protocolo`;
  return database.executar(instrucaoSql);
}

function buscarPorId(id) {
  var instrucaoSql = `SELECT * FROM protocolo WHERE idProtocolo = ${id}`;
  return database.executar(instrucaoSql);
}

function cadastrar(
  nomeProtocolo,
  descricao,
  dataCriacao,
  fkEmpresa
) {
  var instrucaoSql = `
    INSERT INTO protocolo (
      nomeProtocolo, descricao, dataCriacao, fkEmpresa
    ) VALUES (
      '${nomeProtocolo}', '${descricao}', '${dataCriacao}', ${fkEmpresa}
    );
  `;
  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}

function atualizar(idProtocolo, nomeProtocolo, descricao) {
  var instrucaoSql = `
    UPDATE protocolo 
    SET nomeProtocolo = '${nomeProtocolo}', descricao = '${descricao}'
    WHERE idProtocolo = ${idProtocolo};
  `;
  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}

function deletar(idProtocolo) {
  var instrucaoSql = `DELETE FROM protocolo WHERE idProtocolo = ${idProtocolo}`;
  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}

module.exports = {
  listar,
  buscarPorId,
  cadastrar,
  atualizar,
  deletar,
};
