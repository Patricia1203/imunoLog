var database = require("../database/config");

function buscarPorId(id) {
  var instrucaoSql = `SELECT * FROM empresa WHERE id = '${id}'`;
  return database.executar(instrucaoSql);
}

function listar() {
  var instrucaoSql = `SELECT id, nomeComercial, cnpj FROM empresa`;
  return database.executar(instrucaoSql);
}

function buscarPorCnpj(cnpj) {
  var instrucaoSql = `SELECT * FROM empresa WHERE cnpj = '${cnpj}'`;
  return database.executar(instrucaoSql);
}

function cadastrar(
  nomeComercial,
  cnpj,
  cep,
  logradouro,
  numero,
  complemento,
  bairro,
  cidade,
  uf
) {
  var instrucaoSql = `
    INSERT INTO empresa (
      nomeComercial, cnpj, cep, logradouro, numero, complemento, bairro, cidade, uf
    ) VALUES (
      '${nomeComercial}', '${cnpj}', '${cep}', '${logradouro}', '${numero}', '${complemento}', '${bairro}', '${cidade}', '${uf}'
    );
  `;
  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}

module.exports = {
  buscarPorCnpj,
  buscarPorId,
  cadastrar,
  listar,
};
