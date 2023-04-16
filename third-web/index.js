import { ThirdwebSDK } from "@thirdweb-dev/sdk/solana";
import express, { response } from "express";

const app = express();
const privateKey = "3RDyXCEMWfuYi4VbJkR2bQoV6ABKg5fL4eVtJaw9gRiDvXtPXpxj6omBHrt2PonzvMAeom5G8beAjAWvhYVxDYLR";
const collection_ID = "HzRWELnybXBfe1iYDtGzex1UJXQmNmbtXS2L5XTttBxZ"
app.use(express.json());
const sdk = ThirdwebSDK.fromNetwork("devnet");

const program = await sdk.getProgram(collection_ID, "nft-drop");


app.get('/claim', async (req, res) => {
    const address = req.query.address;
    const sdk = ThirdwebSDK.fromPrivateKey("devnet", privateKey);
    const program = await sdk.getProgram(collection_ID, "nft-drop");

    const claimedAddresses = await program.claimTo(address, 1); 
    var addObj = { "claimedAddresses": claimedAddresses[0] };
    res.send(addObj);
});

app.get('/nft/all', async (req, res) => {
    const sdk = ThirdwebSDK.fromPrivateKey("devnet", privateKey);
    const program = await sdk.getProgram(collection_ID, "nft-drop");
    const nfts = await program.getAll();
    res.send(nfts);
});

app.get('/nft', async (req, res) => {
    const address = req.query.address;
    const sdk = ThirdwebSDK.fromPrivateKey("devnet", privateKey);
    const program = await sdk.getProgram(collection_ID, "nft-drop");
    const nfts = await program.get(address);
    res.send(nfts);
});

app.listen(3000, async () => {
    console.log("Listening on port 3000");
    const nfts = await program.getAll();
    const claimedAddresses = await program.claimTo("5Mtb2iL6gksptiGUneX2axoew8PpKjTRSMjRQGTp2fiR", 1);
    console.log("Claimed NFT at address", claimedAddresses[0]);
});