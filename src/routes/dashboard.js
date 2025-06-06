const express = require('express');
const router = express.Router();
const controller = require('../controllers/dashboardController');

// Rota base: /dashboard/:empresaId
router.get('/kpis/:empresaId', controller.kpis);
router.get('/ocorrenciasMensais/:empresaId', controller.ocorrenciasMensais);
router.get('/graficoStatusProtocolos/:empresaId', controller.statusProtocolos);
router.get('/graficoLinhaArduino/:empresaId', controller.graficoLinhaArduino);

module.exports = router;
