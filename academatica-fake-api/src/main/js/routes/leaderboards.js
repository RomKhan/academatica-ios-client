const express = require('express');
const router = express.Router();

router.get('/bronze', (req, res) => {
    res.status(200).send({
        leaderboard: []
    });
});

router.get('/silver', (req, res) => {
    res.status(200).send({
        leaderboard: []
    });
});

router.get('/gold', (req, res) => {
    res.status(200).send({
        leaderboard: []
    });
});

router.get('/:userId', (req, res) => {
    res.status(200).send({
        league: 'none',
        rank: 0
    });
});


module.exports = router;