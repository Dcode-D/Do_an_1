const express = require('express')
const router = express.Router()
const fileUpload = require('../middleware/fileUpload')
const {createArticle,articleFileExt , deleteArticle, getArticleById, getArticle, articleImageExt, uploadArticle, updateArticle, updateArticleInfo, getArticleContent, getMaxPage} = require('../controller/articleController');
const auth = require('../middleware/utils_auth')

router.get('/:id', getArticleById)
// router.get('/content/:id', getArticleContent)
//can apply queries to get article
router.get('/page/:page', getArticle)
router.get('/page', getMaxPage)
router.get('/content/:id', getArticleContent)
router.use(auth)
router.post('/', [fileUpload, articleImageExt, createArticle])
router.post('/upload/:id', [fileUpload, articleFileExt, uploadArticle])
router.delete('/:id', deleteArticle)
router.put('info/:id', [fileUpload, articleImageExt, updateArticleInfo])
router.put('/:id', [fileUpload, articleFileExt, updateArticle])

module.exports = router