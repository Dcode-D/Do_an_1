const express = require('express');
const router = express.Router();
const {createCar, getCar, getCarById, updateCar, deleteCar, updateCarImage, deleteCarImage, carFilesExtOptions} = require('../controller/carController');
const utils_auth = require("../middleware/utils_auth");
const fileUploadMiddleware = require("../middleware/fileUpload");
const{confidentialFilesExtOptions, uploadConfidentialFiles, deleteConfidentialFiles, getConfidentialFilesById} = require('../controller/confidentialFileController');

// Get all cars queries maxPrice, minPrice, page
router.get('/', getCar);

// Get a specific car
router.get('/:id', getCarById);

router.use(utils_auth);
// Create a new car
router.post('/',[fileUploadMiddleware, carFilesExtOptions, createCar]);
// Update a specific car
router.put('/:id',updateCar);

// Delete a specific car
router.delete('/:id', deleteCar);
router.put('/update_img/:id',[fileUploadMiddleware, carFilesExtOptions ,updateCarImage]);
router.delete('/delete_img/:id', deleteCarImage);

//upload legal document
router.post('/legal_doc/:id',[fileUploadMiddleware, confidentialFilesExtOptions, uploadConfidentialFiles]);
router.get('/legal_doc/:id', getConfidentialFilesById);
router.delete('/legal_doc/:id', deleteConfidentialFiles);

module.exports = router;