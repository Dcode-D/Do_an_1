const jwtModel = require('../models/jwt_model')
const jwt = require('jsonwebtoken')

const refresh_controller = async (req, res)=>{
    if(!req.headers.authorization.startsWith('Bearer ')) return res.sendStatus(401);
    const body = req.body;
    const reqjwt = req.headers.authorization.split(' ')[1];
    if(!reqjwt){
        return res.sendStatus(400);
    }
    else {
        const filter = {"jwtdata": reqjwt}
        const update = {"revoked": true}
        try {
            await jwtModel.findOneAndUpdate(filter, update)
        } catch (err) {
            return res.status(500).json({'message': 'Error'})
        }

        jwt.verify(reqjwt,
            process.env.ACCESS_TOKEN_SECRET,
            (err, decoded) => {
                if (err)
                    return res.sendStatus(500);
                else {
                    if (body.device != decoded.device) {
                        return res.sendStatus(401);
                    } else {
                        const accesstoken = jwt.sign({
                            "username": decoded.username,
                            "id": decoded._id,
                            "device": decoded
                        }, process.env.ACCESS_TOKEN_SECRET, {expiresIn: '1d'});
                        return res.status(200).json({"auth": accesstoken});
                    }
                }
            }
        )
    }
}

module.exports= refresh_controller