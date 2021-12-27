import express from 'express'

const app = express()

app.use(express.json())
const PORT = process.env.PORT || 2022

app.get('/', (req, res) => {
    res.status(200).json({ data: 'Hi there!' })
})

app.listen(PORT, () => {
    console.log(`Server started on port ${PORT}`)
})
