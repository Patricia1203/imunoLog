var express = require("express");
var router = express.Router();
var protocoloController = require("../controllers/protocoloController");

router.get("/", protocoloController.listar);
router.get("/:id", protocoloController.buscarPorId);
router.post("/", protocoloController.cadastrar);
router.put("/:id", protocoloController.atualizar);
router.delete("/:id", protocoloController.deletar);

module.exports = router;
