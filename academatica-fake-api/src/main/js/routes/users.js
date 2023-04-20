const express = require('express');
const router = express.Router();

router.get('/:userId', (req, res) => {
    res.status(200).send({
        email: "test@test.com",
        profilePicUrl: "https://upload.wikimedia.org/wikipedia/commons/thumb/b/bc/Unknown_person.jpg/925px-Unknown_person.jpg",
        username: "Test",
        firstName: "Test",
        lastName: "Testovich",
        exp: 0,
        expThisWeek: 0,
        level: 1,
        levelName: "newcomer",
        expLevelCap: 300,
        maxLevelReached: false
    });
});

router.get('/:userId/state', (req, res) => {
    res.status(200).send({
        buoysLeft: 5,
        daysStreak: 0
    });
});

router.get('/:userId/buoys', (req, res) => {
    res.status(200).send({
        buoysLeft: 5
    });
});

router.get('/:userId/achievements', (req, res) => {
    res.status(200).send({
        achievements: [
            {
                name: "Triple strike",
                description: "Finish three classes in one day",
                imageUrl: "https://i.postimg.cc/4db1ytk8/upward-arrow.png",
                achievedAmount: 1
            },
            {
                name: "Pushing forward",
                description: "Finish your first topic",
                imageUrl: "https://i.postimg.cc/MGtkBcSG/graphic-progression.png",
                achievedAmount: 1
            }
        ]
    });
});

router.get('/:userId/email/confirmation-code', (req, res) => {
    res.status(200).send({
        success: 'true'
    });
});

router.get('/:userId/password/confirmation-code', (req, res) => {
    res.status(200).send({
        success: 'true'
    });
});

router.post('/:userId/email/confirmation-code', (req, res) => {
    res.status(200).send();
});

router.post('/:userId/password/confirmation-code', (req, res) => {
    res.status(200).send();
});

router.patch('/:userId/image', (req, res) => {
    res.status(200).send();
});

router.patch('/:userId/username', (req, res) => {
    res.status(200).send();
});

router.patch('/:userId/firstname', (req, res) => {
    res.status(200).send();
});

router.patch('/:userId/lastname', (req, res) => {
    res.status(200).send();
});

router.patch('/:userId/email', (req, res) => {
    res.status(200).send({
        confirmationPending: false,
        success: true,
        error: null
    });
});

router.patch('/:userId/password', (req, res) => {
    res.status(200).send({
        success: true,
        error: null
    });
});

router.patch('/:userId/password/restore', (req, res) => {
    res.status(200).send({
        confirmationPending: false,
        success: true,
        error: null
    });
});

router.patch('/:userId/buoys', (req, res) => {
    res.status(200).send();
});

module.exports = router;