const express = require("express");
const router = express.Router();
const dashboardController = require("../controllers/admin");

router.get("/kpis/:idEmpresa", dashboardController.kpis);
router.get("/graficoLinha/:idEmpresa", dashboardController.graficoLinha);
router.get("/graficoPizza/:idEmpresa", dashboardController.graficoPizza);
router.get("/alertasRecentes/:idEmpresa", dashboardController.alertasRecentes);

module.exports = router;
