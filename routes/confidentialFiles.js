const express = require('express');
const router = express.Router();
const FileUpload = require('../middleware/fileUpload');
const {confidentialFilesExtOptions, uploadConfidentialFiles, deleteConfidentialFiles, getConfidentialFilesById, getCredentialIdList} = require('../controller/confidentialFileController');
const auth = require('../middleware/utils_auth');

router.use(auth);
//upload legal document
router.post('/',[FileUpload, confidentialFilesExtOptions, uploadConfidentialFiles]);
router.get('/list', getCredentialIdList);
router.get('/id/:id', getConfidentialFilesById);
router.delete('/id/:id', deleteConfidentialFiles);

module.exports = router;