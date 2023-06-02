const express = require('express');
const router = express.Router();
const auth = require('../middleware/utils_auth');
const {createFavorite, getUserFavoriteId, deleteFavorite, getFavorite} = require('../controller/favoriteController');

router.use(auth);
//{element} in body
router.post('/:type', createFavorite);
router.get('/id/:id', getFavorite);
router.get('/user/:type', getUserFavoriteId);
router.delete('/:id', deleteFavorite);

module.exports = router;