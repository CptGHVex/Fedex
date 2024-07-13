const express = require('express');
const fetch = require('node-fetch');
const { GoogleAuth } = require('google-auth-library');
const cors = require('cors');
const app = express();
const port = process.env.PORT || 8080;

const auth = new GoogleAuth({
    scopes: 'https://www.googleapis.com/auth/cloud-platform'
});

app.use(cors());
app.use(express.json());

app.post('/generate_fedex_label', async (req, res) => {
    console.log('Received request body:', req.body);
    const requestBody = req.body;

    try {
        const client = await auth.getClient();
        const token = await client.getAccessToken();

        const response = await fetch('https://us-central1-labelgeneration.cloudfunctions.net/generate_fedex_label', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${token.token}`,
            },
            body: JSON.stringify(requestBody),
        });

        if (!response.ok) {
            throw new Error(`HTTP error! status: ${response.status}`);
        }

        const data = await response.json();
        res.json(data);
    } catch (error) {
        console.error('Error:', error);
        res.status(500).send('Internal Server Error');
    }
});

app.listen(port, () => {
    console.log(`Server running on port ${port}`);
});