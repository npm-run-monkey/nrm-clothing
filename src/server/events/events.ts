onNet('nrm-clothing:client:server:sendPlayerClothing', async (pedData: string) =>
{
    const pNetId = global.source
    const cid = await global.exports["nrm-lib"].getPlayerCid(pNetId);

    console.log(cid);
});