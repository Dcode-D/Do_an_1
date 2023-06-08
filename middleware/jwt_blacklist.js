const jwtModel = require('../models/jwt_model');

const verifyJWT = async (req, res, next) => {
    if(req.headers.authorization?.startsWith('Bearer ')){
        const token = req.headers.authorization.split(' ')[1];
        const filter = {"jwtdata": token};
        const foundjwt = await jwtModel.findOne(filter);
        if(foundjwt){
            console.log(foundjwt.jwtdata)
            if(foundjwt.revoked){
                return res.sendStatus(401);
            }
            else {
                 return next();
            }
        }
    }
    return res.sendStatus(401);
}

module.exports = verifyJWT;