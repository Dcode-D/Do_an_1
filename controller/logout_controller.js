const jwtModel = require('../models/jwt_model')

const logout_controller = async (req,res)=>{
    if(!req.headers.authorization.startsWith('Bearer ')) return res.sendStatus(401);
    const reqjwt = req.headers.authorization.split(' ')[1];

    if(!reqjwt){
        return res.sendStatus(204);
    }
    else {
        const filter = {"jwtdata":reqjwt}
        const update = {"revoked":true}
        try{
            const doc = await jwtModel.findOneAndUpdate(filter,update)
            if(doc)
                return res.status(200).json({'message':'log out success'})
            else
                return res.sendStatus(204)
        }
        catch (err){
            return res.status(500).json({'message':'Log out error'})
        }
    }
}

module.exports = logout_controller