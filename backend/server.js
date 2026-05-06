import express from 'express';
import helmet from 'helmet';
import morgan from 'morgan';
import { env } from './src/config/env.js';
import { corsMiddleware } from './src/config/cors.js';
import { errorMiddleware } from './src/middleware/error.middleware.js';
import { loggerMiddleware } from './src/middleware/logger.middleware.js';
import chatRoute from './src/routes/chat.route.js';
import brainRoute from './src/routes/brain.route.js';
import memoryRoute from './src/routes/memory.route.js';
import voiceRoute from './src/routes/voice.route.js';
import systemRoute from './src/routes/system.route.js';
import whatsappRoute from './src/routes/whatsapp.route.js';

const app = express();

app.use(helmet());
app.use(corsMiddleware);
app.use(express.json({ limit: '2mb' }));
app.use(express.urlencoded({ extended: true }));
app.use(morgan(env.nodeEnv === 'production' ? 'combined' : 'dev'));
app.use(loggerMiddleware);

app.get('/', (_req, res) => {
  res.json({ ok: true, app: 'Megan Life Backend', version: '5.0.0' });
});

app.get('/api/health', (_req, res) => {
  res.json({
    ok: true,
    app: 'Megan Life',
    version: '5.0.0',
    brain: true,
    geminiConfigured: Boolean(env.geminiApiKey),
    supabaseConfigured: Boolean(env.supabaseUrl && env.supabaseServiceRoleKey),
    timezone: env.defaultTimezone,
    time: new Date().toISOString(),
  });
});

app.use('/api/chat', chatRoute);
app.use('/api/brain', brainRoute);
app.use('/api/memory', memoryRoute);
app.use('/api/voice', voiceRoute);
app.use('/api/system', systemRoute);
app.use('/api/whatsapp', whatsappRoute);

app.use(errorMiddleware);

app.listen(env.port, () => {
  console.log(`Megan Life backend running on port ${env.port}`);
});
