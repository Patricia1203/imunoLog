var empresaModel = require("../models/empresaModel");

async function buscarPorCnpj(cnpj) {
  return await empresaModel.buscarPorCnpj(cnpj);
}

async function listar() {
  return await empresaModel.listar();
}

async function buscarPorId(id) {
  return await empresaModel.buscarPorId(id);
}

async function cadastrar(empresaData) {
  const {
    nomeComercial,
    cnpj,
    cep,
    logradouro,
    numero,
    complemento,
    bairro,
    cidade,
    uf,
  } = empresaData;

  const existente = await empresaModel.buscarPorCnpj(cnpj);
  if (existente.length > 0) {
    throw new Error(`Empresa com CNPJ ${cnpj} já existe`);
  }

  // Adaptar conforme seu model para passar todos esses campos
  const resultado = await empresaModel.cadastrar(
    nomeComercial,
    cnpj,
    cep,
    logradouro,
    numero,
    complemento,
    bairro,
    cidade,
    uf
  );

  // Assumindo que o resultado retorna o ID da empresa inserida
  return resultado.insertId || resultado.id || null;
}

module.exports = {
  buscarPorCnpj,
  buscarPorId,
  cadastrar,
  listar,
};
