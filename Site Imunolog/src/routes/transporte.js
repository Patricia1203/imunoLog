const express = require('express');
const router = express.Router();
const TransporteController = require('../controllers/TransporteController');

router.get('/:idEmpresa', TransporteController.listar);
router.post('/cadastrar', TransporteController.cadastrar);

module.exports = router;
