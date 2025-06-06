var database = require("../database/config");

function listar() {
  var instrucaoSql = `SELECT * FROM protocolo;`;
  return database.executar(instrucaoSql);
}

function buscarPorId(id) {
  var instrucaoSql = `SELECT * FROM protocolo WHERE id = ${id};`;
  return database.executar(instrucaoSql);
}

function cadastrar(idTransporte, responsavel, statusProtocolo, cepPartida, cepDestino, dataPartida, dataDestino, ocorrenciaSens) {
  var instrucaoSql = `
    INSERT INTO protocolo 
      (idTransporte, responsavel, statusProtocolo, cepPartida, cepDestino, dataPartida, dataDestino, ocorrenciaSens)
    VALUES 
      (${idTransporte}, '${responsavel}', '${statusProtocolo}', '${cepPartida}', '${cepDestino}', '${dataPartida}', ${dataDestino ? `'${dataDestino}'` : null}, '${ocorrenciaSens}');
  `;
  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}

function atualizar(id, descricao) {
  var instrucaoSql = `
    UPDATE protocolo SET descricao = '${descricao}' WHERE id = ${id};
  `;
  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}

function deletar(id) {
  var instrucaoSql = `DELETE FROM protocolo WHERE id = ${id};`;
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
