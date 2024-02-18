const Delay = (ms: number) => new Promise(res => setTimeout(res, ms));

onNet('nrm-clothing:client:server:sendPlayerClothing', async (pedData: string) =>
{
    const pNetId = global.source;

    try
    {
        const cid = await global.exports['nrm-lib'].getPlayerCid(pNetId);
        const outfit = await global.exports['nrm-clothing'].doesPlayerHasOutfit(cid);

        if (outfit)
        {
            global.exports['nrm-db'].executeQuery(`UPDATE outfits SET outfit='${pedData}' WHERE cid='${cid}'`);
            return;
        }

        global.exports['nrm-db'].executeQuery(`INSERT INTO outfits (cid, outfit) VALUES ('${cid}', '${pedData}')`);
    }
    catch(e)
    {
        console.log(`An error occurred: ${e}`);
    }
});

onNet('nrm-lib:client:server:playerSpawned', async (player: number) =>
{
    const pNetId = player;

    await Delay(250)

    try
    {
        const cid: string = await global.exports['nrm-lib'].getPlayerCid(pNetId);

        if (await global.exports['nrm-clothing'].doesPlayerHasOutfit(cid))
        {

            const outfit: OutfitComponent[] = await global.exports['nrm-clothing'].getPlayerOutfitByCid(cid);

            global.exports['nrm-clothing'].setPlayerOutfit(pNetId, outfit);
        }

    }
    catch(e)
    {
        console.log(`An error occurred: ${e}`);
    }
});