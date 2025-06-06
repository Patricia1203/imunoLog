var database = require("../database/config");

function autenticar(email, senha) {
  var instrucaoSql = `
    SELECT idUsuario, nome, email, fkEmpresa as empresaId 
    FROM usuario 
    WHERE email = '${email}' AND senha = '${senha}';
  `;
  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}

function cadastrar(nome, email, senha, telefone1, telefone2, fkEmpresa) {
  // telefone2 pode ser NULL se não enviado
  telefone2 = telefone2 ? `'${telefone2}'` : "NULL";

  var instrucaoSql = `
    INSERT INTO usuario (
      nome, email, senha, telefone1, telefone2, fkEmpresa
    ) VALUES (
      '${nome}', '${email}', '${senha}', '${telefone1}', ${telefone2}, '${fkEmpresa}'
    );
  `;
  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}

module.exports = {
  autenticar,
  cadastrar,
};
