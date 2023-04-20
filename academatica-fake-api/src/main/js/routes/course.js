const express = require('express');
const { join } = require('node:path');
const { readJson } = require('../utils');

const router = express.Router();

const dataPath = join(__dirname, '..', '..', 'json');
const classesData = join(dataPath, 'classes.json');
const topicsData = join(dataPath, 'topics.json');
const problemsData = join(dataPath, 'problems.json');
const tiersData = join(dataPath, 'tiers.json');

router.get('/classes/upcoming', (req, res) => {
    const classes = readJson(classesData);
    const upcomingClasses = classes.filter(item => item.isUnlocked && !item.isComplete).map(item => ({
        id: item.id,
        topicId: item.topicId,
        tierId: item.tierId,
        name: item.name,
        description: item.description,
        expReward: item.expReward,
        imageUrl: item.imageUrl,
        theoryUrl: item.theoryUrl,
        problemNum: item.problemNum,
        isAlgebraClass: item.isAlgebraClass,
        topicName: item.topicName,
        classNumber: item.classNumber,
        topicClassCount: item.topicClassCount
    }));

    res.status(200).send(upcomingClasses);
});

router.get('/topics/completed', (req, res) => {
    const topics = readJson(topicsData);
    const completedTopics = topics.filter(item => item.isComplete).map(item => ({
        id: item.id,
        tierId: item.tierId,
        name: item.name,
        description: item.description,
        imageUrl: item.imageUrl,
        isAlgebraTopic: item.isAlgebraTopic,
        tier: item.tier
    }));

    res.status(200).send(completedTopics);
});

router.get('/classes/:classId', (req, res) => {
    const classes = readJson(classesData);
    const requiredClass = classes.find(item => item.id === req.params.classId);

    if (!requiredClass) {
        res.status(404).send();
    }

    res.status(200).send({
        id: requiredClass.id,
        name: requiredClass.name,
        description: requiredClass.description,
        expReward: requiredClass.expReward,
        imageUrl: requiredClass.imageUrl,
        theoryUrl: requiredClass.theoryUrl,
        problemNum: requiredClass.problemNum,
        topicName: requiredClass.topicName,
        isComplete: requiredClass.isComplete,
        isUnlocked: requiredClass.isUnlocked
    });
});

router.get('/classes/:classId/problems', (req, res) => {
    const problems = readJson(problemsData);
    const classProblems = problems.filter(item => item.classId === req.params.classId);

    res.status(200).send({
        problems: classProblems
    });
});

router.get('/activity', (req, res) => {
    res.status(200).send({
        activityMatrix: {
            "2022-05-18T00:00:00+00:00": 3,
            "2022-05-17T00:00:00+00:00": 0,
            "2022-05-16T00:00:00+00:00": 0,
            "2022-05-15T00:00:00+00:00": 0,
        }
    });
});

router.get('/tiers', (req, res) => {
    const tiers = readJson(tiersData);

    res.status(200).send({
        tiers: tiers
    });
});

router.get('/tiers/:tierId', (req, res) => {
    const topics = readJson(topicsData);
    const tierTopics = topics.filter(item => item.tierId === req.params.tierId).map(item => ({
        isComplete: item.isComplete,
        isUnlocked: item.isUnlocked,
        classCount: item.classCount,
        id: item.id,
        name: item.name,
        description: item.description,
        imageUrl: item.imageUrl,
        isAlgebraTopic: item.isAlgebraTopic,
        completionRate: item.completionRate
    }));

    res.status(200).send({
        topics: tierTopics
    });
});

router.get('/topics/:topicId', (req, res) => {
    const classes = readJson(classesData);
    const topicClasses = classes.filter(item => item.topicId === req.params.topicId).map(item => ({
        id: item.id,
        name: item.name,
        description: item.description,
        expReward: item.expReward,
        imageUrl: item.imageUrl,
        theoryUrl: item.theoryUrl,
        problemNum: item.problemNum,
        topicName: item.topicName,
        isComplete: item.isComplete,
        isUnlocked: item.isUnlocked
    }));

    res.status(200).send({
        classes: topicClasses
    });
});

router.get('/practice/recommended', (req, res) => {
    const topics = readJson(topicsData);
    const recommendedTopic = topics.find(item => item.id === '1-0:1');

    res.status(200).send({
        recommendedTopic: {
            id: recommendedTopic.id,
            name: recommendedTopic.name,
            description: recommendedTopic.description,
            imageUrl: recommendedTopic.imageUrl,
            isAlgebraTopic: recommendedTopic.isAlgebraTopic,
            completionRate: recommendedTopic.completionRate
        }
    });
});

router.get('/practice/completed/problems', (req, res) => {
    const problems = readJson(problemsData);
    const topics = readJson(topicsData);

    const completedTopicsIds = topics.filter(item => item.isComplete).map(item => item.id);
    const completedTopicProblems = problems.filter(item => completedTopicsIds.includes(item.topicId)).slice(0, 10);

    res.status(200).send({
        problems: completedTopicProblems
    });
});

router.get('/practice/topic/problems', (req, res) => {
    const problems = readJson(problemsData);
    const topicProblems = problems.filter(item => item.topicId === req.query.topicId).slice(0, 10);

    res.status(200).send({
        problems: topicProblems
    });
});

router.post('/practice/custom/problems', (req, res) => {
    const problems = readJson(problemsData);
    const topicData = req.body.topicData;
    const practiceProblems = [];

    for (const topic in topicData) {
        practiceProblems.push(
            problems.filter(item => {
                return item.topicId === topic && item.difficulty === topicData[topic].difficulty
            }).slice(0, topicData[topic].count)
        );
    }

    res.status(200).send({
        problems: practiceProblems
    });
});

router.post('/classes/:classId/finish', (req, res) => {
    res.status(200).send({
        exp: 100,
        achievements: []
    });
});

router.post('/practice/finish', (req, res) => {
    res.status(200).send({
        exp: 50,
        buoyAdded: false
    }); 
});

module.exports = router;