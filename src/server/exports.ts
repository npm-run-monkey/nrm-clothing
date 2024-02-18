global.exports('doesPlayerHasOutfit', (cid: string): Promise<boolean> =>
{
    return new Promise(async (res, rej) =>
    {
        try
        {
            const resp: QueryRes<string> = await global.exports['nrm-db'].executeAsyncQuery(`SELECT cid FROM outfits WHERE cid='${cid}'`);

            if (resp.rowCount > 0)
            {
                res(true);
            }

            res(false);
            
        }
        catch(e)
        {
            rej(`[Func doesPlayerHasOutfit] - ${e}`);
        }
    })
});

global.exports('getPlayerOutfitByCid', (cid: string): Promise<OutfitComponent[]> =>
{
    return new Promise(async (res, rej) =>
    {
        try
        {
            const resp: QueryRes<getPlayerOutfitByCidRes> = await global.exports['nrm-db'].executeAsyncQuery(`SELECT outfit FROM outfits WHERE cid='${cid}'`);

            if (resp.rowCount > 0)
            {
                res(JSON.parse(resp.rows[0].outfit) as OutfitComponent[]);
            }

            rej(`[Func getPlayerOutfitByCid] - No outfit ...`)
        }
        catch(e)
        {
            rej(`[Func getPlayerOutfitByCid] - ${e}`);
        }
    })
});

global.exports('setPlayerOutfit', (pNetId: number, outfit: OutfitComponent[]): void =>
{
    const ped = GetPlayerPed(pNetId.toString());

    outfit.forEach((comp: OutfitComponent, index: number) =>
    {
        if (comp.type == "item")
        {
            SetPedComponentVariation(ped, comp.componentId, comp.drawable, comp.texture, 0); 
        }

        if (comp.type == "prop")
        {
            SetPedPropIndex(ped, comp.componentId, comp.drawable, comp.texture, true);
        }
    });
});