import express from "express";
import cors from "cors";
import dotenv from "dotenv";
import axios from "axios";

dotenv.config();

const app = express();
app.use(cors());
app.use(express.json());

const BASE_URL = "https://cybqa.pesapal.com/pesapalv3/api";   // Sandbox

// Fixed getToken
const getToken = async () => {
    try {
        const response = await axios.post(`${BASE_URL}/Auth/RequestToken`, {
            consumer_key: process.env.PESAPAL_CONSUMER_KEY,
            consumer_secret: process.env.PESAPAL_CONSUMER_SECRET,
        });

        if (!response.data?.token) {
            throw new Error("No token returned from Pesapal");
        }

        console.log("✅ Token obtained successfully");
        return response.data.token;
    } catch (err) {
        console.error("❌ Token Request Failed:");
        console.error("Status:", err.response?.status);
        console.error("Pesapal Message:", err.response?.data?.message || err.message);
        throw new Error("Failed to get Pesapal access token. Check your consumer_key and consumer_secret.");
    }
};

app.post("/api/pay", async (req, res) => {
  try {
    const { amount, phone, email, username, description } = req.body;

    console.log("📥 Received from Flutter:", req.body);

    if (!amount) return res.status(400).json({ error: "Missing amount" });
    if (!phone) return res.status(400).json({ error: "Missing phone" });
    if (!email) return res.status(400).json({ error: "Missing email" });

    const token = await getToken();

    // Clean payload - NO notification_id at all
    const payload = {
      id: `order-${Date.now()}`,
      currency: "UGX",
      amount: parseFloat(amount),
      description: description || "Order Payment",
      callback_url: "myapp://payment/complete",
      // notification_id: process.env.PESAPAL_IPN_ID || null, // Explicitly set to null to avoid any issues
      billing_address: {
        email_address: email,
        phone_number: phone,
        first_name: username || "Customer",
        last_name: "",
        country_code: "UG",
      },
    };

    console.log("🚀 Sending to Pesapal (NO notification_id):");
    console.log(JSON.stringify(payload, null, 2));

    const orderResponse = await axios.post(
      `${BASE_URL}/Transactions/SubmitOrderRequest`,
      payload,
      {
        headers: {
          Authorization: `Bearer ${token}`,
          "Content-Type": "application/json",
        },
      }
    );

    console.log("✅ Pesapal Success! Redirect URL received");
    res.json(orderResponse.data);

  } catch (error) {
    console.error("❌ FULL ERROR DETAILS:");
    console.error("Error Message:", error.message);

    if (error.response) {
      console.error("Status:", error.response.status);
      console.error("Pesapal Error:", JSON.stringify(error.response.data, null, 2));
    }

    res.status(500).json({
      error: error.response?.data || error.message
    });
  }
});

app.listen(3000, () => {
    console.log("✅ Server is running on http://localhost:3000");
});