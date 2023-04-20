const express = require('express');
const connectRoutes = require('./routes/connect');
const usersRoutes = require('./routes/users');
const courseRoutes = require('./routes/course');
const leaderboardsRoutes = require('./routes/leaderboards');

const app = express();
const port = process.env.API_PORT || 8081;

app.use(express.json());
app.use('/connect', connectRoutes);
app.use('/api/users', usersRoutes);
app.use('/api/course', courseRoutes);
app.use('/api/leaderboard', leaderboardsRoutes);

app.get('/healthcheck', (req, res) => {
    res.status(200).send({
        result: 'success'
    });
});

app.listen(port, () => {
    console.log(`Fake API listening on port ${port}`);
});