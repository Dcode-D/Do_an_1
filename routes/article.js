const express = require('express')
const router = express.Router()
const fileUpload = require('../middleware/fileUpload')
const {createArticle,articleFileExt , deleteArticle, getArticleById, getArticle, articleImageExt, updateArticleInfo, getMaxPage,deleteArticleImage,uploadArticleImage} = require('../controller/articleController');
const auth = require('../middleware/utils_auth')

router.get('/:id', getArticleById)
// router.get('/content/:id', getArticleContent)
//can apply queries to get article
router.get('/page/:page', getArticle)
router.get('/page', getMaxPage)
router.use(auth)
router.post('/', [fileUpload, articleImageExt, createArticle])
router.post('/upload_img/:id', [fileUpload, articleFileExt, uploadArticleImage])
router.delete('/:id', deleteArticle)
router.delete('/delete_img/:id', deleteArticleImage)
router.put('/info/:id',  updateArticleInfo)

module.exports = router