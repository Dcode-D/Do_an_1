const express = require('express');
const router = express.Router();
const registerController = require('../controller/register_controller')

/* GET users listing. */
router.post('/',registerController)

module.exports = router;