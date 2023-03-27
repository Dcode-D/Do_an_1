const passport = require('./passport_auth')
const jwtblacklist = require('./jwt_blacklist')

module.exports = [jwtblacklist,passport.authenticate('jwt',{session:false})]