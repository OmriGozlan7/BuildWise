import { PrismaClient } from "@prisma/client";

const prisma = new PrismaClient();

async function main() {
  // Create sample projects
  const project = await prisma.project.create({
    data: {
      name: "BuildWise Tower",
      address: "123 Main St",
      startDate: new Date("2025-01-01"),
      endDatePlanned: new Date("2026-01-01"),
      notes: "Demo project for testing",
    },
  });

  // Create sample buyers
  const buyer1 = await prisma.buyer.create({
    data: {
      name: "John Doe",
      email: "john@example.com",
      phone: "050-1234567",
      idNumber: "123456789",
    },
  });

  const buyer2 = await prisma.buyer.create({
    data: {
      name: "Jane Smith",
      email: "jane@example.com",
      phone: "052-9876543",
      idNumber: "987654321",
    },
  });

  console.log("✅ Seed completed with project and buyers");
}

main()
  .catch((e) => {
    console.error(e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
