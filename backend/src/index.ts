import express, { type Request, type Response } from "express";
import cors from "cors";
import { PrismaClient } from "@prisma/client";

const app = express();
const prisma = new PrismaClient();

app.use(cors());
app.use(express.json());

// Health check
app.get("/health", (_req: Request, res: Response) => {
  res.status(200).send("ok");
});

// Example route: fetch all buyers
app.get("/buyers", async (_req: Request, res: Response) => {
  try {
    const buyers = await prisma.buyer.findMany();
    res.json(buyers);
  } catch (error) {
    res.status(500).json({ error: "Failed to fetch buyers" });
  }
});

const port = Number(process.env.PORT) || 4000;
app.listen(port, () => {
  console.log(`✅ Backend is running on http://localhost:${port}`);
});
