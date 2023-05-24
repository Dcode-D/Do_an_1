const express = require('express')
const router = express.Router()
const fileUpload = require('../middleware/fileUpload')
const {createArticle,articleFileExt , deleteArticle, getArticleById, getArticle, articleImageExt, uploadArticle, updateArticle, updateArticleInfo} = require('../controller/articleController');
const auth = require('../middleware/utils_auth')

router.get('/:id', getArticleById)
//can apply queries to get article
router.get('/page/:page', getArticle)
router.use(auth)
router.post('/', [fileUpload, articleImageExt, createArticle])
router.post('/upload/:id', [fileUpload, articleFileExt, uploadArticle])
router.delete('/:id', deleteArticle)
router.put('info/:id', [fileUpload, articleImageExt, updateArticleInfo])
router.put('/:id', [fileUpload, articleFileExt, updateArticle])

module.exports = router