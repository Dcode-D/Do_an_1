const passport = require('passport');
const passportJWT = require('passport-jwt');
const strategy = passportJWT.Strategy;
const extractJWT = passportJWT.ExtractJwt;
const jwtModel = require('../models/jwt_model')
const jwt = require('jsonwebtoken')
const userModel = require('../models/user_model')

const opts = {}
opts.jwtFromRequest = extractJWT.fromAuthHeaderAsBearerToken();
opts.secretOrKey = process.env.ACCESS_TOKEN_SECRET;

passport.use(new strategy(opts, async (jwt_payload, done)=>{
    if(!jwt_payload) return done(null,false);
    else {
        try {
            const user = await userModel.findOne({'username': jwt_payload.username});
            if (!user) return done(null, false);
            done(null, user);
        } catch (err) {
            return done(err, false);
        }
    }
}));

module.exports = passport;