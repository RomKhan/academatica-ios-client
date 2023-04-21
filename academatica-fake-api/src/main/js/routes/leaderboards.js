const express = require('express');
const router = express.Router();

router.get('/bronze', (req, res) => {
    res.status(200).send({
        leaderboard: [
            {
                "rank": 1,
                "firstName": "Test",
                "lastName": "Testovich",
                "username": "Test",
                "expThisWeek": 100,
                "profilePic": "https://upload.wikimedia.org/wikipedia/commons/thumb/b/bc/Unknown_person.jpg/925px-Unknown_person.jpg",
                "userId": 0
            }
        ]
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
        league: 'bronze',
        rank: 1
    });
});


module.exports = router;