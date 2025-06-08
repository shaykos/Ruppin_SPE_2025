import { rateLimit } from 'express-rate-limit';

export const apiLimiter = rateLimit({
  windowMs: 60 * 60 * 1000, // 1 hour
  max: 2,
  standardHeaders: true,
  legacyHeaders: false,
  keyGenerator: function (req) {
    // return the user id (or token) for the request here
  },
  message: {txt: "You F***ing Hacker. Gocha!"}
});

