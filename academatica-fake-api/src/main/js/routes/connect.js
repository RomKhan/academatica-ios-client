const express = require('express');
const router = express.Router();

router.post('/register', (req, res) => {
    res.status(200).send();
});

router.post('/token', (req, res) => {
    res.status(200).send({
        access_token: 'test',
        refresh_token: 'test',
        expires_in: '300',
        token_type: 'Bearer',
        scope: 'Academatica.Api offline_access openid'
    });
});

router.get('/userinfo', (req, res) => {
    res.status(200).send({
        sub: '0'
    });
})

module.exports = router;