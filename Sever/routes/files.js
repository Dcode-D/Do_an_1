const router = require('express').Router();
const {getFilesById} = require('../controller/filesController');

router.get('/:id', getFilesById);

module.exports = router;