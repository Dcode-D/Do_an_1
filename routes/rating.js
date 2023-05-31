const router = require('express').Router();
const {getRating,createRating,updateRating,deleteRating,getRatings, getMaxPage} = require('../controller/ratingController');
const authen = require('../middleware/utils_auth');

//query: service, user, rating to sort out
router.get('/',getRatings);
router.get('/:id',getMaxPage);
router.use(authen);
router.post('/',createRating);
router.put('/:id',updateRating);
router.delete('/:id',deleteRating);

module.exports = router;
